#!/bin/bash

# Script de instalação do ngspice a partir do Git
# Compatível com sistemas baseados em Ubuntu
# Baseado no Capítulo 28.1.2 do manual ngspice 44

set -e

INSTALL_DIR="$HOME/ngspice-build"
REPO_URL="https://git.code.sf.net/p/ngspice/ngspice"

echo ">>> Atualizando lista de pacotes..."
sudo apt update

echo ">>> Instalando dependências..."
sudo apt install -y \
  git \
  build-essential \
  autoconf \
  automake \
  libtool \
  bison \
  flex \
  libx11-dev \
  libreadline-dev \
  libfftw3-dev \
  libxaw7-dev \
  xorg-dev \
  gawk

echo ">>> Criando diretório de compilação: $INSTALL_DIR"
mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR"

echo ">>> Clonando repositório do ngspice"
git clone "$REPO_URL"
cd ngspice

echo ">>> Rodando autogen.sh"
./autogen.sh

echo ">>> Configurando build (com suporte X11 e 64 bits)"
./configure --with-x CFLAGS="-m64 -O2" LDFLAGS="-m64 -s"

echo ">>> Limpando builds anteriores (se houver)"
make clean

echo ">>> Compilando ngspice"
make -j"$(nproc)"

echo ">>> Instalando ngspice (requer sudo)"
sudo make install

echo ">>> Ngspice instalado com sucesso!"
