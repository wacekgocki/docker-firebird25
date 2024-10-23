#!/usr/bin/env bash
set -e

trap 'kill -TERM "$FBPID"' SIGTERM

/opt/firebird/bin/fbguard &

FBPID=$!

wait "$FBPID"
