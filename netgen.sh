#!/bin/bash

# Script de instalação do Netgen 1.5 para Ubuntu
# Autor: OpenAI (via ChatGPT)
# Data: 2025-06-06

# Parar o script em caso de erro
set -e

echo "==== Instalando dependências necessárias ===="
sudo apt update
sudo apt install -y \
    git \
    build-essential \
    libx11-dev \
    libxrender-dev \
    libxext-dev \
    libxt-dev \
    tcl-dev \
    tk-dev \
    libglu1-mesa-dev \
    freeglut3-dev \
    libglib2.0-dev \
    libncurses-dev \
    autoconf \
    automake \
    libtool \
    pkg-config

echo "==== Clonando repositório do Netgen ===="
git clone https://github.com/RTimothyEdwards/netgen.git
cd netgen

echo "==== Configurando o Netgen ===="
./configure

echo "==== Compilando o Netgen ===="
make -j"$(nproc)"

echo "==== Instalando o Netgen ===="
sudo make install
