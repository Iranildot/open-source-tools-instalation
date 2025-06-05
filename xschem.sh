#!/bin/bash

git clone https://github.com/StefanSchippers/xschem.git xschem-src

cd xschem-src; ./configure

sudo apt install -y libx11-6 libx11-dev libxrender1 libxrender-dev libxcb1 libx11-xcb-dev libcairo2 libcairo2-dev tcl8.6 tcl8.6-dev  tk8.6 tk8.6-dev flex bison libxpm4 libxpm-dev libjpeg-dev

sudo make install