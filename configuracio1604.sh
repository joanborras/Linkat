#!/bin/bash
#
#
##############################################################
#							     #
#	configuracio.sh					     #		
#	Script de configuració inicial de Linkat 16.04       #
#	per la creació d'usuaris i perfils, 		     #
#                                                            #
#	Autor: Joan Borràs                                   # 
#	Versió: 1.0                                          #
#	Data: Desembre 2017	                             #
#                                                            #
##############################################################
#
#
##############################################################
# Comprovem que l'script s'executa com a root
#
if [ -n "$(id | grep root)" ]; then
{
xhost +
clear 2>/dev/null
#
#
#
#
#
##############################################################
# Actualització del sistema
sudo -S pkill dpkg; sudo -S dpkg --configure -a; sudo -S apt-get install -f | \
	zenity --progress \
	--title "Configuració inicial de Linkat 16.04" \
	--text "S'està preparant el sistema.\nUn moment, si us plau..." \
	--width=400 --no-cancel --auto-close --pulsate \
	2>/dev/null ;
sudo -S apt-get update 2>/dev/null | \
	zenity --progress \
	--title "Configuració inicial de Linkat 16.04" \
	--text "S'està llegint la base de dades de les actualitzacions del sistema." \
	--width=450 --no-cancel --auto-close --pulsate \
	2>/dev/null ;
sudo -S apt-get upgrade -y 2>/dev/null | \
	zenity --progress \
	--title "Configuració inicial de Linkat 16.04" \
	--text "S'està actualitzant el sistema.\nAixò pot trigar una estona.\nEspereu-vos..." \
	--width=300 --no-cancel --auto-close --pulsate \
	2>/dev/null ;
#
#
#
#
#
# Instal·lació, actualització i configuració de programari addicional
#
# Instal·lació i actualització del suport d'idioma català
sudo -S apt-get install --reinstall libreoffice-help-ca firefox-locale-en libreoffice-l10n-ca \
thunderbird-locale-en-gb language-pack-en libreoffice-l10n-en-za mythes-ca \
hunspell-en-ca hunspell-en-za kde-l10n-engb firefox-locale-ca gimp-help-en \
kde-l10n-ca hyphen-en-gb mythes-en-au gimp-help-ca libreoffice-help-en-gb \
language-pack-gnome-en wcatalan hunspell-en-au libreoffice-l10n-en-gb \
thunderbird-locale-ca hyphen-ca kde-l10n-ca-valencia -y | \
	zenity --progress \
		--title "Configuració inicial de Linkat 16.04" \
		--text "S'està actualitzant el Suport d'idioma Català.\nAixò pot trigar una estona.\nEspereu-vos..."\
		--width=350 --no-cancel --auto-close --pulsate \
		2>/dev/null ;
#
#
#
#
#
#
# Instal·lació i actualització de Flash Player
sudo -S apt-get install --reinstall flashplugin-installer -y 2>/dev/null | \
	zenity --progress \
		--title "Configuració inicial de Linkat 16.04" \
		--text "S'està actualitzant el component Flash Player.\nAixò pot trigar una estona.\nEspereu-vos..."\
		--width=350 --no-cancel --auto-close --pulsate \
		2>/dev/null ;
#
#
#
#
#
#
# Instal·lació i actualització de SSH
sudo -S apt-get install --reinstall ssh -y 2>/dev/null | \
	zenity --progress \
		--title "Configuració inicial de Linkat 16.04" \
		--text "S'està actualitzant el programari i configuració Secure Shell (SSH).\nAixò pot trigar una estona.\nEspereu-vos..."\
		--width=450 --no-cancel --auto-close --pulsate \
		2>/dev/null ;
#
#
#
#
#
#
# Instal·lació i actualització de Systemback
# Afegim repositori
sudo -S apt-add-repository --yes ppa:nemh/systemback 2>/dev/null | clear ;
# Instal·lem systemback
sudo -S apt-get update | \
	zenity --progress \
		--title "Configuració inicial de Linkat 16.04" \
		--text "Sincronitzant amb un repositori extern de programari.\nEspereu-vos..."\
		--width=400 --no-cancel --auto-close --pulsate \
		2>/dev/null ;
sudo -S apt-get install --reinstall systemback -y 2>/dev/null | \
	zenity --progress \
		--title "Configuració inicial de Linkat 16.04" \
		--text "S'està actualitzant el programari Systemback.\nAixò pot trigar una estona.\nEspereu-vos..."\
		--width=350 --no-cancel --auto-close --pulsate \
		2>/dev/null ;
#
#
#
#
#
# Instal·lació i actualització opcional del congelador d'escriptoris Trivial Freezer
zenity --question \
	--title "Configuració inicial de Linkat 16.04" \
	--text "Voleu instal·lar i actualitzar el Congelador d'Escriptoris Trivial freezer?"\
	--width=500 --cancel-label="Més tard" --ok-label="Fem-ho ara" \
	2>/dev/null ;
if [[ $? == 0 ]]; then
	{
	sudo -S apt-get install --reinstall tfreezer -y 2>/dev/null | \
		zenity --progress \
			--title "Configuració inicial de Linkat 16.04" \
			--text "S'està instal·lant i actualitzant el congelador d'escriptoris.\nAixò pot trigar una estona.\nEspereu-vos..." \
			--width=500 --no-cancel --auto-close--pulsate \
			2>/dev/null ;
	zenity --info \
		--title "Configuració inicial de Linkat 16.04" \
		--text "S'ha instal·lat i actualitzat el congelador d'escriptoris Trivial Freezer." \
		--width=500 --ok-label="D'acord" \
		2>/dev/null ;
	}
else
	{
	zenity --info \
		--title "Configuració inicial de Linkat 16.04" \
		--text "Heu triat no instal·lar el congelador d'escriptoris." \
		--width=350 --ok-label="D'acord" \
		2>/dev/null ;
	}
fi;
#
#
#
#
#
# Instal·lació i actualització opcional del muntador d'unitats
zenity --question \
	--title "Configuració inicial de Linkat 16.04" \
	--text "Voleu instal·lar i actualitzar el Muntador d'unitats?"\
	--width=380 --cancel-label="Més tard" --ok-label="Fem-ho ara" \
	2>/dev/null ;
if [[ $? == 0 ]]; then
	{
sudo -S apt-get install --reinstall linkat-muntador-unitats -y 2>/dev/null | \
	zenity --progress \
		--title "Configuració inicial de Linkat 16.04" \
		--text "S'està instal·lant i actualitzant el muntador d'unitats.\nAixò pot trigar una estona.\nEspereu-vos..." \
		--width=450 --no-cancel --auto-close --pulsate \
		2>/dev/null ;
	zenity --info \
		--title "Configuració inicial de Linkat 16.04" \
		--text "S'ha instal·lat i actualitzat el muntador d'unitats." \
		--width=400 --ok-label="D'acord" \
		2>/dev/null ;
}
else
	{
	zenity --info \
		--title "Configuració inicial de Linkat 16.04" \
		--text "Heu triat no instal·lar el muntador d'unitats." \
		--width=320 --ok-label="D'acord" \
		2>/dev/null ;
	}
fi;
#
#
#
#
#
# Instal·lació i actualització opcional del reproductor lleuger de videos
zenity --question \
	--title "Configuració inicial de Linkat 16.04" \
	--text "Voleu instal·lar i actualitzar el Reproductor lleuger de vídeo?"\
	--width=430 --cancel-label="Més tard" --ok-label="Fem-ho ara" \
	2>/dev/null ;
if [[ $? == 0 ]]; then
	{
sudo -S apt-get install --reinstall linkat-video-lleuger -y 2>/dev/null | \
	zenity --progress \
		--title "Configuració inicial de Linkat 16.04" \
		--text "S'està instal·lant i actualitzant el el Reproductor lleuger de vídeo.\nAixò pot trigar una estona.\nEspereu-vos..." \
		--width=500 --no-cancel --auto-close --pulsate \
		2>/dev/null ;
	zenity --info \
		--title "Configuració inicial de Linkat 16.04" \
		--text "S'ha instal·lat i actualitzat el Reproductor lleuger de vídeo." \
		--width=450 --ok-label="D'acord" \
		2>/dev/null ;
}
else
	{
	zenity --info \
		--title "Configuració inicial de Linkat 16.04" \
		--text "Heu triat no instal·lar el el Reproductor lleuger de vídeo." \
		--width=400 --ok-label="D'acord" \
		2>/dev/null ;
	}
fi;
#
#
#
#
#
#
#
#
##############################################################
# Selecció d'usuaris i perfils
resposta=$(zenity --list --checklist \
	--column "Instal·la"\
	--column "Usuari"\
	--column "Descripció"\
		TRUE "super"\
			"Usuari estàndard d'administració"\
		TRUE "prof" \
			"Usuari estàndard del professorat."\
		TRUE "argo" \
			"Usuari estàndard de l'alumnat."\
		FALSE "infantil" \
			"Perfil d'usuari per al segon cicle d'infantil	i cicle inicial de primària."\
		FALSE "primaria" \
			"Perfil d'usuari per als cicles mitjà i superior de primària."\
		FALSE "secundaria" \
			"Perfil d'usuari per a alumnat de secundària."\
		FALSE "blau" \
			"Escriptori personalitzat amb aparença similar amb el sistema operatiu Windows."\
		FALSE "web" \
			"Escriptori personalitzat amb aparença similar amb el sistema operatiu ChromiumOS."\
		FALSE "musica" \
			"Escriptori personalitzat amb interfície gràfica i aplicacions per a estudiants i professorat de música."\
		FALSE "robotica" \
			"Escriptori personalitzat amb interfície gràfica i aplicacions per a estudiants de robòtica i programació."\
		FALSE "diversitat" \
			"Escriptori personalitzat amb interfície gràfica i aplicacions per a persones amb problemes d'accessibilitat."\
		FALSE "adults" \
			"Escriptori personalitzat amb interfície gràfica i aplicacions per a la formació de persones adultes."\
	--separator=":" \
	--title "Configuració inicial de Linkat 16-04" \
	--text "Seleccioneu els usuaris i perfils que voleu configurar" \
	--width=900 --height=400 --ok-label="Instal·la i configura" --cancel-label="No, gràcies." \
	2>/dev/null); 
#
#
#
#
#
# Instal·lació dels usuaris i perfils triats
#
# Creació de l'usuari super
# Comprovem si l'usuari té la sessió iniciada
	current_users=$(users)
	if [[ $current_users == *super* ]]; then
	{
	zenity --warning \
			--text "No és possible fer canvis mentre aquest usuari tingui la sessió iniciada.\nTanqueu la sessió i torneu-ho a provar." \
			--title "Creació de perfils d'usuari" \
			--ok-label="D'acord" width=350 2>/dev/null;
    	} 
	# Si s'ha triat l'usuari super, comprovem que no existeix 
	elif [[ $resposta == *super* ]] ; then
		{
		existing_user_super=$( cat /etc/passwd | grep super | cut -d":" -f1);
	  	if [[ $existing_user_super == "super" ]]; then #Comprovem si l'error és causa que l'usuari ja existeix
    		{  
    		# Mostrem avís que l'usuari ja existeix  
    		zenity --question \
			--text "L'usuari <b>super</b> ja existeix.\nVoleu tornar al seu estat inicial?\nTingueu en compte que la configuració actual es perdrà." \
			--title "Creació de perfils d'usuari" \
			--cancel-label="No" --ok-label="Sí" width=350 2>/dev/null;
		reconfigsuper=$?
    		}
	fi
  	if ( [[ $existing_user_super != "super" ]] ) || \
		( [[ $existing_user_super == "super" ]] && [[ $reconfigsuper == 0 ]] ); then
		{
		# Eliminem l'usuari i el home actuals
		sudo -S userdel -rf "super" 2>/dev/null;
		# i demanem la contrasenya
		superpwd=$(zenity --entry \
			--text "Introduïu la contrasenya per a l'usuari <b>super</b>" \
			--title "Creació de perfils d'usuari" \
			--hide-text \
			2>/dev/null);
		#
		# Afegim usuari super
		sudo -S useradd -m -c "super" super 2>/dev/null;
  		if [ $? -eq 0 ]; then  #Si la creació d'usuari no mostra cap error
    			{
    			sudo -S echo "super:$superpwd" | chpasswd;  
			#Creem l'usuari amb la contrasenya assignada
    			if [ $? -eq 0 ]; then  #Si la contrasenya no mostra cap error
      				{
      				# Mostrem missatge de confirmació de creació correcta de l'usuari
      				zenity --info \
					--title "Creació de perfils d'usuari" \
					--text "L'usuari <b>super</b> ha estat creat satisfactòriament." \
					2>/dev/null;
				super_created="super";
      				}  
    			else #Si la contrasenya dóna un error
      				{
      				# Mostrem missatge d'error d'error de creació de l'usuari
      				zenity --error \
					--text "S'ha produit un error en crear la contrasenya" \
					--title "Creació de perfils d'usuari" \
					2>/dev/null;
      				}
    			fi;
    			}
  		else #Si la creació d'usuari mostra algun error
   			{
    			# Mostrem error desconegut
    			zenity --error \
				--text "S'ha produit un error en crear l'usuari <b>super</b>" \
				--title "Creació de perfils d'usuari" \
				2>/dev/null ;    			
			}
  		fi;
		}
	fi;
	}
fi;
#
#
#
#
#
# Creació de l'usuari prof
# Comprovem si l'usuari té la sessió iniciada
	current_users=$(users)
	if [[ $current_users == *prof* ]]; then
	{
	zenity --warning \
			--text "No és possible fer canvis mentre aquest usuari tingui la sessió iniciada.\nTanqueu la sessió i torneu-ho a provar." \
			--title "Creació de perfils d'usuari" \
			--ok-label="D'acord" width=350 2>/dev/null;
    	} 
	# Si s'ha triat l'usuari prof, comprovem que no existeix 
	elif [[ $resposta == *prof* ]] ; then
		{
		existing_user_prof=$( cat /etc/passwd | grep prof | cut -d":" -f1);
	  	if [[ $existing_user_prof == "prof" ]]; then #Comprovem si l'error és causa que l'usuari ja existeix
    		{  
    		# Mostrem avís que l'usuari ja existeix  
    		zenity --question \
			--text "L'usuari <b>prof</b> ja existeix.\nVoleu tornar al seu estat inicial?\nTingueu en compte que la configuració actual es perdrà." \
			--title "Creació de perfils d'usuari" \
			--cancel-label="No" --ok-label="Sí" width=350 2>/dev/null;
		reconfigprof=$?
    		}
	fi
  	if ( [[ $existing_user_prof != "prof" ]] ) || \
		( [[ $existing_user_prof == "prof" ]] && [[ $reconfigprof == 0 ]] ); then
		{
		# Eliminem l'usuari i el home actuals
		sudo -S userdel -rf "prof" 2>/dev/null;
		# i demanem la contrasenya
		profpwd=$(zenity --entry \
			--text "Introduïu la contrasenya per a l'usuari prof</b>" \
			--title "Creació de perfils d'usuari" \
			--hide-text \
			2>/dev/null);
		# Afegim usuari prof
		sudo -S useradd -m -c "prof" prof 2>/dev/null;
  		if [ $? -eq 0 ]; then  #Si la creació d'usuari no mostra cap error
    			{
    			sudo -S echo "prof:$profpwd" | chpasswd;  
			#Creem l'usuari amb la contrasenya assignada
    			if [ $? -eq 0 ]; then  #Si la contrasenya no mostra cap error
      				{
      				# Mostrem missatge de confirmació de creació correcta de l'usuari
      				zenity --info \
					--title "Creació de perfils d'usuari" \
					--text "L'usuari <b>prof</b> ha estat creat satisfactòriament." \
					2>/dev/null;
				prof_created="prof";
      				}  
    			else #Si la contrasenya dóna un error
      				{
      				# Mostrem missatge d'error d'error de creació de l'usuari
      				zenity --error \
					--text "S'ha produit un error en crear la contrasenya" \
					--title "Creació de perfils d'usuari" \
					2>/dev/null;
      				}
    			fi;
    			}
  		else #Si la creació d'usuari mostra algun error
   			{
    			# Mostrem error desconegut
    			zenity --error \
				--text "S'ha produit un error en crear l'usuari <b>prof</b>" \
				--title "Creació de perfils d'usuari" \
				2>/dev/null ;    			
			}
  		fi;
		}
	fi;
	}
fi;
#
#
#
#
#
# Creació de l'usuari argo
# Comprovem si l'usuari té la sessió iniciada
	current_users=$(users)
	if [[ $current_users == *argo* ]]; then
	{
	zenity --warning \
			--text "No és possible fer canvis mentre aquest usuari tingui la sessió iniciada.\nTanqueu la sessió i torneu-ho a provar." \
			--title "Creació de perfils d'usuari" \
			--ok-label="D'acord" width=350 2>/dev/null;
    	} 
	# Si s'ha triat l'usuari argo, comprovem que no existeix 
	elif [[ $resposta == *argo* ]] ; then
		{
		existing_user_argo=$( cat /etc/passwd | grep argo | cut -d":" -f1);
	  	if [[ $existing_user_argo == "argo" ]]; then #Comprovem si l'error és causa que l'usuari ja existeix
    		{  
    		# Mostrem avís que l'usuari ja existeix  
    		zenity --question \
			--text "L'usuari <b>argo</b> ja existeix.\nVoleu tornar al seu estat inicial?\nTingueu en compte que la configuració actual es perdrà." \
			--title "Creació de perfils d'usuari" \
			--cancel-label="No" --ok-label="Sí" width=350 2>/dev/null;
		reconfigargo=$?
    		}
	fi
  	if ( [[ $existing_user_argo != "argo" ]] ) || \
		( [[ $existing_user_argo == "argo" ]] && [[ $reconfigargo == 0 ]] ); then
		{
		# Eliminem l'usuari i el home actuals
		sudo -S userdel -rf "argo" 2>/dev/null;
		#		
		# Afegim usuari argo
		sudo -S useradd -m -c "argo" argo 2>/dev/null;
  		if [ $? -eq 0 ]; then  #Si la creació d'usuari no mostra cap error
    			{
    			sudo -S passwd -d argo; #Assignem contrasenya en blanc
    			# Mostrem missatge de confirmació de creació correcta de l'usuari
    			zenity --info \
				--title "Creació de perfils d'usuari" \
				--text "L'usuari <b>argo</b> ha estat creat satisfactòriament." \
				2>/dev/null;
			argo_created="argo";
    			}
  		else #Si la creació d'usuari mostra algun error
    			{
    			# Mostrem error desconegut
    			zenity --error \
				--text "S'ha produit un error en crear l'usuari <b>argo</b>" \
				--title "Creació de perfils d'usuari" \
				2>/dev/null;
    			}
  		fi;
		}
	fi;
	}
fi;
#
#
#
#
#
# Instal·lació i configuració del perfil d'usuari infantil
# Comprovem si l'usuari té la sessió iniciada
	current_users=$(users)
	if [[ $current_users == *infantil* ]]; then
	{
	zenity --warning \
			--text "No és possible fer canvis mentre aquest usuari tingui la sessió iniciada.\nTanqueu la sessió i torneu-ho a provar." \
			--title "Creació de perfils d'usuari" \
			--ok-label="D'acord" width=350 2>/dev/null;
    	} 
	# Si s'ha triat el perfil infantil, comprovem que no existeix 
	elif [[ $resposta == *infantil* ]] ; then
		{
		existing_user_infantil=$( cat /etc/passwd | grep infantil | cut -d":" -f1);
	  	if [[ $existing_user_infantil == "infantil" ]]; then #Comprovem si l'error és causa que l'usuari ja existeix
    		{  
    		# Mostrem avís que l'usuari ja existeix  
    		zenity --question \
			--text "El perfil <b>infantil</b> ja existeix.\nVoleu tornar al seu estat inicial?\nTingueu en compte que la configuració actual es perdrà." \
			--title "Creació de perfils d'usuari" \
			--cancel-label="No" --ok-label="Sí" width=350 2>/dev/null;
		reconfiginfantil=$?
    		}
	fi
  	if ( [[ $existing_user_infantil != "infantil" ]] ) || \
		( [[ $existing_user_infantil == "infantil" ]] && [[ $reconfiginfantil == 0 ]] ); then
		{
		# Eliminem l'usuari i el home actuals
		sudo -S apt-get purge linkat-perfil-infantil -y | 2>/dev/null;
		#		
		# Afegim perfil infantil
		# Actualitzem la informació i instal·lem el perfil infantil
		sudo -S apt-get update | \
			zenity --progress \
				--title "Creació de perfils d'usuari" \
				--text "S'està llegint la base de dades de les actualitzacions del sistema."\
				--width=500 --no-cancel --auto-close --pulsate \
				2>/dev/null ;
		sudo -S apt-get install linkat-perfil-infantil -y | \
			zenity --progress \
				--text "S'està instal·lant i configurant el perfil d'usuari <b>infantil</b>. \nAixò pot trigar una estona.\nEspereu-vos..." \
				--title "Creació de perfils d'usuari" \
				--width=400 --no-cancel --auto-close --pulsate \
				2>/dev/null;
  		if [ $? -eq 0 ]; then  #Si la creació d'usuari no mostra cap error
    			{
    			# Mostrem missatge de confirmació de creació correcta de l'usuari
    			zenity --info \
				--title "Creació de perfils d'usuari" \
				--text "El perfil d'usuari <b>infantil</b> s'ha instal·lat satisfactòriament." \
				2>/dev/null;
    			}
  		else #Si la creació d'usuari mostra algun error
    			{
    			# Mostrem error desconegut
    			zenity --error \
				--text "S'ha produit un error en instal·lar el perfil d'usuari <b>infantil</b>" \
				--title "Creació de perfils d'usuari" 
				2>/dev/null ;    			
			}
  		fi;
		}
	fi;
	}
fi;
#
#
#
#
#
# Instal·lació i configuració del perfil d'usuari primaria
# Si s'ha triat l'usuari primaria, comprovem que no existeix 
if [[ $resposta == *primaria* ]] ; then
	{
	existing_user_primarial=$( cat /etc/passwd | grep primaria | cut -d":" -f1);
 	if [[ $existing_user_primaria == "primaria" ]]; then 
	#Comprovem si l'error és causa que l'usuari ja existeix
    		{  
    		# Mostrem avís que l'usuari ja existeix  
    		zenity --warning \
			--text "El perfil d'usuari <b>primaria</b> ja existeix." \
			--title "Creació de perfils d'usuari" \
			2>/dev/null;
    		}
  	else
		{
		# Afegim perfil primaria
		# Actualitzem la informació i instal·lem el perfil primaria
		sudo -S apt-get update | \
			zenity --progress \
				--title "Creació de perfils d'usuari" \
				--text "S'està llegint la base de dades de les actualitzacions del sistema."\
				--width=500 --no-cancel --auto-close --pulsate \
				2>/dev/null ;
		sudo -S apt-get install linkat-perfil-primaria -y | \
			zenity --progress \
				--text "S'està instal·lant i configurant el perfil d'usuari <b>primaria</b>. \nAixò pot trigar una estona.\nEspereu-vos..." \
				--title "Creació de perfils d'usuari" \
				--width=400 --no-cancel --auto-close --pulsate \
				2>/dev/null;
  		if [ $? -eq 0 ]; then  #Si la creació d'usuari no mostra cap error
    			{
    			# Mostrem missatge de confirmació de creació correcta de l'usuari
    			zenity --info \
				--title "Creació de perfils d'usuari" \
				--text "El perfil d'usuari <b>primaria</b> s'ha instal·lat satisfactòriament." \
				2>/dev/null;
    			}
  		else #Si la creació d'usuari mostra algun error
    			{
    			# Mostrem error desconegut
    			zenity --error \
				--text "S'ha produit un error en instal·lar el perfil d'usuari <b>primaria</b>" \
				--title "Creació de perfils d'usuari" \
				2>/dev/null;
    			}
  		fi;
		}
	fi;
	}
fi;
#
#
#
#
#
# Instal·lació i configuració del perfil d'usuari secundaria
# Si s'ha triat l'usuari secundaria, comprovem que no existeix 
if [[ $resposta == *secundaria* ]] ; then
	{
	existing_user_secundaria=$( cat /etc/passwd | grep secundaria | cut -d":" -f1);
  	if [[ $existing_user_secundaria == "secundaria" ]]; then 
	#Comprovem si l'error és causa que l'usuari ja existeix
    		{  
    		# Mostrem avís que l'usuari ja existeix  
    		zenity --warning \
			--text "El perfil d'usuari <b>secundaria</b> ja existeix." \
			--title "Creació de perfils d'usuari" \
			2>/dev/null;
    		}
  	else
		{
		# Afegim perfil secundaria
		# Actualitzem la informació i instal·lem el perfil secundaria
		sudo -S apt-get update | \
			zenity --progress \
			--title "Creació de perfils d'usuari" \
			--text "S'està llegint la base de dades de les actualitzacions del sistema." \
			--width=500 --no-cancel --auto-close --pulsate \
			2>/dev/null ;
		sudo -S apt-get install linkat-perfil-secundaria -y | \
			zenity --progress \
				--text "S'està instal·lant i configurant el perfil d'usuari <b>secundaria</b>. \nAixò pot trigar una estona.\nEspereu-vos..." \
				--title "Creació de perfils d'usuari" \
				--width=400 \
				--no-cancel --auto-close --pulsate \
				2>/dev/null;
  		if [ $? -eq 0 ]; then  #Si la creació d'usuari no mostra cap error
    			{
    			# Mostrem missatge de confirmació de creació correcta de l'usuari
    			zenity --info \
				--title "Creació de perfils d'usuari" \	
				--text "El perfil d'usuari <b>secundaria</b> s'ha instal·lat satisfactòriament." \
				2>/dev/null;
    			}
  		else #Si la creació d'usuari mostra algun error
    			{
    			# Mostrem error desconegut
    			zenity --error \
				--text "S'ha produit un error en instal·lar el perfil d'usuari <b>secundaria</b>" \
				--title "Creació de perfils d'usuari" \
				2>/dev/null;
    			}
  		fi;
		}
	fi;
	}
fi;
#
#
#
#
#
# Instal·lació i configuració del perfil d'usuari blau
# Si s'ha triat l'usuari blau, comprovem que no existeix 
if [[ $resposta == *blau* ]] ; then
	{
	existing_user_blau=$( cat /etc/passwd | grep blau | cut -d":" -f1);
  	if [[ $existing_user_blau == "blau" ]]; then #Comprovem si l'error és causa que l'usuari ja existeix
    		{  
    		# Mostrem avís que l'usuari ja existeix  
    		zenity --warning \
			--text "El perfil d'usuari <b>blau</b> ja existeix." \
			--title "Creació de perfils d'usuari" \
			2>/dev/null;
    		}
  	else
		{
		# Afegim perfil blau
		# Afegim repositori addicional
		sudo -S add-apt-repository ppa:ubuntuthirdparty/linkat-16.04 -y 2>/dev/null | \
			zenity --progress \
				--title "Creació de perfils d'usuari" \
				--text "S'està afegint un repositori extern." \
				--width=500 --no-cancel --auto-close --pulsate \
				2>/dev/null ;
		# Actualitzem la informació i instal·lem el perfil blau
		sudo -S apt-get update | \
			zenity --progress \
				--title "Creació de perfils d'usuari" \
				--text "S'està llegint la base de dades de les actualitzacions del sistema."\
				--width=500 --no-cancel --auto-close --pulsate \
				2>/dev/null ;
		sudo -S apt-get install linkat-perfil-blau -y | \
			zenity --progress \
				--text "S'està instal·lant i configurant el perfil d'usuari <b>blau</b>. \nAixò pot trigar una estona.\nEspereu-vos..." --title "Creació de perfils d'usuari" \
				--width=400 --no-cancel --auto-close --pulsate \
				2>/dev/null;
	  	if [ $? -eq 0 ]; then  #Si la creació d'usuari no mostra cap error
	    		{
	    		# Mostrem missatge de confirmació de creació correcta de l'usuari
	    		zenity --info \
				--title "Creació de perfils d'usuari" \
				--text "El perfil d'usuari <b>blau</b> s'ha instal·lat satisfactòriament." \
				2>/dev/null;
	    		}
	  	else #Si la creació d'usuari mostra algun error
	    		{
	    		# Mostrem error desconegut
	    		zenity --error \
				--text "S'ha produit un error en instal·lar el perfil d'usuari <b>blau</b>" \
				--title "Creació de perfils d'usuari" \
				2>/dev/null;
	    		}
	  	fi;
		}
	fi;
	}
fi;
#
#
#
#
#
# Instal·lació i configuració del perfil d'usuari web
# Si s'ha triat l'usuari web, comprovem que no existeix 
if [[ $resposta == *web* ]] ; then
	{
	existing_user_web=$( cat /etc/passwd | grep web | cut -d":" -f1);
  	if [[ $existing_user_web == "web" ]]; then #Comprovem si l'error és causa que l'usuari ja existeix
    		{  
    		# Mostrem avís que l'usuari ja existeix  
    		zenity --warning \
			--text "El perfil d'usuari <b>web</b> ja existeix." \
			--title "Creació de perfils d'usuari" \
			2>/dev/null;
    		}
  	else
		{
		# Afegim perfil web
		# Afegim repositori addicional
		sudo -S sudo add-apt-repository ppa:ubuntuthirdparty/linkat-16.04 -y 2>/dev/null | \
			zenity --progress \
				--title "Creació de perfils d'usuari" \
				--text "S'està afegint un repositori extern." 	
				--width=500 --no-cancel --auto-close --pulsate \
				2>/dev/null ;
		# Actualitzem la informació i instal·lem el perfil web
		sudo -S apt-get update | \
			zenity --progress \
				--title "Creació de perfils d'usuari" \
				--text "S'està llegint la base de dades de les actualitzacions del sistema."\
				--width=500 --no-cancel --auto-close --pulsate \
				2>/dev/null ;
		sudo -S apt-get install linkat-perfil-web -y | \
			zenity --progress \
				--text "S'està instal·lant i configurant el perfil d'usuari <b>web</b>. \nAixò pot trigar una estona.\nEspereu-vos..." \
				--title "Creació de perfils d'usuari" \
				--width=400 --no-cancel --auto-close --pulsate \
				2>/dev/null;
		if [ $? -eq 0 ]; then  #Si la creació d'usuari no mostra cap error
    			{
    			# Mostrem missatge de confirmació de creació correcta de l'usuari
    			zenity --info \
				--title "Creació de perfils d'usuari" \
				--text "El perfil d'usuari <b>web</b> s'ha instal·lat satisfactòriament." \ 
				2>/dev/null;
    			}
  		else #Si la creació d'usuari mostra algun error
    			{
    			# Mostrem error desconegut
    			zenity --error \
				--text "S'ha produit un error en instal·lar el perfil d'usuari <b>web</b>" \
				--title "Creació de perfils d'usuari" \
				2>/dev/null;
    			}
  		fi;
		}
	fi;
	}
fi;
#
#
#
#
#
# Instal·lació i configuració del perfil d'usuari musica
# Si s'ha triat l'usuari musica, comprovem que no existeix 
if [[ $resposta == *musica* ]] ; then
	{
	existing_user_musica=$( cat /etc/passwd | grep web | cut -d":" -f1);
 	if [[ $existing_user_musica == "musica" ]]; then 
	#Comprovem si l'error és causa que l'usuari ja existeix
 		{  
    		# Mostrem avís que l'usuari ja existeix  
    		zenity --warning \
			--text "El perfil d'usuari <b>musica</b> ja existeix." \
			--title "Creació de perfils d'usuari" \
			2>/dev/null;
    		}
  	else
		{
		# Afegim perfil musica
		# Actualitzem la informació i instal·lem el perfil musica
		sudo -S apt-get update | \
			zenity --progress \
				--title "Creació de perfils d'usuari" \
				--text "S'està llegint la base de dades de les actualitzacions del sistema."\	
				--width=500 --no-cancel --auto-close --pulsate \
				2>/dev/null ;
		sudo -S apt-get install linkat-perfil-musica -y | \
			zenity --progress \
				--text "S'està instal·lant i configurant el perfil d'usuari <b>musica</b>. \nAixò pot trigar una estona.\nEspereu-vos..." \
				--title "Creació de perfils d'usuari" \
				--width=400 --no-cancel --auto-close --pulsate \
				2>/dev/null;
		if [ $? -eq 0 ]; then  #Si la creació d'usuari no mostra cap error
			{
		    	# Mostrem missatge de confirmació de creació correcta de l'usuari
		    	zenity --info \
				--title "Creació de perfils d'usuari" \
				--text "El perfil d'usuari <b>musica</b> s'ha instal·lat satisfactòriament." \
				2>/dev/null;
		    	}
		else #Si la creació d'usuari mostra algun error
		    	{
		    	# Mostrem error desconegut
		    	zenity --error \
				--text "S'ha produit un error en instal·lar el perfil d'usuari <b>musica</b>" \
				--title "Creació de perfils d'usuari" \
				2>/dev/null;
		    	}
		fi;
		}
	fi;
	}
fi;
#
#
#
#
#
# Instal·lació i configuració del perfil d'usuari robotica
# Si s'ha triat l'usuari robotica, comprovem que no existeix 
if [[ $resposta == *robotica* ]] ; then
	{
	existing_user_robotica=$( cat /etc/passwd | grep web | cut -d":" -f1);
  	if [[ $existing_user_robotica == "robotica" ]]; then 
	#Comprovem si l'error és causa que l'usuari ja existeix
    		{  
    		# Mostrem avís que l'usuari ja existeix  
    		zenity --warning \
			--text "El perfil d'usuari <b>robotica</b> ja existeix." \
			--title "Creació de perfils d'usuari" \
			2>/dev/null;
    		}
  	else
		{
		# Afegim perfil robotica
		# Actualitzem la informació i instal·lem el perfil robotica
		sudo -S apt-get update | \
			zenity --progress \
				--title "Creació de perfils d'usuari" \
				--text "S'està llegint la base de dades de les actualitzacions del sistema."\
				--width=500 --no-cancel --auto-close --pulsate \
				2>/dev/null ;
		sudo -S apt-get install linkat-perfil-robotica -y | \
			zenity --progress \
				--text "S'està instal·lant i configurant el perfil d'usuari <b>robotica</b>. \nAixò pot trigar una estona.\nEspereu-vos..." \
				--title "Creació de perfils d'usuari" \
				--width=400 --no-cancel --auto-close --pulsate \
				2>/dev/null;
		if [ $? -eq 0 ]; then  #Si la creació d'usuari no mostra cap error
			{
		    	# Mostrem missatge de confirmació de creació correcta de l'usuari
		    	zenity --info \
				--title "Creació de perfils d'usuari" \
				--text "El perfil d'usuari <b>robotica</b> s'ha instal·lat satisfactòriament." \
				2>/dev/null;
		    	}
		else #Si la creació d'usuari mostra algun error
		    	{
		    	# Mostrem error desconegut
		    	zenity --error \
				--text "S'ha produit un error en instal·lar el perfil d'usuari <b>robotica</b>" \
				--title "Creació de perfils d'usuari" \
				2>/dev/null;
		    	}
  		fi;
		}
	fi;
	}
fi;
#
#
#
#
#
# Instal·lació i configuració del perfil d'usuari diversitat
# Si s'ha triat l'usuari diversitat, comprovem que no existeix 
if [[ $resposta == *diversitat* ]] ; then
	{
	existing_user_diversitat=$( cat /etc/passwd | grep diversitat | cut -d":" -f1);
  	if [[ $existing_user_diversitat == "diversitat" ]]; then 
	#Comprovem si l'error és causa que l'usuari ja existeix
    		{  
    		# Mostrem avís que l'usuari ja existeix  
    		zenity --warning \
			--text "El perfil d'usuari <b>diversitat</b> ja existeix." \
			--title "Creació de perfils d'usuari" \
			2>/dev/null;
    		}
  	else 
		{
		# Afegim perfil diversitat
		# Actualitzem la informació i instal·lem el perfil diversitat
		sudo -S apt-get update | \
			zenity --progress \
				--title "Creació de perfils d'usuari" \
				--text "S'està llegint la base de dades de les actualitzacions del sistema."\
				--width=500 --no-cancel --auto-close --pulsate \
				2>/dev/null ;
		sudo -S apt-get install linkat-perfil-diversitat -y | \
			zenity --progress \
				--text "S'està instal·lant i configurant el perfil d'usuari <b>diversitat</b>. \nAixò pot trigar una estona.\nEspereu-vos..." \
				--title "Creació de perfils d'usuari" \
				--width=400 --no-cancel --auto-close --pulsate \
				2>/dev/null;
  		if [ $? -eq 0 ]; then  #Si la creació d'usuari no mostra cap error
    			{
    			# Mostrem missatge de confirmació de creació correcta de l'usuari
    			zenity --info \
				--title "Creació de perfils d'usuari" \
				--text "El perfil d'usuari <b>diversitat</b> s'ha instal·lat satisfactòriament." \
				2>/dev/null;
    			}
  		else #Si la creació d'usuari mostra algun error
    			{
    			# Mostrem error desconegut
    			zenity --error \
				--text "S'ha produit un error en instal·lar el perfil d'usuari <b>diversitat</b>" \
				--title "Creació de perfils d'usuari" \
				2>/dev/null;
    			}
  		fi;
		}
	fi;
	}
fi;
#
#
#
#
#
# Instal·lació i configuració del perfil d'usuari adults
# Si s'ha triat l'usuari adults, comprovem que no existeix 
if [[ $resposta == *adults* ]] ; then
	{
	existing_user_adults=$( cat /etc/passwd | grep adults | cut -d":" -f1);
  	if [[ $existing_user_adults == "adults" ]]; then 
	#Comprovem si l'error és causa que l'usuari ja existeix
    		{  
    		# Mostrem avís que l'usuari ja existeix  
    		zenity --warning \
			--text "El perfil d'usuari <b>adults</b> ja existeix." \
			--title "Creació de perfils d'usuari" \
			2>/dev/null;
    		}
  	else 
		{
		# Afegim perfil adults
		# Actualitzem la informació i instal·lem el perfil adults
		sudo -S apt-get update | \
			zenity --progress \
				--title "Creació de perfils d'usuari" \
				--text "S'està llegint la base de dades de les actualitzacions del sistema."\
				--width=500 --no-cancel --auto-close --pulsate \
				2>/dev/null ;
		sudo -S apt-get install linkat-perfil-adults -y | \
			zenity --progress \
				--text "S'està instal·lant i configurant el perfil d'usuari <b>adults</b>. \nAixò pot trigar una estona.\nEspereu-vos..." \
				--title "Creació de perfils d'usuari" \
				--width=400 --no-cancel --auto-close --pulsate \
				2>/dev/null;
  		if [ $? -eq 0 ]; then  #Si la creació d'usuari no mostra cap error
    			{
    			# Mostrem missatge de confirmació de creació correcta de l'usuari
    			zenity --info \
				--title "Creació de perfils d'usuari" \
				--text "El perfil d'usuari <b>adults</b> s'ha instal·lat satisfactòriament."\
				2>/dev/null;
    			}
  		else #Si la creació d'usuari mostra algun error
    			{
    			# Mostrem error desconegut
    			zenity --error \
				--text "S'ha produit un error en instal·lar el perfil d'usuari <b>adults</b>" \
				--title "Creació de perfils d'usuari" \
				2>/dev/null;
    			}
  		fi;
		}
	fi;
	}
fi;
#
#
##############################################################
#
#
#
#
#
#
#
#
#Ocultació de l'usuari convidat a la pantalla d'inici de sessió
zenity --question \
	--title "Configuració de la pantalla d'inici de sessió" \
	--text "Voleu ocultar la <b>Sessió de convidat</b> a la pantalla d'inici de sessió?" \
	--cancel-label="No" --ok-label="Sí" \
	2>/dev/null;
allowguest=$?; #Creem la variable de control per desar la resposta de la pregunta a l'usuari
#Comprovem la configuracio actual, per saber si la linia allow-guest existeix al fitxer de configuracio
allowguest_check=`grep "allow-guest*" '/usr/share/lightdm/lightdm.conf.d/50-guest-wrapper.conf'`;
if [ "$allowguest_check" = "" ]; then #Si la linia no existeix al fitxer,
	{	
	#Creem l'entrada i la posem en estat que permet convidat 
	sudo -S sed -i '$a allow-guest=true\n' /usr/share/lightdm/lightdm.conf.d/50-guest-wrapper.conf \
	2>/dev/null;
	tput cuu1;
	#Reiniciem la variable de comprovació a l'estat inicial
	allowguest_check="allow-guest=true"; 
	}
fi;
#Inicialitzem les variables dels estats possibles
allowguest_false="allow-guest=false";
allowguest_true="allow-guest=true";
#
# 
case $allowguest in #Comprovem el valor de la resposta de l'usuari
	0) #Si l'usuari ha respòs Sí (exit code 0) per amagar convidat
  		#Si la comprovacio de configuració no correspon a amagat
		if [ $allowguest != $allowguest_false ]; then
			{
			#Afegim la linia allow-guest al fitxer de configuració per amagar l'usuari convidat
  			sudo -S sed -i 's/'$allowguest_check'*/allow-guest=false/g' '/usr/share/lightdm/lightdm.conf.d/50-guest-wrapper.conf' 2>/dev/null;
			tput cuu1;
			}
		fi;
		# Mostrem el missatge de confirmació a l'usuari  
		zenity --info \
			--title "Configuració de la pantalla d'inici de sessió" \
			--text "La <b>Sessió de convidat</b> ha estat ocultada a la pantalla d'inici de sessió." \
			--ok-label="D'acord" \
			2>/dev/null;
  		#
  		#
		##############################################################
		# Si tenim ocultat l'usuari convidat podem ocultar la llista d'usuaris a la pantalla d'inici de sessió
  		zenity --question \
			--title "Configuració de la pantalla d'inici de sessió" \
			--text "Voleu ocultar la llista d'usuaris a la pantalla d'inici de sessió?" \
			--cancel-label="No" --ok-label="Sí" \
			2>/dev/null;
  		hideusers=$?; #Creem la variable de control per desar la resposta de la pregunta a l'usuari
  		#Comprovem la configuracio actual, per saber si la linia greeter-hide-users existeix al fitxer de configuracio
  		hideusers_check=`grep "greeter-hide-users*" '/usr/share/lightdm/lightdm.conf.d/50-greeter-wrapper.conf'`;
  		#Si la linia no existeix al fitxer de configuració
  		if [ "$hideusers_check" = "" ]; then
			{
			#Creem l'entrada i la posem en estat desactivat 
			sudo -S sed -i '$a greeter-hide-users=false\n' /usr/share/lightdm/lightdm.conf.d/50-greeter-wrapper.conf \
			2>/dev/null;
			tput cuu1;
			#Reiniciem la variable de comprovació a l'estat inicial
			hideusers_check="greeter-hide-users=false"; 
			}
  		fi;
		#Inicialitzem les variables dels estats possibles
		hideusers_false="greeter-hide-users=false";
		hideusers_true="greeter-hide-users=true";
		#
		#
		case $hideusers in #Comprovem el valor de la resposta de l'usuari
			0) #Si l'usuari ha respòs Sí (exit code 0) per amagar llista d'usuaris
				#Si la comprovacio de configuració no correspon a amagat
				if [ $greeterhideusers_check != $greeterhideusers_true ]; then
					{		
					#Afegim la linia greeter-hide-users al fitxer de configuració
		  			sudo -S sed -i 's/'$hideusers_check'*/greeter-hide-users=true/g' '/usr/share/lightdm/lightdm.conf.d/50-greeter-wrapper.conf' \
					2>/dev/null;
					tput cuu1;
					}
				fi;
	      			zenity --info \
					--title "Configuració de la pantalla d'inici de sessió" \
					--text "La llista d'usuaris ha estat ocultada a la pantalla d'inici de sessió." \			
					--ok-label="D'acord" \
					2>/dev/null;
		    	;;
    			1) #Si l'usuari ha respòs No (exit code 1) per amagar llista d'usuaris
				#Si la comprovacio de configuració no correspon a visible
				if [ $hideusers_check != $hideusers_false ]; then
					#Afegim la linia greeter-hide-users al fitxer de configuració
			  		sudo -S sed -i 's/'$hideusers_check'*/greeter-hide-users=false/g' '/usr/share/lightdm/lightdm.conf.d/50-greeter-wrapper.conf' \
					2>/dev/null;
					tput cuu1;
				fi;
      				zenity --info \
					--title "Configuració de la pantalla d'inici de sessió" \
					--text "La llista d'usuaris apareixerà a la pantalla d'inici de sessió." \
					--ok-label="D'acord" \
					2>/dev/null;
    			;;
  		esac
		#
		#
		##############################################################
		#
		#
	;;
	1) #Si l'usuari ha respòs No (exit code 1) per no amagar convidat
		#Si la comprovacio de configuració no correspon a visible
		if [ $allowguest != $allowguest_true ]; then
			{
			#Afegim la linia allow-guest=true al fitxer de configuració per activar convidat
  			sudo -S sed -i 's/'$allowguest_check'*/allow-guest=true/g' '/usr/share/lightdm/lightdm.conf.d/50-guest-wrapper.conf'\
			2>/dev/null;
			tput cuu1;
			#Desactivem ocultació de llista d'usuaris
			sudo -S sed -i '/greeter-hide-users=*/d' '/usr/share/lightdm/lightdm.conf.d/50-greeter-wrapper.conf' \
			2>/dev/null;
			tput cuu1;
			}
		fi;
		zenity --info \
			--title "Configuració de la pantalla d'inici de sessió" \
			--text "La <b>Sessió de convidat</b> apareixerà  a la pantalla d'inici de sessió." \
			--ok-label="D'acord" \
			2>/dev/null;
	;;
	5) #Si s'exhaureix el temps de resposta de l'usuari
		zenity --info \
			--title "Configuració de la pantalla d'inici de sessió" \
			--text "S'ha exhaurit el temps de resposta.\nNo s'ha fet cap canvi." \
			--ok-label="D'acord" \
			2>/dev/null;
	;;
	*) #Si es produeix un error que causa un altre exit code
		zenity --info \
			--title "Configuració de la pantalla d'inici de sessió" \
			--text "S'ha produit un error desconegut.\nNo s'ha fet cap canvi." \
			--ok-label="D'acord" \
			2>/dev/null;
	;;
