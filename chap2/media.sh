#!/bin/bash

make $1.img
cp $1.img /media/250372y/boot/kernel7.img
make clean
