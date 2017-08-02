#!/bin/bash
source functions.shinc
write_log "Se ingreso al menu del respaldo del log"

DEFAULT_USERCONF=userlist.conf

#Cargar contenido del archivo
username=( $(cat $DEFAULT_USERCONF | cut -f1 -d":") )
user_name=( $(cat $DEFAULT_USERCONF | cut -f2 -d":" | cut -f1 -d"," ) )
user_lastname=( $(cat $DEFAULT_USERCONF | cut -f2 -d":" | cut -f1 -d"," ) )
user_phone=( $(cat $DEFAULT_USERCONF | cut -f2 -d":" | cut -f1 -d"," ) )
user_ci=( $(cat $DEFAULT_USERCONF | cut -f2 -d":" | cut -f1 -d",") )



n=$(( ${#username[@]} - 1 )) #Largo del array

#Recorrer todos los array
count=0
while [ $count -lt $n ]; do
count=$(( $count + 1 ))
#Crear un archivo SQL con las sentencias
echo "${log_date[$count]}","${log_time[$count]}","${log_host[$count]}","${log_output[$count]}") > InsertLog.sql

#Dirty hack para el return
if [ $? -eq 0 ]; then
	echo_return=0
else
	echo_return=1
fi
done
#Verifico el return del while
if [ $echo_return -eq 0 ]; then
	echo "Se crearon un total de $n sentancias a partir del log en el fichero InsertLog.sql"
	write_log "Se crearon un total de $n sentencias a partir de log en InsertLog.sql"
	sleep 2
else
	echo "Ocurrio un error al exportar el log, abortando"
	write_log "Ocurrio un error al exportar el log"
	sleep 2
fi


