#!/bin/bash
# renamehost.sh
# Script d automatització del canvi de nom d'equip a Linkat
# 2016 JBA
#
#
# Comprovem que l'script s'executa com a root
if [ -n "$(id | grep root)" ]; then
{
# En cas afirmatiu continuem el procés
xhost +
clear
# Identificació del nom actual
#
hostname=$(hostname)
clear
# Mostrem el nom actual i demanem a l'usuari si vol canviar-lo
zenity --question --title "Canvi del nom d'equip" --text "El nom actual del vostre equip és <b><i>"$hostname"</i></b> \nVoleu canviar-lo?" --width=300
#
# Llegim la resposta de l'usuari i la desem en una variable
resposta=$(echo $?);
#
# Si l'usuari ha seleccionat No, obtenim el codi de resposta 1 i per tant no fem cap canvi
if [ "$resposta" == 1 ]; then
	zenity --info --title "Canvi del nom d'equip" --text "El nom del vostre equip no s'ha canviat." --width=300;
# Si l'usuari ha seleccionat Si, obtenim el codi de resposta 0 i iniciem el procés de canvi de nom
elif [ "$resposta" == 0 ]; then
	#
	# Petició del nou nom a l'usuari
	new_hostname=$(zenity --entry --title "Canvi del nom d'equip" --text "Escriviu el nou nom per a l'equip:" --width=300)
	if [ $? == 1 ]; then
		zenity --warning --title "Canvi del nom d'equip" --text "S'ha cancel·lat el procés.\nEl nom del vostre equip no s'ha canviat." --width=300;
		killall hostname.sh
	fi
	if [ ! $new_hostname ]; then
		new_hostname="Linkat-PC"
		zenity --warning --title "Canvi del nom d'equip" --text "No heu eapecificat cap nom. S'ha establert el nom per defecte com a <b><i>Linkat-PC</i></b>." --width=300;
	fi
	#
	# Canvi del nom d'equip als fitxers /etc/hostname i /etc/hosts
	# Comprovació per saber si el nom introduit és el mateix que l'actual
	hostname_check=$hostname
	new_hostname_check=$new_hostname
	if [ $hostname_check == $new_hostname_check ]; then
		# Si el nom nou és el mateix que l'actual, no fem capa canvi i mostrem un avis en pantalla
		zenity --info --title "Canvi del nom d'equip" --text "El nou nom que heu especificat és el mateix que l'actual.\nNo s'ha fet cap canvi." --width=300
	else		
		# Si el nou nom és diferent, modifiquem els fitxers
		sudo -S sed -i 's/'$hostname'/'$new_hostname'/g' '/etc/hostname'; clear 
		sudo -S sed -i 's/'$hostname'/'$new_hostname'/g' '/etc/hosts'; clear
		sudo -S hostname $new_hostname; clear
		#
		# Avís de confirmació dels canvis per pantalla i compte enrere
		(
		echo "0"
		echo "#--- El nou nom d'equip s'ha establert com a "$new_hostname" ---\n\nEl vostre equip es reiniciarà d'aquí a 10 segons. Espereu-vos...\n\n" ; sleep 1
		echo "10"
		echo "#--- El nou nom d'equip s'ha establert com a "$new_hostname" ---\n\nEl vostre equip es reiniciarà d'aquí a 9 segons. Espereu-vos...\n\n" ; sleep 1
		echo "20"
		echo "#--- El nou nom d'equip s'ha establert com a "$new_hostname" ---\n\nEl vostre equip es reiniciarà d'aquí a 8 segons. Espereu-vos...\n\n" ; sleep 1
		echo "30"
		echo "#--- El nou nom d'equip s'ha establert com a "$new_hostname" ---\n\nEl vostre equip es reiniciarà d'aquí a 7 segons. Espereu-vos...\n\n" ; sleep 1
		echo "40"
		echo "#--- El nou nom d'equip s'ha establert com a "$new_hostname" ---\n\nEl vostre equip es reiniciarà d'aquí a 6 segons. Espereu-vos...\n\n" ; sleep 1
		echo "50"
		echo "#--- El nou nom d'equip s'ha establert com a "$new_hostname" ---\n\nEl vostre equip es reiniciarà d'aquí a 5 segons. Espereu-vos...\n\n" ; sleep 1
		echo "60"
		echo "#--- El nou nom d'equip s'ha establert com a "$new_hostname" ---\n\nEl vostre equip es reiniciarà d'aquí a 4 segons. Espereu-vos...\n\n" ; sleep 1
		echo "70"
		echo "#--- El nou nom d'equip s'ha establert com a "$new_hostname" ---\n\nEl vostre equip es reiniciarà d'aquí a 3 segons. Espereu-vos...\n\n" ; sleep 1
		echo "80"
		echo "#--- El nou nom d'equip s'ha establert com a "$new_hostname" ---\n\nEl vostre equip es reiniciarà d'aquí a 2 segons. Espereu-vos...\n\n" ; sleep 1
		echo "90"
		echo "#--- El nou nom d'equip s'ha establert com a "$new_hostname" ---\n\nEl vostre equip es reiniciarà d'aquí a 1 segon. Espereu-vos...\n\n" ; sleep 1
		echo "100"
		) |
		zenity --progress --title "Canvi del nom d'equip" --percentage=0 --auto-close --width=500 --height=200 --no-cancel 
		zenity --info --title "Canvi del nom d'equip" --text "S'està aturant el sistema.\nEspereu-vos..." --width=300 --timeout=2
		# Reiniciem l'equip després de fer els canvis quan hem esgotat el temps d'espera		
		sudo reboot
	fi
	#
	# Neteja de variables
	hostname=''
	new_hostname=''
else
# En cas que es produeixi un error en la selecció de l'usuari i s'obtingui un codi diferent de 0 o 1 mostrem un missatge d'error.
zenity --error --title "Canvi del nom d'equip" --text "S'ha produït un error.\nTorneu a intentar-ho." --width=300;
fi
}
else
# Si l'usuari que ha executat el script no és root mostrem advertencia i tanquem el procés
	zenity --warning --text "No teniu privilegis suficients per executar aquest programa.\nProveu d'executar ek programa com a super-usuari." --title="Canvi del nom d'equip" --width=300
	exit 1
fi
