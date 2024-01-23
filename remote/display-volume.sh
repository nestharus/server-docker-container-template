#!/bin/bash

volume=${1:-}

docker run --rm -v ${volume}:/volume alpine ls -laR /volume