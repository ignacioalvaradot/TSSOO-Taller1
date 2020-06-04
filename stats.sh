#!/bin/bash

forma_de_uso(){
	echo "Uso: $0 -d <archivo_datos> [h]"
	exit 1
}
# La variable $# es equiv a argc
if [ $# != 1 ]; then
	forma_de_uso
fi
while getopts "d:h" opcion; do
	case "$opcion" in
		f)
			dataIn=$OPTARG
			;;
		h)
			forma_de_uso
			;;
		*)
			forma_uso
			;;
	esac
done
searchDir=$1

