#!/bin/bash
###############
#Kreatekno SRL#
###############
source functions.shinc
write_log "Se ingreso al menu del respaldo del log"

#Crear SQL
log_date=( $(cat $DEFAULT_LOG | cut -f1 -d";") )
log_time=( $(cat $DEFAULT_LOG | cut -f2 -d";") )
log_host=( $(cat $DEFAULT_LOG | cut -f3 -d";") )
mapfile -t log_output < <(cat $DEFAULT_LOG | cut -f4 -d";") #Array con espacios

n=$(( ${#log_date[@]} )) #Largo del array

#Recorrer todos los array
count=0
> InsertLog.sql
while [ $count -lt $n ]; do
#Crear un archivo SQL con las sentencias
echo "INSERT INTO shell_log VALUES("${log_date[$count]}","${log_time[$count]}","${log_host[$count]}","${log_output[$count]}");" >> InsertLog.sql
#Dirty hack para el return
if [ $? -eq 0 ]; then
	echo_return=0
else
	echo_return=1
	count=$n
fi
count=$(( $count + 1 ))
done

#Verifico el return del while
if [ $echo_return -eq 0 ]; then
	n=$(( $n + 1 ))
	echo "Se crearon un total de $n sentancias a partir del log en el fichero InsertLog.sql"
	write_log "Se crearon un total de $n sentencias a partir de log en InsertLog.sql"

	#Añadir la ultima sentencia (errata)
	log_date=( $(tail -1 $DEFAULT_LOG | cut -f1 -d";") )
	log_time=( $(tail -1 $DEFAULT_LOG | cut -f2 -d";") )
	log_host=( $(tail -1 $DEFAULT_LOG | cut -f3 -d";") )
	mapfile -t log_output < <(tail -1 $DEFAULT_LOG | cut -f4 -d";") #Array con espacios
	echo "INSERT INTO shell_log VALUES("${log_date[@]}","${log_time[@]}","${log_host[@]}","${log_output[@]}");" >> InsertLog.sql
	sleep 2
else
	echo "Ocurrio un error al exportar el log, abortando"
	write_log "Ocurrio un error al exportar el log"
	sleep 2
fi


#Enviar las sentencias
#dbaccess kreatekno InsertLog.sql
