#!/bin/bash
source functions.shinc
read -p "Ingrese nombre del usuario a cambiar contraseña: " username
  if [ -z "$username" ]; then
    echo -n "El campo esta vacio"
    read n
  else
    if getent passwd "$username" > /dev/null; then #Verificar la existencia del usuario
      passwd "$username"
	if [ $? -eq 0 ]; then
			echo "Contraseña del usuario ($username) cambiada correctamente"
			write_log "Cambio la contraseña del usuario $username"
			read n
		else
			echo "Ocurrio un eror, el usuario ($username) no fue modificado"
			read n
		fi
    else
      echo "El usuario ($username) no existe"
      read n
    fi
  fi
