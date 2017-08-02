#! /bin/bash
source functions.shinc
write_log "Ingreso al menu principal"
COUNTER=0
while [  $COUNTER -lt 10 ]; do  #Cuando counter==10 sale
clear
echo "Kreatekno SRL | Versión 05 (15 de octubre)"
echo "MANTENIMIENTO DE USUARIOS Y GRUPOS"
echo "1. Información de un usuario (requiere finger, apt install finger)  "
echo "2. Mostrar usuarios activos en el sistema"
echo "3. Últimos usuarios conectados"
echo "4. Gestionar usuarios"
echo "5. Gestionar grupos"
echo "0. Salir"

#LEE ENTRADA
read -p "Ingrese una opción [0-5] " option
case "$option" in

#INFORMACIÓN DE USUARIO ACTUAL
1) 
write_log "Ingreso al menu consultar informacion de usuario"
echo -n "Ingrese nombre del usuario a consultar: "
read username
  if [ -z "$username" ]; then
    echo -n "El campo esta vacio"
    sleep 2
  else
    if getent passwd "$username" > /dev/null; then #Verificar la existencia del usuario
      finger "$username" #Finger del usuario apt install finger
      write_log "Consulto informacion sobre el usuario $username"
      sleep 2
    else
      echo -n "El usuario $username no existe"
      sleep 2
    fi
  fi
;;

#USUARIOS DEL SISTEMA
2) 
write_log "Solicito los usuarios activos en el sistema"
who
sleep 2
;;

#ULTIMOS USUARIOS CONECTADOS
3) 
write_log "Solicito los ultimos usuarios conectados al sistema"
last
sleep 2;;

#GESTIONAR USUARIOS
4)
write_log "Ingreso al menu Gestionar usuarios"
bash adm_users.sh
;;

#GESTIONAR GRUPOS
5) 
write_log "Ingreso al menu gestionar grupos"
bash adm_groups.sh
;;

#SALIDA
0) 
write_log "Se salio del menu principal"
COUNTER=10
;;
esac
done
#FIN
