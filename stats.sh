#!/bin/bash

forma_de_uso(){
	echo -e  "Uso: ./stats.sh -d <directorio datos> [-h] \n -d: directorio donde están los datos a procesar. \n -h: muestra este mensaje y termina."
	exit 1
}
# La variable $# es equiv a argc
if [ $# = 0 ]; then
	forma_de_uso
fi
while getopts "d:h" opcion; do
	case "$opcion" in
		d)
			dataIn=$OPTARG
			;;
		h)
			forma_de_uso
			;;
		*)
			forma_de_uso
			;;
	esac
done
if [ ! -e $dataIn ]; then
	echo "El archivo $2 no existe"
	exit
fi
#Punto 1
executionSummary=(`find $dataIn -name '*.txt' -print | sort | grep executionSummary | grep -v '._'`)
archivo_final="metrics.txt"
temporal="T_simulacion.txt"
temporal2="M_Usada.txt"
rm -f $archivo_final
rm -f $temporal
rm -f $temporal2
for i in ${executionSummary[*]};
do
	tsimTotal=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{suma_tiempo=0}{suma_tiempo=$6+$7+$8} END{print suma_tiempo}')
	printf "$tsimTotal \n" >>$temporal
	op_tsimtotal=$(cat $temporal | awk 'BEGIN{ min=2**63-1; max=0}{if($temporal<min){min=$temporal};\
												if($temporal>max){max=$temporal};\
													total+=$temporal; count+=1;\
													} \
													END{ print total, total/count, min, max }')
	memUsed=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{suma_memoria=0}{suma_memoria=$10;} END{print suma_memoria}')
	printf "$memUsed \n" >>$temporal2
	op_memused=$(cat $temporal2 | awk 'BEGIN{ min=2**63-1; max=0}{if($temporal2<min){min=$temporal2};\
													if($temporal2>max){max=$temporal2};\
														total+=$temporal2; count+=1;\
														} \
														 END{print total, total/count, min, max}')
	done
printf "tsimTotal : promedio : min : max \n memUsed: promedio : min : max \n" >> $archivo_final
printf "%i : %i : %i : %i \n%i : %.2f : %i: %i \n" $op_tsimtotal $op_memused >> $archivo_final
rm -f $temporal $temporal2

