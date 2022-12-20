#!/bin/bash

USERNAME=$(whoami)
        
if [ $USERNAME = "koki" ]; then
  echo "MIZOGUCHI Koki on Mac"
elif [ $USERNAME = "250372y" -o $USERNAME = "250373b" ]; then
	make $1.img
  echo "MIKAMI/MIZOGUCHI on WS-Linux"
  cp $1.img /media/$USERNAME/boot/kernel7.img
elif [ $USERNAME = "root" ]; then
  echo "MIZOGUCHI Koki on Docker-Linux"
fi
make clean
