#!/bin/bash
echo "Atualizando Android Studio..."

# Caminho para a pasta do Android Studio (ajuste se necessário)
cd ~/android-studio/bin

# Executa o comando de verificação de atualizações (se disponível)
./studio.sh --check-for-updates

echo "Atualização concluída!"