esac
#
#
##############################################################
#
#
#
#
#
#
#
#
#
#
# Mostrem la llista d'usuaris del sistema triem l'usuari a configurar
# Inicialitzem variables d'usuari i pagina d'inici
usersetup=0
homesetup=0
# Mentre l'usuari decideixi configurar un usuari
while [ $usersetup == 0 ]
do 
{
all_created=""
if [[ $super_created == "super" ]] ; then all_created=$all_created" "$super_created ; fi;
if [[ $prof_created == "prof" ]] ; then all_created=$all_created" "$prof_created ; fi;
if [[ $argo_created == "argo" ]] ; then all_created=$all_created" "$argo_created ; fi;
zenity --warning \
		--title="Configuració de Navegadors Web" \
		--text="Cal que inicieu sessió amb els usuaris <b>$all_created</b> abans d'establir la configuració dels navegadors.\nPodeu fer-ho ara i després tornar a aquest punt per continuar." \
		--width=500 --height=150 \
		--ok-label="D'acord" 2>/dev/null;
all_created=""
# Mostrem la llista d'usuaris
usuari=$(NUM=$(cat /etc/passwd | cut -d: -f3) # > tmp/user
MIN="1000"
MAX="2000"
for ID in do $NUM; do
    if [ $ID -ge $MIN > /dev/null 2>&1 ] && [ $ID -lt $MAX > /dev/null 2>&1 ]; then
                USER=$(cat /etc/passwd | cut -d: -f1-3 | grep $ID | cut -d: -f1)
                echo "$USER"
        fi
done | zenity --list \
		--column "Usuari"\
		--title="Configuració de Navegadors Web" \
		--text="Trieu un usuari per iniciar la configuració.\nSi no voleu canviar cap usuari, feu clic a Sortir" \
		--width=350 --height=300 \
		--cancel-label="Sortir" --ok-label="Configurar" 2>/dev/null);
# Recollim la selecció de l'usuari i la desm a la variable corresponent
usersetup=$?;
#
#
case $usersetup in
0)
# Mostrem la llista de pàgines d'inici possibles
homepage=$(zenity --list --radiolist \
	--column "Estableix" \
	--column "Lloc web" \
	--column "Adreça URL"\
	--title="Configuració de Navegadors Web" \
	--text="Trieu una pàgina d'inici per als navegadors que utilitzarà l'usuari $usuari" \
	FALSE "XTEC" "http://xtec.gencat.cat" \
	FALSE "edu365" "http://edu365.cat" \
	FALSE "JClic" "http://clic.xtec.cat" \
	FALSE "Google" "http://google.cat" \
	--width=500 --height=300 --cancel-label="Vull establir una pàgina diferent" --ok-label="D'acord" \
	2>/dev/null );
