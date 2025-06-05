#!/bin/bash

# magic_install.sh - Script básico para instalar Magic VLSI Layout Tool (v8.3)

set -e

# Atualizar pacotes e instalar dependências
sudo apt-get update
sudo apt-get install -y \
    m4 \
    python3 \
    libx11-dev \
    tcl-dev \
    tk-dev \
    libcairo2-dev \
    mesa-common-dev \
    libgl-dev \
    libglu1-mesa-dev \
    zlib1g-dev \
    libncurses-dev \
    git \
    build-essential \
    autoconf

# Clonar o repositório do Magic (ou substitua por um tarball se preferir)
git clone https://github.com/RTimothyEdwards/magic.git
cd magic

# Gerar arquivos de configuração se necessário
./configure --with-interpreter=tcl

# Compilar e instalar
make
sudo make install

echo "Magic instalado com sucesso!"
