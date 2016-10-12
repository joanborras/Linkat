#!/bin/bash
#hideuserslist.sh
#Script per automatitzar la ocultació de la llista de usuaris a la pantalla inicial de Linkat 
#Copyright 2016 JBA
#
#
clear
#Mostrem la capçalera del programa
echo \ ;
echo -e "\e[1m\e[36m--- Ocultació de la llista d'usuaris a la pantalla de benvinguda ---\e[0m\e[0m";
#Identifiquem la versió del sistema i la mostrem
release=`lsb_release -d | cut -d: -f 2`;
echo \ ;
echo $release;
echo ;
#
#
#Demanem si es vol ocultar la llista de usuaris a la pantalla d'inici de sessió
#Comprovem la configuracio actual, per saber si la linia greeter-hide-users existeix al fitxer de configuracio
greeterhideusers_check=`grep "greeter-hide-users*" '/etc/lightdm/lightdm.conf.d/50-myconfig.conf'`;
#Si la linia no existeix,
if [ "$greeterhideusers_check" = "" ]; then
	#Creem l'entrada i la posem en estat desactivat 
	sudo sed -i '$a greeter-hide-users=false\n' /etc/lightdm/lightdm.conf.d/50-myconfig.conf;
	#Reiniciem la variable de comprovació a l'estat iicial
	$greeterhideusers_check="greeter-hide-users=false"; 
fi;
#
#
#Consultem a l'usuari si vol desactivar  el convidat
echo -e "\e[1mVoleu ocultar la llista d'usuaris a la pantalla de benvinguda (S/N)?\e[0m";
#Convertim la cadena de resposta en majúscules i la llegim
typeset -u accept;
read accept;
#Si l'usuari indica s o S
if [ "$accept" = "S" ]; then
	#Inicialitzem les variables dels estats possibles
	greeterhideusers_false="greeter-hide-users=false";
	greeterhideusers_true="greeter-hide-users=true";
	#Si la comprovacio de configuració no correspon a amagat
	if [ $greeterhideusers_check != $greeterhideusers_true ]; then
		#Afegim la linia greeter-hide-users al fitxer de configuració
  		sudo sed -i 's/'$greeterhideusers_check'*/greeter-hide-users=true/g' '/etc/lightdm/lightdm.conf.d/50-myconfig.conf';
		tput cuu1;
		echo -e "\e[1m\e[33mLa llista d'usuaris ha estat ocultada a la pantalla de benvinguda.\e[0m\e[0m\n\e[1m\e[36mCal que reinicieu el vostre sistema per aplicar els canvis...\e[0m\e[0m\n";
	#En cas contrari indiquem que la llista ja està desactivada
	else
		tput cuu1;
		echo -e "\e[1m\e[33mLa llista d'usuaris ja està oculta.\e[0m\e[0m\n";
	fi;
	#
	#
#Si l usuari ha indicat que no vol amagar la llista
elif [ "$accept" = "N" ]; then
	#Afegim la linia greeter-hide-users=false  al fitxer de configuració
	sudo sed -i 's/'$greeterhideusers_check'*/greeter-hide-users=false/g' '/etc/lightdm/lightdm.conf.d/50-myconfig.conf';
        tput cuu1;
	echo -e "\e[1m\e[32mLa llista d'usuaris ha estat activada a la pantalla de benvinguda.\e[0m\e[0m\n\e[1m\e[36mCal que reinicieu el vostre sistema per aplicar els canvis...\e[0m\e[0m\n";
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
greeterhideusers='';
greeterhideusers_true='';
greeterhideusers_false='';

