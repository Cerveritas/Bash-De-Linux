#!/bin/bash

opcion=$1

#####################################################################################################
#########################  PARTE 1 y 9 --> CREACION DE USUARIOS  ####################################
#####################################################################################################

if [ $opcion = "-create" ] # --> Crear usuario y contraseña
then
	sudo useradd -m -s /bin/bash $2
	(echo $3; echo $3) | sudo passwd $2
	sudo touch /var/spool/mail/$2
	sudo chown $2:mail /var/spool/mail/$2
	sudo chmod 600 /var/spool/mail/$2
	if [[ $# -gt 3 ]]
	then
		usuario=$2
		while [ "$*" ]
		do
			let CONTADOR=$CONTADOR+1
			if [[ $CONTADOR -gt 3 ]]
			then
				sudo adduser $usuario $1
			fi
			shift
		done
	fi



#####################################################################################################
#########################  PARTE 2 --> AÑADIR USUARIOS A GRUPOS  ####################################
#####################################################################################################

elif [ $opcion = "-add" ] # --> Añadir usuario a un grupo
then
	sudo adduser $2 $3



#####################################################################################################
#####################  PARTE 3 --> ELIMINACION DE USUARIOS DE GRUPOS  ###############################
#####################################################################################################
	
elif [ $opcion = "-extract" ] # --> Eliminar usuario de un grupo
then
	sudo deluser $2 $3



#####################################################################################################
##########################  PARTE 4 --> ELIMINACION DE USUARIOS  ####################################
#####################################################################################################

elif [ $opcion = "-delete" ] # --> Eliminar usuario
then
	sudo userdel $2



#####################################################################################################
#########################  PARTE 5 --> ELIMINACION DE USUARIOS + CARPETA  ###########################
#####################################################################################################

elif [ $opcion = "-remove" ] # --> Eliminar usuario y su carpeta asociada
then
	sudo userdel -r $2



#####################################################################################################
############################  PARTE 6 --> CAMBIAR CONTRASEÑA  #######################################
#####################################################################################################
	
elif [ $opcion = "-password" ] # --> Cambiar la contraseña 
then
	(echo $3 ; echo $3) | sudo passwd $2


#####################################################################################################
############################  PARTE 7 --> BLOQUEO DE USUARIO  #######################################
#####################################################################################################

elif [ $opcion = "-lock" ] # --> Bloquea un usuario
then
	sudo usermod -L $2



#####################################################################################################
##########################  PARTE 8 --> DESBLOQUEO DE USUARIOS  #####################################
#####################################################################################################

elif [ $opcion = "-unlock" ] # --> Desbloquea un usuario
then
	sudo passwd -u $2



#####################################################################################################
############  PARTE 10 --> CREACION DE USUARIOS Y AÑADIR A GRUPOS DE OTRO USUARIO  ##################
#####################################################################################################

elif [ $opcion = "-copy" ] # --> Crear usuario, y meterlo en un grupo o varios por parametria
then
	
	if [ $# -lt 2 ];
       	then
  		echo "Uso: $0 usuarioExistente usuarioNuevo" >&2
 		 exit 1
	fi

	usuario_existente="$2"
	grupos_existentes=$(id -Gn "$usuario_existente" | tr ' ' ',')


	nuevo_usuario="$3"
	sudo useradd -m -G "$grupos_existentes" "$nuevo_usuario"

	echo "El usuario $nuevo_usuario ha sido creado con éxito y añadido a los mismos grupos que $usuario_existente."





#	sudo useradd -m -p "$(openssl passwd -1 "$4")" "$3"
#	existing_user_groups=$(id -nG "$2")
#	for group in $2; 
#	do
 #  	 sudo usermod -a -G "$2" "$3"
#	done

#	echo "El usuario ha sido creado y pertenece al/os grupo/os seleccionados"



#####################################################################################################
###############################  PARTE 12 --> INSTALACION  ##########################################
#####################################################################################################
	
elif [ $opcion = "-install" ] # --> Hacer instalacion para ejecutar comandos sin ' ./ '
then
#	sudo cp usermngCerveraJimenezSergio.sh /usr/local/bin/usermngCerveraJimenezSergio
#    	chmod +x /usr/local/bin/usermngCerveraJimenezSergio
#	echo "usermng instalado correctamente"

#	exit 0	

	path=$(readlink -f $0)
        if ! grep -Fxq "alias usermng_CerveraJimenezSergio='$path'" ~/.bashrc ; then
		echo "alias usermng_CerveraJimenezSergio='$path'" >> ~/.bashrc
		source ~/.bashrc
	else
		echo 'El script ya está instalado. Puede emplearlo sin hacer uso de la llamada al fichero'        
	fi 
	

	

#####################################################################################################
##############################  PARTE 11 --> MOSRTRAR MENU  #########################################
#####################################################################################################

elif [ $opcion = "-man" ]
then
	echo "BIENVENIDO A EL SCRIPT PARA LA FACILITACION DE LA GESTION DE USUARIOS

	Con el uso de este script puedes realizar varias funciones relacionadas con
        usuario/grupo y vamos a facilitarte el funcionamiento con los siguientes
        comandos y su respectivo significado:

        1. - CREAR UN USUARIO --> usermng -create [nombre] [password]

        2. - AÑADIR UN USUARIO --> usermng -add [user] [group]

        3. - ELIMINAR UN USUARIO DE UN GRUPO --> usermng -extract [user] [group]

        4. - ELIMINAR UN USUARIO --> usermng -delete [nombre]

        5. - ELIMINAR UN USUARIO CON SU CARPETA ASOCIADA --> usermng -remove [nombre]

        6. - CAMBIAR CONTRASEÑA --> usermng -password [nombre] [password]

        7. - BLOQUEAR USUARIO --> usermng -lock [nombre]

        8. - DESBLOQUEAR USUARIO --> usermmg -unlock [nombre]

        9. - CREAR USUARIO Y AÑADIRLO A GRUPOS --> usermng -create [nombre] [password] [grupo1] [grupo2] [grupo3] [grupo4] ....
	
	10. - CREAR USUARIO Y METERLE EN LOS MISMOS GRUPOS QUE UNO YA EXISTENTE --> usermng -copy [usuarioExistente] [nombre] [password] ... 

	11. - CREAR MENU --> usermng -man

	12. - INSTALACION PARA SCRIPT --> usermng.sh -install"

fi
