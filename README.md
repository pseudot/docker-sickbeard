# Sickbeard on Centos 6.5 docker container

## Docker container for running sickbeard.
  
  Access via https://localhost:43080/home

  Defaults to /mnt/multimedia/tv for TV Shows
  
  SSL certificate are enabled with a self-signed certificate.

## Requires 
  Docker 1.3+

## Container setup

  When running these items should be exposed or mapped.
  
  Volumes
     
    - /var/logs/                for log files
  
    - /mnt/media                mapped to the media files

  Map Ports
    - 8081 ->  43080         SickBeard page
  
    - 9001 ->  43091         supervisor page

## To build container

  > docker build --rm=true -t="sickbeard" .

## To run container

  > docker run --name sickbeard -v /mnt/media:/container/media  -p 43091:9091 -p 43080:8081

## Backup config file

  > CONT=`docker ps -a | grep sickbeard | awk '{ print $1 }'`
  > docker cp $CONT:/opt/sickbeard/config.ini $PWD
  > docker cp $CONT:/opt/sickbeard/sickbeard.db $PWD

## Extract autoProcess script

  > CONT=`docker ps -a | grep sickbeard | awk '{ print $1 }'`
  > docker cp $CONT:/opt/sickbeard/autoProcessTV/ $PWD