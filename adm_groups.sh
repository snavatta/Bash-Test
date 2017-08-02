#! /bin/bash
source functions.shinc
COUNTER=0
while [  $COUNTER -lt 10 ]; do  #Cuando counter==10 sale
clear
#MENU
echo "Kreatekno SRL | Versión 05 (15 de octubre)"
echo "GESTION DE GRUPOS"
echo "1. Mostrar grupos actuales de un usuario"
echo "2. Crear grupo"
echo "3. Agregar usuario a un grupo"
echo "4. Remover usuario de un grupo"
echo "5. Remover grupo"
echo "0. Salir"

#LEE ENTRADA
read -p "Ingrese una opcion [0-5] " option
case "$option" in

#MOSTRAR INFO DE USUARIO
1) 
write_log "Ingreso al menu mostrar grupos de usuario"
read -p "Ingrese nombre del usuario a mostrar grupo: " username
  if [ -z "$username" ]; then
    echo -n "El campo esta vacio"
    sleep 2
  else
    if getent passwd "$username" > /dev/null; then
      echo "Grupos a los que pertenece el usuario: $username"
      id -nG "$username"
      write_log "Solicito informacion del usuario $username"
      sleep 2
    else
      echo -n "El usuario $username no existe"
	write_log "Se solicito informacion sobre el usuario $username pero el mimsmo no existe"
      sleep 2
    fi
  fi
;;

#CREAR GRUPO
2) 
write_log "Ingreso al menu crear grupo"
read -p "Ingrese nombre del grupo a crear: " group
  if [ -z "$group" ]; then
    echo -n "El campo esta vacio"
    sleep 2
  else
    if getent group "$group" > /dev/null; then #Verificar la existencia del grupo
      echo -n "El grupo $group ya existe"
      sleep 2
    else
      groupadd "$group" 
	if [ $? -eq 0 ];then
		echo -n "Grupo ($group) creado sastifactoriamente"
		write_log "Creacion del grupo $grupo"
		sleep 2
	else
		echo -n "Ocurrio un error al crear el grupo ($group)"
		write_log "Hubo un error al crear el grupo $grupo"
		sleep 2
	fi
    fi  
  fi
;;

#AGREGAR USUARIO A GRUPO
3)
write_log "Ingreso al menu agregar usuario a grupo"
read -p "Ingrese nombre del usuario a agregar a un grupo: " username
if [ -z "$username" ]; then
  echo -n "El campo esta vacio"
  sleep 2
  else
  if getent passwd "$username" > /dev/null; then #Verificar la existencia del usuario
    read -p "Ingrese nombre del grupo: " group
    if getent group "$group" > /dev/null; then
      gpasswd -a "$username" "$group" > /dev/null 
	if [ $? -eq 0 ];then
		echo -n "Usuario agregado al grupo $group correctamente"
      		write_log "Agrego al usuario $username al grupo $group"
		sleep 2
	else
		echo -n "Ocurrio un error al remover el usuario ($username) del grupo"
		write_log "Hubo un error al remover el usuario $username del grupo $grupo"
		sleep 2
	fi
    else
      echo "El grupo $group no existe"
      sleep 2
    fi
  else
          echo -n "El usuario no existe"
          sleep 2
  fi
 fi
;;

#ELIMINAR USUARIO DE GRUPO
4)
write_log "Ingreso al menu eliminar usuario de grupo"
read -p "Ingrese nombre del usuario a remover de un grupo: " username
if [ -z "$username" ]; then
  echo -n "El campo esta vacio"
  sleep 2
  else
  if getent passwd "$username" > /dev/null; then #Verificar la existencia del usuario
    echo -n "Ingrese nombre del grupo: "
    read group
    if getent group "$group" > /dev/null; then
      gpasswd -d "$username" "$group" > /dev/null
	if [ $? -eq 0 ];then
		echo -n "Usuario removido del grupo ($group) correctamente"
		write_log "Removido el usuario $username del grupo $group"
		sleep 2
	else
		echo -n "Ocurrio un error al remover el usuario ($username) del grupo"
		write_log "Hubo un error al remover el usuario $username del grupo $group"
		sleep 2
	fi
      sleep 2
    else
      echo "El grupo $group no existe"
      sleep 2
    fi
  else
          echo -n "El usuario no existe"
          sleep 2
  fi
 fi
;; 

#REMOVER GRUPO
5)
write_log "Ingreso al menu remover grupo"
read -p "Ingrese el nombre del grupo a eliminar: " group

if [ -z "$group" ]; then
    echo -n "El campo esta vacio"
    sleep 2
  else
    if getent group "$group" > /dev/null; then #Verificar la existencia del grupo
	 groupdel "$group"
	 if [ $? -eq 0 ];then
		echo -n "El grupo ($group) fue removido correctamente"
		write_log "Removido el grupo $group"
		sleep 2
	else
		echo -n "Ocurrio un error al remover el grupo ($group)"
		write_log "Hubo un error al remover el grupo $group"
		sleep 2
	fi
    else
      echo "El grupo no existe."
      sleep 2
    fi  
  fi
;;

#SALIDA
0) 
write_log "Salida de gestion de grupos"
COUNTER=10
;;
esac
done
#FIN
