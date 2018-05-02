#!/bin/bash

####################################################
# Script para configurações necessarias ao ambiente#
# fonte: https://gtihub.com/andersonfariiass       #
####################################################

echo

HORARIO=$(date +"%d-%m-%y %H:%M")
LOG="/vagrant/init_$1.log"

#check log

if ! [ -f "$LOG" ]
then
	touch $LOG
fi
echo -e "\n######################################" >> $LOG
echo -e  "# VM $1 iniciada | $HORARIO  #" >> $LOG
echo -e  "#####################################\n" >> $LOG

#Atulizando o repositorios
echo -e "\n####################################" >> $LOG
echo -e "# Atualização dos repositorios     #" >> $LOG
echo -e "####################################\n" >> $LOG

sudo apt-get update >> $LOG 2>&1

#Atulização da disto
echo -e "\n#############################" >> $LOG
echo -e "# Atualizando a Distro      #" >> $LOG
echo -e "#############################\n" >> $LOG

sudo apt-get dist-upgrade -y >> $LOG 2>&1

# Configação de data/hora e fuso horario
echo -e "\n##############################################################" >> $LOG
echo -e "# Configurando data, hora e fuso horario America/Maceio      #" >> $LOG
echo -e "##############################################################\n" >> $LOG

sudo apt-get install ntpdate -y >> $LOG 2>&1
sudo ln -sf /usr/share/zoneinfo/America/Maceio /etc/localtime 
sudo sed -i 's/NTPDATE_USE_NTP_CONF=yes/NTPDATE_USE_NTP_CONF=no/g' /etc/default/ntpdate
sudo sed -i 's/ntp.ubuntu.com/pool.ntp.br/g' /etc/default/ntpdate
sudo ntpdate pool.ntp.br >> $LOG 2>&1
sudo locale-gen pt_BR.UTF-8 >> $LOG 2>&1

#instalando o docker
echo -e "\n#############################" >> $LOG
echo -e "# Instalação do Docker      #" >> $LOG
echo -e "#############################\n" >> $LOG

sudo curl -fsSL https://get.docker.com/ | sh >> $LOG 2>&1

#Ativa o serviço do docker
echo -e "\n###################################" >> $LOG
echo -e "# Ativando servico do docker      #" >> $LOG
echo -e "###################################\n" >> $LOG

sudo systemctl enable docker >> $LOG 2>&1
sudo systemctl start docker >> $LOG 2>&1

#Instalando o docker compose
echo -e "\n#####################################" >> $LOG
echo -e "# Instalação do docker compose      #" >> $LOG
echo -e "#####################################\n" >> $LOG

sudo curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose >> $LOG 2>&1


#Permissão de exec no docker compose
echo -e "\n######################################################" >> $LOG
echo -e "# Dando permissão de execução ao docker-compose      #" >> $LOG
echo -e "######################################################\n" >> $LOG

sudo chmod +x /usr/local/bin/docker-compose >> $LOG 2>&1

#Limpeza da cahce dos pacotes
echo -e "\n#####################################" >> $LOG
echo -e "# Limpando o cache dos pacotes      #" >> $LOG
echo -e "#####################################" >> $LOG

sudo apt-get autoclean -y >> $LOG 2>&1

#Download dos arquivos docker no github
echo -e "\n#############################" >> $LOG
echo -e "# Download do GitHub        #" >> $LOG
echo -e "#############################" >> $LOG

cd /tmp/
git clone https://github.com/andersonfariiass/compose-file.git >> $LOG 2>&1

sudo mv compose-file/docker-compose.yml /vagrant/docker/docker-compose.yml >> $LOG 2>&1
sudo mv compose-file/index.php /vagrant/docker/www/html/index.php >> $LOG 2>&1

cd /vagrant/docker/

echo -e "\n########## Fim da execução ##########" >> $LOG
