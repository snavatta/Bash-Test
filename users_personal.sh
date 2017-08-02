#! /bin/bash
source functions.shinc
COUNTER=0
while [ $COUNTER -lt 10 ]; do  #Cuando counter_personal==10 sale
  read -p "Ingrese nombre del usuario a cambiar informacion: " username
  if [ -z "$username" ]; then
    echo "El campo esta vacio"
    sleep 2
  else
      if egrep "^$username:" /etc/passwd; then #Verificar la existencia del usuario
      write_log "Se ingreso al menu para modificar comentario del usuario $username"
      COUNTER_PERSONAL=0
      while [  $COUNTER_PERSONAL -lt 10 ]; do  #Cuando counter_personal==10 sale
      #MENU
      clear
      echo "Ingrese el campo que desea modificar"
      echo "1. Nombre"
      echo "2. Apellido"
      echo "3. Telefono"
      echo "4. Cedula de identidad"
      echo "0. Cancelar"
      
      #CARGA VARIABLES
      name_old=$(egrep "^$username:" /etc/passwd | cut -f5 -d: | cut -f1 -d,)
      lastname_old=$(egrep "^$username:" /etc/passwd | cut -f5 -d: | cut -f2 -d,)
      phone_old=$(egrep "^$username:" /etc/passwd | cut -f5 -d: | cut -f3 -d,)
      ci_old=$(egrep "^$username:" /etc/passwd | cut -f5 -d: | cut -f4 -d,)
      
      #LEE ENTRADA
      read -p "Ingrese una opción [0-4] " option
      case "$option" in

      #Cambiar nombre
      1)
      echo "El nombre actual es: $name_old"
      go_ahead=0
      while [  $go_ahead -lt 10 ]; do
                read -p "Ingrese nuevo nombre: " name_new
  		if onlytext_verif "$name_new"; then
			go_ahead=10	
		fi

        done
      echo "El nombre ingresado es: $name_new"
      read -p "Confirmar [S/n]: " response
      if echo "$response" | egrep -xq "[sS]"; then
      usermod $username -c "$name_new,$lastname_old,$phone_old,$ci_old"
	if [ $? -eq 0 ]; then
		echo "Campo modificado"
		write_log "Cambio el nombre del usuario $username de $name_old a $name_new"
		sleep 2
	else
		echo "Ocurrio un error, el usuario ($username) no fue modificado"
		sleep 2
	fi
      else
      echo "La operacion fue cancelada"
      sleep 2
      fi
      ;;

      #Cambiar apellido
      2)
      echo "El apellido actual es: $lastname_old"
      go_ahead=0
      while [  $go_ahead -lt 10 ]; do
                read -p "Ingrese nuevo apellido: " lastname_new
  		if onlytext_verif "$lastname_new"; then
			go_ahead=10	
		fi

        done
      echo "El apelllido ingresado es: $lastname_new"
      read -p "Confirmar [S/n]" response
      if echo "$response" | egrep -xq "[sS]"; then
      usermod $username -c "$name_old,$lastname_new,$phone_old,$ci_old" 
	if [ $? -eq 0 ]; then
		echo "Campo modificado"
		write_log "Cambio el apellido del usuario $username de $lastname_old a $lastname_new"
		sleep 2
	else
		echo "Ocurrio un error, el usuario ($username) no fue modificado"
		sleep 2
	fi
      else
      echo "La operacion fue cancelada"
      sleep 2
      fi
      ;;

      #Cambiar telefono
      3)
      echo "El telefono actual es: $phone_old"
      go_ahead=0
        while [  $go_ahead -lt 10 ]; do
           read -p "Ingrese nuevo telefono: " phone_new
              if onlyint_verif "$phone_new"; then
			go_ahead=10	
		fi
        done
      echo "El telefono ingresado es: $phone_new"
      read -p "Confirmar [S/n]" response
      if echo "$response" | egrep -xq "[sS]"; then
      usermod $username -c "$name_old,$lastname_old,$phone_new,$ci_old"

	if [ $? -eq 0 ]; then
		echo "Campo modificado" 
		write_log "Cambio el telefono del usuario $username de $phone_old a $phone_new"
		sleep 2
	else
		echo "Ocurrio un error, el usuario ($username) no fue modificado"
		sleep 2
	fi
      else
      echo "La operacion fue cancelada"
      sleep 2
      fi
      ;;

      #Cambiar CI
      4)
      echo "El documento actual es: $ci_old"
      go_ahead=0
        while [  $go_ahead -lt 10 ]; do
             read -p "Ingrese nuevo documento: " ci_new
	if ci_verif "$ci_new"; then
			go_ahead=10	
		fi
        done
      echo "El documento ingresado es: $ci_new"
      read -p "Confirmar [S/n]" response
      if echo "$response" | egrep -xq "[sS]"; then
      usermod $username -c "$name_old,$lastname_old,$phone_old,$ci_new"
	if [ $? -eq 0 ]; then
		echo "Campo modificado"
		write_log "Cambio el documento del usuario $username de $ci_old a $ci_new"
		sleep 2
	else
		echo "Ocurrio un error, el usuario ($username) no fue modificado"
		sleep 2
	fi
      else
      echo "La operacion fue cancelada"
      sleep 2
      fi
      ;;
      #Cancelar
      0)
      write_log "Salio del menu edicion de comentario"
      COUNTER_PERSONAL=10
      ;;  
      esac  
      done  
    else
      echo "El usuario $username no existe"
      sleep 2
    fi
  fi
COUNTER=10
done

