#!/bin/bash
source functions.shinc
read -p "Ingrese nombre del usuario a eliminar: " username
  if [ -z "$username" ]; then
    echo -n "El campo esta vacio"
    sleep 2
  else
    if getent passwd "$username" > /dev/null; then #Verificar la existencia del usuario
      userdel "$username" 

	if [ $? -eq 0 ]; then
			echo "Usuario ($username) eliminado correctamente"
			write_log "Se elimino el usuario $username"
			sleep 2
		else
			echo "Ocurrio un error, el usuario ($username) no fue eliminado"
			sleep 2
	fi
    else #En caso de no existir el usuario
      echo "El usuario ($username) no existe en el sistema"
      write_log "Se intento eliminar un usuario no existente ($username)"
      sleep 2
    fi
  fi
