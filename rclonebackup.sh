#!/bin/bash
# rclonebackup.sh
# Automatització de còpies amb rclone organitzades en directoris per data.
# Versió 1.0
# Joan Borràs - Abril 2020 
#
#
# Aquest script requereix la configuració prèvia del repositori remot mijançant rclone config per a l'usuari root
# Aquest script pot ser cridat des de crontab per automatitzar la tasca de còpia demanera regular.
#
#
# Comprovem si  el script ja s'està executant
if pidof -x $(basename $0) > /dev/null; then
  for p in $(pidof -x $(basename $0)); do
    if [ $p -ne $$ ]; then
      echo "La tasca $0 ja s'està executant."
      exit
    fi
  done
fi
#
#
# Definbició de variables
# Preparació del directori i fitxer de logs
# Ruta del directori de logs
LOGSDIR=/var/log/rclone
# Comprovem si el directori existeix i sino el creem
if ! test -d "$LOGSDIR" ; then sudo mkdir -p  $LOGSDIR; fi
# Ruta del fitxer de logs de rclone
LOGSRCLONEFILE=$LOGSDIR/rclone.log
# Comprovem si el fitxer existeix i sino el creem
if ! test -f "$LOGSRCLONEFILE"; then sudo cat > $LOGSRCLONEFILE; fi; sudo chmod 777  $LOGSRCLONEFILE
# 
# Data i hora de l'inici de copia que dona nom al subdirectori
DATETIME=$(date +%F_%T)
# Ruta del directori local a copiar (Cal modificar aquest valor amb el que desitgi l'usuari)
LOCALPATH='/srv/exports/'
# Ruta del repositori remot (Cal modificar aquest valor amb el que desitgi l'usuari)
REMOTEREPO='GoogleDrive:/CopiaSeguretatServidor/'
# Ruta del directori remot on es desa la copia
REMOTEPATH=$REMOTEREPO$DATETIME
# Comanda de rclone
COMMAND='rclone sync '
# Caracter deparador
BLANK=' '
# Opcions de copia
# -P mostra el procés
# -L ignora els enllaços
# --create-empty-src-dirs sincronitza els directoris buits
FLAGS=' -P -L --create-empty-src-dirs'
#--log-file=$LOGSRCLONEFILE'
#
#
# Procés de sincronització
# Creació del log de data i hora d'inici
sudo echo '*********************************************************************************************' > $LOGSRCLONEFILE
sudo echo $DATETIME' --- Started --- "'$COMMAND$LOCALPATH$REMOTEPATH$FLAGS'"' >> $LOGSRCLONEFILE
sudo echo '*********************************************************************************************' >> $LOGSRCLONEFILE
# Procés de còpia de dades
sudo $COMMAND$LOCALPATH$BLANK$REMOTEPATH$FLAGS >> $LOGSRCLONEFILE
# Creació del log de data i hora d'acabament
sudo echo '*********************************************************************************************' >> $LOGSRCLONEFILE
sudo echo $DATETIME' --- Finished --- "'$COMMAND$LOCALPATH$REMOTEPATH$FLAGS'"' >> $LOGSRCLONEFILE 
sudo echo '*********************************************************************************************' >> $LOGSRCLONEFILE
#


