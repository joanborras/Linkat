#!/bin/bash
#allowguestuser.sh
#Script per automatitzar la ocultació del usuari convidat a la pantalla inicial de Linkat 
#Copyright 2016 JBA
#
#
clear
#Mostrem la capçalera del programa
echo \ ;
echo -e "\e[1m\e[36m--- Ocultació de l'usuari convidat a la pantalla de benvinguda ---\e[0m\e[0m";
#Identifiquem la versió del sistema i la mostrem
release=`lsb_release -d | cut -d: -f 2`;
echo \ ;
echo $release;
echo ;
#
#
#Demanem si es vol ocultar l usuari convidat a la pantalla d'inici de sessió
#Comprovem la configuracio actual, per saber si la linia allow-guest existeix al fitxer de configuracio
allowguest_check=`grep "allow-guest*" '/etc/lightdm/lightdm.conf.d/50-myconfig.conf'`;
#Si la linia no existeix,
if [ "$allowguest_check" = "" ]; then
	#Creem l'entrada i la posem en estat desactivat 
	sudo sed -i '$a allow-guest=true\n' /etc/lightdm/lightdm.conf.d/50-myconfig.conf;
	$allowguest_check = "allow-guest-true";
fi;
#
#
#Consultem a l'usuari si vol desactivar  el convidat
echo -e "\e[1mVoleu ocultar l'usuari convidat a la pantalla de benvinguda (S/N)?\e[0m";
#Convertim la cadena de resposta en majúscules i la llegim
typeset -u accept;
read accept;
#Si l'usuari indica s o S
if [ "$accept" = "S" ]; then
	#Inicialitzem les variables dels estats possibles
	allowguest_false="allow-guest=false";
	allowguest_true="allow-guest=true";
	#Si la comprovacio de configuració no correspon a desactivat
	if [ $allowguest_check != $allowguest_false ]; then
		#Afegim la linia allow-guest al fitxer de configuració
  		sudo sed -i 's/'$allowguest_check'*/allow-guest=false/g' '/etc/lightdm/lightdm.conf.d/50-myconfig.conf';
		tput cuu1;
		echo -e "\e[1m\e[33mL'usuari convidat ha estat ocultat a la pantalla de benvinguda.\e[0m\e[0m\n\e[1m\e[36mCal que reinicieu el vostre sistema per aplicar els canvis...\e[0m\e[0m\n";
	#En cas contrari indiquem que l usuari ja està desactivat
	else
		tput cuu1;
		echo -e "\e[1m\e[33mL'usuari convidat ja està ocultat.\e[0m\e[0m\n";
	fi;
	#
	#
#Si l usuari ha indicat que no vol desactivar el convidat
elif [ "$accept" = "N" ]; then
	#Afegim la linia allow-guest=true  al fitxer de configuració
	sudo sed -i 's/'$allowguest_check'*/allow-guest=true/g' '/etc/lightdm/lightdm.conf.d/50-myconfig.conf';
        tput cuu1;
	echo -e "\e[1m\e[32mL'usuari convidat ha estat activat a la pantalla de benvinguda.\e[0m\e[0m\n\e[1m\e[36mCal que reinicieu el vostre sistema per aplicar els canvis...\e[0m\e[0m\n";
#
#
#En cas que l usuari indiqui una  opcio diferent a S o N, mostrem un error
else
	tput cuu1;
	echo -e "\e[1m\e[31mERROR: S'ha introduït una opció incorrecta. Torneu-ho a provar.\e[0m\e[0m\n";
fi;
#
#
#Buidem els valors de les variables
allowguest_check='';
allowguest_true='';
allowguest_false='';
