FROM edenservers/docker-csgo
RUN mkdir -p /tmp/headshot
ADD addons/ /tmp/headshot/addons
ADD cfg/ /tmp/headshot/cfg
ADD headshot/addons/sourcemod/plugins/headshotonly.smx /tmp/headshot/headshotonly.smx
ADD headshot/addons/sourcemod/scripting/headshotonly.sp /tmp/headshot/headshotonly.sp
ADD headshot/addons/sourcemod/translations/headshotonly.phrases.txt /tmp/headshot/headshotonly.phrases.txt
ADD headshot/sound/ /tmp/headshot/sound
ADD start.sh /tmp/start2.sh
RUN chmod 755 /tmp/start2.sh
CMD ["/tmp/start2.sh"]
VOLUME /server/

