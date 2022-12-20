#!/bin/bash

USERNAME=$(whoami)
        
if [ $USERNAME = "250373b" ]; then
	echo -e "\e[31m MIZOGUCHI on WS-Linux \e[m"
	make $1.img
  cp $1.img ~/tsclient/boot/kernel7.img
	
elif [ $USERNAME = "250372y" ]; then
	echo -e "\e[31m MIKAMI on WS-Linux \e[m"
	make $1.img
  cp $1.img /media/$USERNAME/boot/kernel7.img
elif [ $USERNAME = "root" ]; then
	echo -e "\e[31m MIZOGUCHI on Docker-Linux \e[m"
fi
make clean
