#! /bin/bash
source functions.shinc
COUNTER=0
while [  $COUNTER -lt 10 ]; do  #Cuando counter==10 sale
clear screen
echo "Kreatekno SRL | Versión 03 (18 de octubre)"
echo "Respaldos (en construccion)"
echo "1. Respaldar HOME de un usuario"
echo "2. Restaurar HOME de un usuario"
echo "3. Establecer un respaldo automatico"
echo "4. Respaldar el log en Informix"
echo "0. Salir"

#LEE ENTRADA
read -p "Ingrese una opción [0-2] " option
case "$option" in

#RESPALDO DE HOME
#Seleccionar el usuario
#Establecer ruta de respaldo
#Verificar el respaldo
1)
exit_user_backup=0
while [ $exit_user_backup -lt 10 ]; do
	exit_user_ask=0
	while [ $exit_user_ask -lt 10 ]; do
		read -p "Ingrese nombre del usuario: " username
		#Verificar la existencia del home de usuario
		if [ -d /home/$username ]; then
			#El home existe, se continua
			echo "El home es valido"
			exit_user_ask=10
		else
			echo "El home no existe"
		fi
	done
	exit_route_ask=0
	while [ $exit_route_ask -lt 10 ]; do
		read -p "Ingrese ruta completa para el destino del respaldo (en caso de vacio se usara la ruta por defecto /home/backups/$username)" backup_route
		
		if [ -z $backup_route ]; then
			backup_route="/home/backups/$username"
			if [ -d $backup_route ]; then
				echo "El directorio base existe, se continua con el respaldo"
				exit_route_ask=10
				sleep 2
			else
				echo "El directorio base no existe, se creara en la siguiente ruta $backup_route"
				sleep 2
				mkdir $backup_route
				if [ $? -eq 0 ]; then
					echo "Directorio base creado sastifactoriamente"
					sleep 2
					exit_route_ask=10
				else
					echo "Error al crear el directorio base, abortando"
					sleep 2
					exit_user_backup=10
				fi
			fi
		elif echo $backup_route | egrep -xq "[/a-zA-Z]+"; then
			if [ -d $backup_route ]; then
				echo "El directorio base existe, se continua con el respaldo"
				exit_route_ask=10
				sleep 2
			else
				echo "El directorio base no existe, se creara en la siguiente ruta $backup_route"
				sleep 2
				mkdir $backup_route
				if [ $? -eq 0 ]; then
					echo "Directorio base creado sastifactoriamente"
					sleep 2
					exit_route_ask=10
				else
					echo "Error al crear el directorio base, abortando"
					sleep 2
					exit_user_backup=10
				fi
			fi
		else
			echo "Ruta no valida"
			sleep 2
		fi
	done
	echo "Usted a ingresado la siguiente informacion"
        echo "Nombre de usuario: $username"
        echo "Ruta para el respaldo: $backup_route"
        read -p "Realizar respaldo? [S-n]" go_ahead_input
        if echo "$go_ahead_input" | egrep -xq "[sS]"; then
	tar czfp $backup_route/$username-$(date +%d%m%Y).tar.gz /home/$username
		if [ $? -eq 0 ]; then
			echo "Archivo de respaldo creada correctamente"
			write_log "Respaldo directorio home del usuario $username"
			sleep 2
		else
			echo "Ocurrio un error al respaldar el usuario ($username)"
			sleep 2
		fi
	exit_user_backup=10
        else
		echo "Salida (no se confirmo la entrada)"
		sleep 2
        	exit_user_backup=10
        fi        
done
;;

#RESTAURACIÓN DE HOME
#Seleccionar el usuario
#Establecer ruta del respaldo, verificarla
2)  
read -p "Ingrese nombre del usuario: " username 
if [ -d /home/$username ]; then #Verificar la existencia del home de usuario
echo -n "Ingrese una fecha en formato 22042014: " 
read input_date
tar -xzvf $username-$input_date.tar.gz -C  / && echo "Archivo de respaldo restaurado correctamente"
write_log "Se restauro el home del usuario $usuario"
read n
fi
;;


#CRON
#Establecer un respaldo automatico para el usuario elegido
3)

#SALIDA
0) 
 write_log "Salida de menu respaldos"
COUNTER=10
;;

esac
done
#FIN
