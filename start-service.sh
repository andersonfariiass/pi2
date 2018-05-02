#!/bin/bash

#HORA=$(date +"%d-%m-%y %H:%M")
LOG="/vagrant/docker/init_$1.log"

cd /vagrant/docker

#verfica se o $LOG existe, caso contrario cria o $LOG
if ! [ -f "$LOG" ]
then
	touch $LOG
fi

#Iniciando ambiente com docker-compose
echo -e "\n################################" >> $LOG 2>&1
echo -e "# iniciando ambiente           #" >> $LOG 2>&1
echo -e "################################" >> $LOG 2>&1

sudo docker-compose up -d >> $LOG 2>&1
