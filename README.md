## Build image
```
docker build -t csgo_headshotonly .
```


## Create data only container
```
docker create --name csgo-data csgo_headshotonly
```

Never run the data container! It only helps us with Backups and Updates.

## Run

```
docker run --name csgo-run \
  --volumes-from csgo-data \
  -e GAME_TYPE=0 \
  -e GAME_MODE=1 \
  -e MAPGROUP=mg_bomb \
  -e MAP=de_dust2 \
  -e USERNAME=NOT_IMPORTANT \
  -e PASSWORD=NOT_IMPORTANT \
  -e STARTUP_OPTIONS='+rcon_password $RCON_PASSWORD +sv_password $SV_PASSWORD +host_workshop_map 546623875 -authkey $AUTH_KEY -maxplayers_override 32 -tickrate 128' \
  -p 27015:27015 \
  -p 27015:27015/udp \
  -d tha_csgo
```

Environment Variables ```USERNAME``` and ```PASSWORT``` are not important for this image. They are used in the parent image (edenservers/docker-csgo) for setting up and SFTP connection to the Container, which is not needed. The SFTP-Ports are not exposed if you use this run command.

Replace ```$RCON_PASSWORD```, ```$SV_PASSWORD``` with your server passwords and ```$AUTH_KEY``` with your steam auth key.

The Startup might take a few minutes, cause it tries to update steamcmd and csgo.

## Restart / Update
```
docker stop csgo-run && docker rm csgo-run && docker run [...](look above)
```