# Recollim la selecció de la pàgina d'inici
homesetup=$?;
case $homesetup in
0)
	case $homepage in
		XTEC)
		homepage="http://xtec.gencat.cat"
		;;
		edu365)
		homepage="http://edu365.cat"
		;;
		JClic)
		homepage="http://clic.xtec.cat/db/listact_ca.jsp"
		;;
		Google)
		homepage="http://google.cat"
		;;
	esac
;;
1) # Si l'usuari fa clic en el botó per triar una pàgina diferent
homepage=$(zenity --entry \
	--title="Configuració de Navegadors Web" \
	--text="Escriviu la URL de la pàgina d'inici que voleu establir:" \
	--width=500 --height=100 \
	2>/dev/null) ;
;;
*)
exit 1;
;;
esac
#
#
# Tanquem firefox en cas que estigui obert
sudo -S pkill firefox;
# Cerquem el nom del directori de configuració de firefox
firefoxdir=$(sudo -S ls -liad /home*/$usuari/.mozilla/firefox/*.default* | cut -d" " -f11);
# Cerquem el fitxer de perfil de firefox
firefoxfile=$(sudo -S ls -lia $firefoxdir/prefs.js | cut -d" " -f11);
# Eliminem la linia actual de la pagina d'inici
sudo -S sed -i '/browser.startup.homepage*/d' $firefoxfile ;
#
# Inserim la nova pagina d'inici
sudo -S echo 'user_pref("browser.startup.homepage", "'$homepage'");' >> $firefoxfile
# Establim firefox com a navegador per defecte a l'usuari triat
sudo su - $usuari -c 'firefox -setDefaultBrowser' &
# Tanquem tots els processos de firefox
sudo su - $usuari -c 'pkill firefox'
sudo -S pkill firefox
# Mostrem missatge de configuració correcta
zenity --info \
	--title="Configuració de Navegadors Web" \
	--text="S'ha establert Firefox com a navegador per defecte" \
	--ok-label="D'acord" 2>/dev/null ;
;;
#
#
1)
# Si es tria que no volem configurar cap altre usuari sortim del bucle
if [ $usersetup == 1 ]; then 
zenity --info \
	--title="Configuració de Navegadors Web" \
	--text="Heu cancel·lat la configuració de navegadors per als usuaris." \
	--width=450 --ok-label="D'acord" 2>/dev/null ;
