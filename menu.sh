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

while true; do
    echo "MENU"
    echo "1. Crear entorno"
    echo "2. Correr consolidación"
    echo "3. Listado de alumnos ordenado por padron"
    echo "4. Top 10 notas mas altas"
    echo "5. Buscar alumno por padron"
    echo "6. Ver log"
    echo "7. Salir"
    read -p "Seleccione una opción: " opcion

    case $opcion in
        1)
            mkdir -p "$DIRECTORIO_BASE/entrada" "$DIRECTORIO_BASE/salida" "$DIRECTORIO_BASE/procesado"
            echo "Se creó el entorno."
            ;;
        2)
            bash "$DIRECTORIO_BASE/consolidar.sh" &
            echo "Consolidación iniciada en segundo plano."
            ;;
        3)
            echo "Saliendo del menú."
            exit 0
            ;;
        *)
            echo "Opción inválida. Intente nuevamente."
            ;;
    esac
done

    
     


