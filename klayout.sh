#!/bin/bash

set -e

# Informações do pacote
KLAYOUT_VERSION="0.30.2-1"
KLAYOUT_DEB="klayout_${KLAYOUT_VERSION}_amd64.deb"
KLAYOUT_URL="https://www.klayout.org/downloads/Ubuntu-24/${KLAYOUT_DEB}"

# Atualiza lista de pacotes e instala dependências
echo "Atualizando pacotes e instalando dependências..."
sudo apt update
sudo apt install -y wget libqt5widgets5 libqt5gui5 libqt5core5a libqt5xml5 libqt5svg5 libqt5multimedia5 libqt5multimediawidgets5

# Faz o download do pacote .deb
echo "Baixando KLayout ${KLAYOUT_VERSION}..."
wget -c "${KLAYOUT_URL}"

# Instala o pacote .deb
echo "Instalando KLayout..."
sudo dpkg -i "${KLAYOUT_DEB}"

# Corrige dependências faltantes, se necessário
echo "Verificando e corrigindo dependências..."
sudo apt -f install -y

echo "KLayout ${KLAYOUT_VERSION} instalado com sucesso!"
