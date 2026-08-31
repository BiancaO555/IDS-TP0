#!/bin/bash

BASE_DIR="$HOME/EPNro1"

while true; do

	for file in "$BASE_DIR/entrada"/*.txt; do
		if [[  -f "$file"  ]]; then
			nombre_base=$(basename "$file")
			cat "$file" >> "$BASE_DIR/salida/${FILENAME}.txt"
			mv "$file" "$BASE_DIR/procesado/"
			fecha=$(date +"%d/%m/%Y %H:%M:%S")
			echo "$fecha - Procesado Archivo $nombre_base" >> "$BASE_DIR/procesado.log"
		fi
	done

	sleep 3
done
