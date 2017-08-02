#!/bin/bash
source functions.shinc

exit_user_add=0

while [ $exit_user_add -lt 10 ]; do
read -p "Ingrese nombre del usuario que desea añadir: " username

if onlytext_verif "$username"; then
if getent passwd "$username" > /dev/null; then #Verificar la existencia del usuario
      echo "Error, el usuario existe"
      sleep 2
    else
      exit_info=0      
      while [ $exit_info -lt 10 ]; do
                                 
        #Preguntar datos sobre usuario
        echo "Ingrese informacion del usuario"
        go_ahead=0
        while [  $go_ahead -lt 10 ]; do
                read -p "Nombre: " user_name
  		if onlytext_verif "$user_name"; then
			go_ahead=10	
		fi
        done
        go_ahead=0
        while [  $go_ahead -lt 10 ]; do
                read -p "Apellido: " user_lastname
                if onlytext_verif "$user_lastname"; then
			go_ahead=10	
		fi
        done
        go_ahead=0
        while [  $go_ahead -lt 10 ]; do
          read -p "Teléfono: " user_phone
                if onlyint_verif "$user_phone"; then    
			go_ahead=10
		fi
        done
        go_ahead=0
        while [  $go_ahead -lt 10 ]; do
          read -p "Cedula de identidad (sin puntos ni guiones): " user_ci
	if ci_verif "$user_ci"; then
		go_ahead=10
	fi
        done
        echo "Usted a ingresado la siguiente informacion"
        echo "Nombre de usuario: $username"
        echo "Informacion personal:"
        echo "Nombre: $user_name"
        echo "Apellido: $user_lastname"
        echo "Telefono: $user_phone"
        echo "Documento: $user_ci"
        read -p "Crear usuario? S/n" go_ahead_input
        if echo "$go_ahead_input" | egrep -xq "[sS]"; then
	useradd -m -s /bin/bash -k /etc/skel -c "$user_name,$user_lastname,$user_phone,$user_ci" $username 
		if [ $? -eq 0 ]; then
			echo "Usuario $username creado"
			write_log "Creo el usuario $username"
			sleep 2
		else
			echo "El usuario $username no fue creado"
			sleep 2
		fi
	exit_info=10
	exit_user_add=10
        else
		echo "Salida (no se confirmo la entrada)"
		sleep 2
        	exit_info=10
		exit_user_add=10
        fi        
        done
    fi      
fi
done
