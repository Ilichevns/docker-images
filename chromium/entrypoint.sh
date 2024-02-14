#!/bin/bash

export XDG_RUNTIME_DIR=/run/user/1000

/etc/init.d/dbus start


mkdir $XDG_RUNTIME_DIR
# chmod 700 $XDG_RUNTIME_DIR
chown 1000:1000 $XDG_RUNTIME_DIR

# ps -ef | grep dbus

# while : ; do date; sleep 1; done;

su -c /usr/bin/chromium-start.sh -l chromium
