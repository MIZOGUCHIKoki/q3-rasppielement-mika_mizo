#!/bin/bash

USERNAME = $(whoami)
if [ $USERNAME = koki] ; then
  echo "koki"
else 
	make $1.img
  cp $1.img /media/250372y/boot/kernel7.img
fi
make clean
