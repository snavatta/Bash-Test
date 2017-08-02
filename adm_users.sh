#! /bin/bash
source functions.shinc
COUNTER=0
while [  $COUNTER -lt 10 ]; do  #Cuando counter==10 sale
#MENU
clear
echo "Kreatekno SRL | Versión 05 (15 de octubre)"
echo "GESTIÓN DE USUARIOS"
echo "1. Agregar un usuario"
echo "2. Eliminar un usuario"
echo "3. Cambiar nombre de usuario"
echo "4. Cambiar contraseña"
echo "5. Bloquear/Desbloquear usuario"
echo "6. Cambiar informacion de usuario"
echo "7. Respaldos"
echo "0. Salir"

#LEE ENTRADA
read -p "Ingrese una opción [0-7] " option
case "$option" in

#AGREGAR USUARIO
1)
write_log "Ingreso a la opcion Agregar Usuario"
bash users_add.sh
;;

#ELIMINAR USUARIO
2)
write_log "Ingreso a eliminar usuario"
bash users_delete.sh
;;
#CAMBIAR NOMBRE
3) 
write_log "Ingreso a la opcion cambiar nombre de usuario"
bash users_change_name.sh
;;
#CAMBIAR CONTRASEÑA
4) 
write_log "Ingreso a la opcion cambiar contraseña"
bash users_change_password.sh
;;
#Bloquear desbloquear
5)
write_log "Ingreso al menu Bloquear/Desbloquear"
bash users_block.sh
;;
#CAMBIAR INFORMACION DE USUARIO
6)
write_log "Ingreso al menu Cambiar informacion de usuario"
bash users_personal.sh
;;
#RESPALDOS
7)
write_log "Ingreso al menu de respaldos"
bash backup.sh
;;

#SALIDA
0) 
write_log "Salida de Gestion de usuarios"
COUNTER=10
;;
esac
done
#FIN
