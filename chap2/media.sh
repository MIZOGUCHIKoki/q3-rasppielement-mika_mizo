#!/bin/bash

USERNAME=$(whoami)
#if [$USERNAME="koki"];
#then
#  echo "koki"
#else 
#	make $1.img
#fi
        
if [ $USERNAME = "koki" ]; then
  echo "MIZOGUCHI Koki on Mac"
elif [ $USERNAME = "250372y" ]; then
  echo "MIKAMI/MIZOGUCHI on WS-Linux"
  cp $1.img /media/$USERNAME/boot/kernel7.img
elif [ $USERNAME = "root" ]; then
  echo "MIZOGUCHI Koki on Docker-Linux"
fi
#make clean
