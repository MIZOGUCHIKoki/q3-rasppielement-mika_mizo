#!/bin/bash

USERNAME=$(whoami)
        
if [ $USERNAME = "koki" ]; then
	echo -e "\e[31m MIZOGUCHI on Mac \e[m"
elif [ $USERNAME = "250372y" -o $USERNAME = "250373b" ]; then
	make $1.img
	echo -e "\e[31m MIKAMI/MIZOGUCHI on WS-Linux \e[m"
  cp $1.img /media/$USERNAME/boot/kernel7.img
elif [ $USERNAME = "root" ]; then
	echo -e "\e[31m MIZOGUCHI on Docker-Linux \e[m"
fi
make clean
