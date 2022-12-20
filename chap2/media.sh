#!/bin/bash

make $1.img
if [ = koki] ; then
  echo "koki"
else 
  cp $1.img /media/250372y/boot/kernel7.img
fi
make clean
