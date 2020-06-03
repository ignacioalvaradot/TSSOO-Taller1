#!/bin/bash

# La variable $# es equiv a argc
if [ $# != 1 ]; then
        echo "Uso: $0 <directorio busqueda>"
        exit
fi

searchDir=$1

