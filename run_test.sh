#!/bin/bash

# Argumentos passados para o script
TAP_ON_VALUE=$1
TEMPLATE_FILE="/home/loandre/Downloads/TestFlow/ShellScript/template_test.yaml"
GENERATED_TEST_FILE="/home/loandre/Downloads/TestFlow/ShellScript/teste_temp.yaml"

# Substitui o placeholder no arquivo de template pelo valor fornecido
sed "s/{{tapOnValue}}/$TAP_ON_VALUE/g" $TEMPLATE_FILE > $GENERATED_TEST_FILE

# Executa o teste com o Maestro Studio
maestro test $GENERATED_TEST_FILE

