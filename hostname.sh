#!/bin/bash
# hostname.sh
# Script d automatització del canvi de nom d'equip a Linkat
# Copyright 2016 JBA
#
#
clear
echo -e "**** Canvi del nom d'equip ****\n"
#
# Identificació del nom actual
hostname=$(hostname)
echo -e "El nom actual del vostre equip és \e[1m\e[32m"$hostname"\e[0m\e[0m"
#
# Petició del nou nom a l'usuari
echo "Escriviu el nou nom per a l'equip:"
read new_hostname
#
# Canvi del nom d'equip als fitxers /etc/hostname i /etc/hosts
# Comprovació per saber si el nom introduit és el mateix que l'actual
hostname_check=$hostname
new_hostname_check=$new_hostname
if [ $hostname_check == $new_hostname_check ]; then
# Si el nom nou és el mateix que l'actual, no fem capa canvi i mostrem un avñis en pantalla
echo -e "\nEl nou nom que heu especificat és el mateix que l'actual.\nNo s'ha fet cap canvi.\n\n"
else
# Si el nou nom és diferent, modifiquem els fitxers
sudo sed -i 's/'$hostname'/'$new_hostname'/g' /etc/hostname
sudo sed -i 's/'$hostname'/'$new_hostname'/g' /etc/hosts
sudo hostname $new_hostname
# Avís de confirmació dels canvis per pantalla
clear
echo -e "**** Canvi del nom d'equip ****\n"
echo -e "El nou nom d'equip s'ha establert com a \e[1m\e[32m"$new_hostname"\e[0m\e[0m\n\n"
#
# Reiniciem l'equip després de fer els canvis
i="0"
sec=10
for i in $(seq 1 10)
do
#date +"%H:%M:%S"
clear
echo -e "**** Canvi del nom d'equip ****\n"
echo -e "El nou nom d'equip s'ha establert com a \e[1m\e[32m"$new_hostname"\e[0m\e[0m\n"
echo -e "El vostre equip es reiniciarà d'aquí a "$sec" segons. Espereu-vos..."
i=i+1
let sec-="1"
sleep 1
if [ $sec == 0 ]; then
sudo reboot
fi
done
fi
#
# Neteja de variables
hostname=''
new_hostname=''

