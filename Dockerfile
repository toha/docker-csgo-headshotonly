FROM edenservers/docker-csgo
ADD start.sh /tmp/start2.sh
RUN chmod 755 /tmp/start2.sh
CMD ["/tmp/start2.sh"]
VOLUME /server/
