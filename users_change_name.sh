#!/bin/bash
source functions.shinc
echo -n "Ingrese nombre del usuario a cambiar: "
read username
  if [ -z "$username" ]; then
    echo -n "El campo esta vacio"
  else
    if getent passwd "$username" > /dev/null; then #Verificar la existencia del usuario
      echo -n "Ingrese un el nuevo nombre de usuario: "
      read username_new
      if [ -z "$username" ]; then
        echo -n "El campo esta vacio"
        sleep 2
      else
        usermod -l "$username_new" "$username" 
		if [ $? -eq 0 ]; then
			echo "El usuario $username ahora se llama $username_new"
		        write_log "Cambio el nombre de usuario de $username por $username_new"
			sleep 2
		else
			echo "El usuario $username no fue modificado"
			sleep 2
		fi
      fi
    else #En caso de no existir el usuario
      echo "El usuario $username no existe"
      sleep 2
    fi
  fi
