#! /bin/bash
source functions.shinc
COUNTER=0
while [  $COUNTER -lt 10 ]; do  #Cuando counter==10 sale
#MENU
clear screen
echo "Kreatekno SRL | Versión 01"
echo "BLOQUEO Y DESBLOQUEO"
echo "Que desea hacer?"
echo "1. Consultar estado"
echo "2. Bloquear"
echo "3. Desbloquear"
echo "0. Volver"

#LEE ENTRADA
read -p "Ingrese una opción [0-3] " option
case "$option" in

#CONSULTAR ESTADO
1) 
write_log "Ingreso al menu consultar bloqueo de usuario"
read -p "Ingrese nombre del usuario a consultar estado: " username
  if [ -z "$username" ]; then
    echo -n "El campo esta vacio"
  else
    if getent passwd "$username" > /dev/null; then #Verificar la existencia del usuario
      write_log "Consulto el estado de bloqueo del usuario $username"

      if [ $(egrep "^$username:" /etc/shadow | cut -f2 -d: | grep "!") ]; then
        echo -n "El usuario $username esta bloqueado"
        sleep 2
      else
        echo "El usuario $username esta activo"
        sleep 2
      fi
    else #En caso de no existir el usuario
      echo "El usuario $username no existe"
      sleep 2
    fi
  fi
;;

#BLOQUEAR USUARIO
2) 
write_log "Ingreso al menu bloquear usuario"
read -p "Ingrese nombre del usuario a bloquear: " username
  if [ -z "$username" ]; then
    echo -n "El campo esta vacio"
    sleep 2
  else
    if getent passwd "$username" > /dev/null; then #Verificar la existencia del usuario
        
      if [ $(egrep "^$username:" /etc/shadow | cut -f2 -d: | grep "!") ]; then
        echo -n "El usuario $username ya esta bloqueado"
        sleep 2
      else
        usermod -L $username 
		if [ $? -eq 0 ]; then
			echo "El usuario $username fue bloqueado"
       			write_log "El usuario $username fue bloqueado"
			sleep 2
		else
			echo "El usuario $username no fue bloqueado"
			sleep 2
		fi

      fi
    else #En caso de no existir el usuario
      echo "El usuario $username no existe"
      sleep 2
    fi
  fi
;;

#DESBLOQUEAR USUARIO
3) 
write_log "Ingreso al menu desbloquear usuario"
read -p "Ingrese nombre del usuario a desbloquear: " username
  if [ -z "$username" ]; then
    echo -n "El campo esta vacio"
    sleep 2
  else
    if getent passwd "$username" > /dev/null; then #Verificar la existencia del usuario
      
 if [ $(egrep "^$username:" /etc/shadow | cut -f2 -d: | grep "!") ]; then
        usermod -U $username 
	if [ $? -eq 0 ]; then
			echo "El usuario $username fue desbloqueado"
      			write_log "El usuario $username fue desbloqueado"
			sleep 2
		else
			echo "El usuario $username no fue creado"
			sleep 2
		fi
      else
        echo "El usuario $username no esta bloqueado"
        sleep 2
      fi
    else #En caso de no existir el usuario
      echo "El usuario $username no existe"
      sleep 2
    fi
  fi
;;

#Cancelar
0)
write_log "Salida del menu de bloqueos/desbloqueos"
COUNTER=10
;;  
esac
done    
