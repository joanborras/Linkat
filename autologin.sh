#!/bin/bash
#autologin.sh
#Script per automatitzar la selecció d'inici de sessió automàtic a la Linkat lleugera 14.04
#Copyright 2016 JBA
#
#
#Mostrem la capçalera del programa
echo \ ;
echo "--- Selecció d'inici automàtic de sessió d'usuari ---";
#Identifiquem la versió del sistema i la mostrem
release=`lsb_release -d | cut -d: -f 2`;
echo \ ;
echo $release;
#
#
#Primera part: Buscar els usuaris del sistema amb capacitat d'iniciar sessió
#
#Llistem els noms d'usuaris del sistema amb identificador de grup major que 1000
#Recorrem la llista sencera i la desem en un fitxer
cat /etc/passwd | cut -d: -f 1 > usuari
#Per cada usuari cerquem el grup principal al que pertany
for i in $(cat usuari);
   do
      usuari=$i;
      gid=`grep "^$i:" /etc/passwd | cut -f 4 -d:`;
      grup=`grep ":"$gid":" /etc/group | cut -f 1 -d:`;
      if (($gid>=1000)); then
         #Si el grup principal de l'usuari és major que 1000 el desem
         #echo $usuari":"$grup >> usugru;
         echo $usuari >> usugru;
      fi
   done
#Ordenem la llista d'usuaris i la mostrem 
echo \ ;
echo "Llista d'usuaris del sistema:";
sort -k 1 usugru
#
#
#Segona part: Demanar el usuari per inici automatic de sessió
#
#Preguntem el usuari que volem configurar el inici de sessió automàtic
echo \ ;
echo "Escriviu el nom de la sessió d'usuari que voleu iniciar de manera automàtica:";
#Establim un valor buit per a la variable de comprovacio de usuari existent al sistema
user_assigned_check=" ";
#Demanem el nom de usuari mentre aquest no correspongui a cap usuari del sistema
until [ "$user_assigned" = "$user_assigned_check" ]; do
   read user_assigned;
   echo \ ;
   #Busquem si el  usuari indicat existeix a la llista de usuaris
   user_assigned_check=`grep "$user_assigned" ./usuari`;
   #Si el usuari no existeix mostrem un missatge per indicar que cal demanar-lo de nou
   if [ "$user_assigned" != "$user_assigned_check" ]; then
      echo "Aquest usuari no existeix en el sistema.";
      echo "Si us plau, entreu un nom d'usuari correcte:";
   fi;
done;
#Creem la linia per afegir al fitxer de configuració
autologin_user="autologin-user="$user_assigned;
#Afegim la linia autologin al fitxer de configuració
#Comprovem la linia actual
autologin_check=`grep $autologin-user /etc/lightdm/lightdm.conf.d/20-lubuntu.conf`;
#autologin_check=`grep $autologin-user /home/joan/20-lubuntu.conf`;
#Si el usuari que acabem de entrar es el mateix que ja apareix, no fem cap canvi
if [ "$autologin_user" = "$autologin_check" ]; then
   echo "No s'han fet canvis en la selecció d'inici de sessió d'usuari per defecte.";
#I sino es el mateix substituim la linia de autologin
else
   sed -i 's/'$autologin_check'/'$autologin_user'/g' '/etc/lightdm/lightdm.conf.d/20-lubuntu.conf';
   echo "Heu triar iniciar el sistema amb el usuari "$user_assigned" per defecte.";
   echo ;
fi;
#
#
#Tercera part: Eliminem els valors de les variables i els fitxers temporals creats
#
autologin_user=''
autologin_check=''
rm ./usugru
rm ./usuari


