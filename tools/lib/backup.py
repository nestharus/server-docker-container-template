import os
import tarfile
import io


def fetch_backup_filenames(s3, bucket, volume):
    response = s3.list_objects_v2(Bucket=bucket, Prefix=volume)

    files = [content['Key'] for content in response.get('Contents', []) if content['Key'].startswith(prefix)]
    files = sorted(files, key=lambda file: os.path.basename(file), reverse=True)

    return files


def fetch_backup(s3, bucket, file_name):
    response = s3.get_object(Bucket=bucket, Key=file_name)
    file_data = response['Body'].read()

    return file_data


def decompress_backup(file_data):
    file_obj = io.BytesIO(file_data)
    files = {}
    tar_info = {}

    with tarfile.open(fileobj=file_obj, mode='r:gz') as tar:
        for member in tar.getmembers():
            if member.isfile():
                # Extract each member to a file-like object
                f = tar.extractfile(member)
                if f is not None:
                    # Read the content of the file-like object into a bytes object
                    content = f.read()
                    # Store the file data in the dictionary
                    files[member.name] = content
            elif member.isdir():
                # Store the directory in the dictionary with a value of None
                files[member.name] = None
            # Store the TarInfo object in the dictionary
            tar_info[member.name] = member

    return files, tar_info


def compress_backup(files, tar_info):
    tar_data = io.BytesIO()

    # Open the tarfile and add files
    with tarfile.open(fileobj=tar_data, mode='w:gz') as tar:
        for file_name, file_content in files.items():
            # Get the TarInfo object for the file
            info = tar_info[file_name]
            # Add the file to the tarball
            tar.addfile(info, io.BytesIO(file_content))

    # Seek back to the start of the BytesIO object
    tar_data.seek(0)

    return tar_data


def dump_backup(directory, files, tar_info):
    if not os.path.exists(directory):
        os.makedirs(directory)

    for file_name, file_content in sorted(files.items()):
        info = tar_info[file_name]
        path = directory + file_name.lstrip('.')

        if info.isdir():
            os.makedirs(path, exist_ok=True)
        elif info.isfile():
            with open(path, 'wb') as f:
                f.write(file_content)
