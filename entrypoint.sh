#!/bin/sh

UID=${LOCAL_USER_ID:-9001}
GID=${LOCAL_GROUP_ID:-9001}

echo "Starting with UID : $UID, GID : $GID"

groupmod -g $GID rustuser 
usermod -u $UID -g $GID rustuser

su-exec rustuser:$UID "$@"
