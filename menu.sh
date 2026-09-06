#!/bin/bash

BASE_DIR="$HOME/EPNro1"
archivo_salida="$BASE_DIR/salida/${FILENAME}.txt"
MENU="=== MENU ===
    1. Crear entorno
    2. Correr consolidación
    3. Listado de alumnos ordenado por padron
    4. Top 10 notas mas altas
    5. Buscar alumno por padron
    6. Ver log
    7. Salir"

# FUNCIONES AUXILIARES
#1
crear_entorno(){ 
    mkdir -p "$BASE_DIR/entrada" "$BASE_DIR/salida" "$BASE_DIR/procesado"
    cp *.txt "$BASE_DIR/entrada/" 

    if [[ -f "consolidar.sh" ]]; then
        cp consolidar.sh "$BASE_DIR/"
        chmod +x "$BASE_DIR/consolidar.sh"
        echo "Se creó el entorno."
    fi
}

#2
consolidar_datos(){
    if pgrep -f "$BASE_DIR/consolidar.sh" > /dev/null; then
        echo "El proceso de consolidación ya está corriendo."
    else
        nohup "$BASE_DIR/consolidar.sh" > /dev/null 2>&1 &
        echo "Se inició el proceso de consolidación en segundo plano."
    fi
}

#3
ordenar_alumnos(){
    if [[ -f "$archivo_salida" ]]; then
        echo "Alumnos ordenados por padrón: "
        sort -n -k1,1 "$archivo_salida"
    else
        echo "El $archivo_salida aún no fue creado, vuelva a seleccionar"    
    fi
}

#4
ranquear_notas(){
    if [[ -f "$archivo_salida" ]]; then
        echo "Las 10 notas más altas:"
        awk '{print $NF, $0}' "$archivo_salida" | sort -nr | cut -d' ' -f2- | head -n 10
    else
        echo "El $archivo_salida aún no fue creado, vuelva a seleccionar"
    fi
}

#5
buscar_datos(){
    read -p "Ingrese un número de padrón: " padron
    if [[ -f "$archivo_salida" ]]; then
        grep "^$padron " "$archivo_salida"
    else
        echo "El $archivo_salida aún no fue creado, vuelva a seleccionar"
    fi    
}
#6
ver_log(){
    archivo_log="$BASE_DIR/procesado.log"
    if [[ -f "$archivo_log" ]]; then
        echo "Contenido del log:"
        cat "$archivo_log"
    else
        echo "El archivo de log no existe."
    fi
}

# PARÁMETRO OPTATIVO
if [ "$1" == "-d" ]; then 
    echo "Eliminando entorno y procesos"
    pkill -f consolidar.sh 
    rm -rf "$BASE_DIR"/*
    exit 0
fi

# VALIDACIÓN
if [[ -z "$FILENAME" ]]; then 
    echo "Error: La variable de entorno FILENAME no está definida."
    echo "Ejecute export FILENAME=nombre_archivo"
    exit 1
fi

# MENU

while true; do
    echo "$MENU"
    read -p "Seleccione una opción: " opcion

    case $opcion in
        1) crear_entorno ;;
            
        2) consolidar_datos ;;
            
        3) ordenar_alumnos ;;
            
        4) ranquear_notas ;;
            
        5) buscar_datos ;;
            
        6) ver_log ;;

        7)
            echo "Saliendo del menú."
            pkill -f "consolidar.sh"
            exit 0
            ;;
        *)
            echo "Opción inválida. Intente nuevamente."
            ;;
    esac
done

    
     


