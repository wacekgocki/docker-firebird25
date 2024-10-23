#!/bin/sh

docker run \
 --detach \
 --name firebird25 \
 --publish 3050:3050 \
 --publish 3051:3051 \
 --mount source=/home/wacek/firebird-data,target=/data \
 --rm \
 firebird25:latest
