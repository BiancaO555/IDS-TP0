#!/bin/bash

BASE_DIR="$HOME/EPNro1"

if [[ "$1" == "-d" ]]; then 
    echo "Eliminando entorno y procesos"
    pkill -f consolidar.sh 
    rm -rf "$BASE_DIR"/*
    exit 0
fi

if [[ -z "$FILENAME" ]]; then 
    echo "Error: La variable de entorno FILENAME no está definida."
    echo "Ejecute export FILENAME=nombre_archivo"
    exit 1
fi


