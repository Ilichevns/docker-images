#!/bin/bash

export DG_RUNTIME_DIR=/run/user/1000
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

dbus-daemon --session --address=$DBUS_SESSION_BUS_ADDRESS --nofork --nopidfile --syslog-only &

ps ux 

export DISPLAY=:0
export PULSE_SERVER=unix:/run/user/1000/pulse/native

# for i in seq 1 10; do echo $i; sleep 2; done;

id

chromium 

