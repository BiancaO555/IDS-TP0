#!/bin/bash

DIRECTORIO_BASE="$HOME/EPNro1"

if [ "$1" == "-d" ]; then 
    echo "Eliminando entorno y procesos"
    pkill -f consolidar.sh 
    rm -rf "$DIRECTORIO_BASE"/*
    exit 0
fi

if [[ -z "$FILENAME" ]]; then 
    echo "Error: La variable de entorno FILENAME no está definida."
    echo "Ejecute export FILENAME=nombre_archivo"
    exit 1
fi

# MENU

eleccion=0

while [ $eleccion -ne 7 ]; 
do
 echo "MENU..."
 read -p "Seleccione una opción: " eleccion
 
 case $eleccion in
    1) 
       mkdir -p "$DIRECTORIO_BASE/entrada" "$DIRECTORIO_BASE/salida" "$DIRECTORIO_BASE/procesado"
       echo "Se creó el entorno" ;;
    
    2)
       bash "$DIRECTORIO_BASE/consolidar.sh" &
       echo "" ;;
       
 esac
    
     


