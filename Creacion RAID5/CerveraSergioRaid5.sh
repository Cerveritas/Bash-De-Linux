#!/bin/bash
echo
echo
echo


echo '     *******************************************************************'
echo '                           _               _       _         _     '
echo '        ___ ___ _ ____   _(_)___  ___ _ __(_)_ __ | |_   ___| |__  '
echo '       / __/ _ \ `__\ \ / / / __|/ __| `__| | `_ \| __| / __| `_ \ '
echo '      | (_|  __/ |   \ V /| \__ \ (__| |  | | |_) | |_ _\__ \ | | |'
echo '       \___\___|_|    \_/ |_|___/\___|_|  |_| .__/ \__(_)___/_| |_|'
echo '                                            |_|                   '
echo '     *******************************************************************'

read -p "	Bienvenido SR.Profesor a la creacion de un RAID-5 con el uso de 3
	discos duros.
	Para esto hemos creado un script capaz de realizar todos los pasos
	automaticamente, lo que una persona tarda en hacer dias yo te lo hago
	para que tardes segundos.

	CERVISCRIPT, tus scripts de confianza.

         	   ********************************
		   **  PULSE ENTER PARA EMPEZAR  **
		   ********************************
		
		"

#******************************************************************************
	



#******************************************************************************
	#Instalacion de herramienta de administracion de RAID

sudo apt install mdadm rsync initramfs-tools -y

#******************************************************************************
	#Particiones de los dicos pasados por agumento

(echo n; echo p; echo 1; echo; echo; echo t; echo FD; echo p; echo w) | fdisk /$1
(echo n; echo p; echo 1; echo; echo; echo t; echo FD; echo p; echo w) | fdisk /$2
(echo n; echo p; echo 1; echo; echo; echo t; echo FD; echo p; echo w) | fdisk /$3

#******************************************************************************		#Creacion de nuevo volumen de RAID 5

var=1
sudo mdadm -C /dev/md0 -l raid5 -n 3 $1$var $2$var $3$var

#******************************************************************************		#Formateo de RAID y darle formato (ext4)	

sudo mkfs.ext4 /dev/md0

#******************************************************************************
	 #Paso final de reinicio para un correcto funcionamiento


read -p 'Para un mejor funcionamiento del script es aconsejable reiniciar
	
		*Pulse 1 para reiniciar*
		*Pulse cualquier otra para cancelar*
		' reiniciar

if [ $reiniciar == 1 ]
then
	sudo reboot
fi
clear
echo ****REINICIO CANCELADO, RAID5 CREADO CORRECTAMENTE****

