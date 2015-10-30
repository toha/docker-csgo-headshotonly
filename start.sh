#!/bin/bash

#Setting up SFTP
if ! id -u "$USERNAME" >/dev/null 2>&1; then
    PASSWORD=$(perl -e 'print crypt($ARGV[0], "password")' $PASSWORD)
    useradd -d /server/csgo --shell /usr/bin/rssh --password $PASSWORD $USERNAME
    chown -R $USERNAME:$USERNAME /server/csgo
fi

/etc/init.d/ssh start

cd /server/steamcmd && ./steamcmd.sh +login anonymous \
                 +force_install_dir /server/csgo \
                 +app_update 740 validate \
                 +quit

mkdir -p /server/csgo/csgo/addons && \
cp -r /tmp/headshot/addons/*  /server/csgo/csgo/addons/ && \
cp -r /tmp/headshot/cfg/* /server/csgo/csgo/cfg/ && \
cp -r /tmp/headshot/sound/ /server/csgo/csgo/ && \
cp /tmp/headshot/headshotonly.smx /server/csgo/csgo/addons/sourcemod/plugins/ && \
cp /tmp/headshot/headshotonly.sp /server/csgo/csgo/addons/sourcemod/scripting/ && \
cp /tmp/headshot/headshotonly.phrases.txt /server/csgo/csgo/addons/sourcemod/translations/

cd /server/csgo && ./srcds_run -game csgo -console -usercon +game_type $GAME_TYPE \
                               +game_mode $GAME_MODE \
                               +mapgroup $MAPGROUP \
                               +map $MAP  $STARTUP_OPTIONS
