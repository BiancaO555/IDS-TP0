#!/bin/bash

BASE_DIR="$HOME/EPNro1"

if [ "$1" == "-d" ]; then 
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
            mkdir -p "$BASE_DIR/entrada" "$BASE_DIR/salida" "$BASE_DIR/procesado"
            if [[ -f "consolidar.sh" ]]; then
                cp consolidar.sh "$BASE_DIR/"
                chmod +x "$BASE_DIR/consolidar.sh"
            echo "Se creó el entorno."
            fi
            ;;
            
        2)
            if pgrep -f "$BASE_DIR/consolidar.sh" > /dev/null; then
                echo "El proceso de consolidación ya está corriendo."
            else
                nohup "$BASE_DIR/consolidar.sh" > /dev/null 2>&1 &
                echo "Se inició el proceso de consolidación en segundo plano."
            fi
            ;;

        3)
            archivo_salida="$BASE_DIR/salida/${FILENAME}.txt"
            if [[ -f "$archivo_salida" ]]; then
                echo "Alumnos ordenados por padrón: "
                sort -k1,1n "$archivo_salida"
            fi
            
        7)
            echo "Saliendo del menú."
            exit 0
            ;;
        *)
            echo "Opción inválida. Intente nuevamente."
            ;;
    esac
done

    
     