fi
;;
*)
zenity --info \
	--title="Configuració de Navegadors Web" \
	--text="S'ha produït un error desconegut.\nTorneu a executar la configuració." \
	--width=450 --ok-label="D'acord" 2>/dev/null ;
;;
esac
}
done;
clear
#
#
##############################################################
#
#
#
#
#
#
#
#
#
#
zenity --question \
	--text "La configuració inicial del vostre sistema ha acabat satisfactòriament.\nCal que reinicieu el vostre ordinador per aplicar tots els canvis.\n\nVoleu reiniciar ara?" \
	--title "Configuració inicial de Linkat 16-04" 
	--width=500 \
	2>/dev/null;
case $? in
	0) sudo -S reboot		
	;;
	1)
	zenity --info \
		--text "Heu triat no reiniciar el vostre ordinador ara.\Tingueu en compte que alguns canvis no s'aplicaran fins que no ho feu." \
		--title "Configuració inicial de Linkat 16-04" 
		--width=500 \
		2>/dev/null;
	;;
esac
}
# Si l'usuari que ha executat l'script no és root mostrem advertencia i sortim
else
{
zenity --warning \
	--text "No teniu privilegis suficients per executar aquest programa.\nProveu d'executar el programa com a super-usuari." \
	--title "Configuració inicial de Linkat 16-04" 
	--width=500 \
	2>/dev/null;
exit 1
}
fi;
