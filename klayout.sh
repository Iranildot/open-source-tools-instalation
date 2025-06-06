#!/bin/bash

# klayout_build.sh - Script para compilar e instalar o KLayout no Ubuntu
# Execute com: ./klayout_build.sh

set -e

# Atualiza pacotes e instala dependências
echo "Instalando dependências..."
sudo apt update
sudo apt install -y \
  build-essential \
  qtbase5-dev \
  qttools5-dev \
  qtchooser \
  ruby \
  python3 \
  python3-dev \
  python3-pyqt5 \
  git \
  libz-dev \
  libcurl4-openssl-dev \
  libexpat1-dev

# Cria diretório de trabalho
WORKDIR="$HOME/klayout-build"
mkdir -p "$WORKDIR"
cd "$WORKDIR"

# Clona o repositório KLayout (se ainda não estiver clonado)
if [ ! -d "klayout" ]; then
  echo "Clonando o repositório KLayout..."
  git clone https://github.com/KLayout/klayout.git
fi

cd klayout

# Usa Python 3 e Qt5 padrão
PYTHON_PATH=$(which python3)
QMAKE_PATH=$(which qmake)

# Confirma as versões localizadas
echo "Usando Python: $PYTHON_PATH"
echo "Usando qmake: $QMAKE_PATH"

# Compila o KLayout
echo "Compilando o KLayout..."
./build.sh -python "$PYTHON_PATH" -qmake "$QMAKE_PATH" -j$(nproc)

# Instala o binário (opcional: copia para /usr/local/bin)
echo "Instalando o KLayout..."
sudo cp -v bin-release/klayout /usr/local/bin/

# Adiciona LD_LIBRARY_PATH ao bashrc se não estiver presente
LIB_PATH="$WORKDIR/klayout/build-release"
if ! grep -q "$LIB_PATH" "$HOME/.bashrc"; then
  echo "Adicionando LD_LIBRARY_PATH permanentemente no ~/.bashrc..."
  echo -e "\n# KLayout: adicionando build local ao LD_LIBRARY_PATH" >> "$HOME/.bashrc"
  echo "export LD_LIBRARY_PATH=$LIB_PATH:\$LD_LIBRARY_PATH" >> "$HOME/.bashrc"
fi

# Mensagem final
echo
echo "✅ Instalação concluída com sucesso!"
echo "⚠️  Execute 'source ~/.bashrc' ou abra um novo terminal antes de rodar: klayout"
