# First stage: Copy the files and change their ownership
FROM cm2network/steamcmd:root as builder

ARG SERVER_FILES
ARG SAVE_STATE_MOUNT_POINT
ARG SERVER_RUN_LOCATION
ARG STEAM_CLIENT
ARG SETTINGS_FILE

COPY --chown=steam:steam ${SERVER_FILES} /palworld

RUN apt-get update && \
	apt-get -y install --no-install-recommends lib32gcc-s1 lib32stdc++6 lib32z1 s3cmd cron && \
	rm -rf /var/lib/apt/lists/*

RUN chmod +x "${SERVER_RUN_LOCATION}"

RUN mkdir ~/.steam
RUN ln -s ${STEAM_CLIENT} /home/steam/.steam/sdk64
RUN chown -R steam:steam /home/steam

COPY --chown=steam:steam --chmod=+x ./scripts ./scripts

VOLUME ["${SAVE_STATE_MOUNT_POINT}"]

ENV SAVE_STATE_MOUNT_POINT=${SAVE_STATE_MOUNT_POINT} \
    SERVER_RUN_LOCATION=${SERVER_RUN_LOCATION} \
    SETTINGS_FILE=${SETTINGS_FILE}

ENTRYPOINT ./scripts/entry.sh