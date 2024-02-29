#!/bin/bash

# Argumentos passados para o script
TAP_ON_VALUE=$1
TEMPLATE_FILE="/home/loandre/Downloads/TestFlow/ShellScript/template_test.yaml"
GENERATED_TEST_FILE="/home/loandre/Downloads/TestFlow/ShellScript/teste_temp.yaml"
MAESTRO_OUTPUT_DIR="/home/loandre/.maestro/tests"
SCRIPT_DIR="/home/loandre/Downloads/TestFlow/ShellScript"

# Data e hora atual para identificar os arquivos de teste
CURRENT_DATETIME=$(date "+%Y-%m-%d_%H%M%S")

# Substitui o placeholder no arquivo de template pelo valor fornecido
sed "s/{{tapOnValue}}/$TAP_ON_VALUE/g" $TEMPLATE_FILE > $GENERATED_TEST_FILE

# Executa o teste com o Maestro Studio
maestro test $GENERATED_TEST_FILE

# Identifica o diretório mais recente de saída do teste do Maestro
LATEST_TEST_DIR=$(ls -dt $MAESTRO_OUTPUT_DIR/* | head -1)

# Cria um diretório no SCRIPT_DIR para os arquivos de saída, usando o datetime atual
OUTPUT_DIR="$SCRIPT_DIR/${CURRENT_DATETIME}-maestro-output"
mkdir -p $OUTPUT_DIR

# Verifica se o diretório foi criado corretamente
if [[ -d "$OUTPUT_DIR" && -d "$LATEST_TEST_DIR" ]]; then
    # Move os arquivos de saída para o novo diretório
    mv $LATEST_TEST_DIR/* $OUTPUT_DIR
    echo "Arquivos de teste movidos para $OUTPUT_DIR/"
else
    echo "Erro: Não foi possível criar o diretório de saída ou encontrar o diretório de teste do Maestro."
fi

