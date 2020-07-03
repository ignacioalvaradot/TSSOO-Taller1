#!/bin/bash

forma_de_uso(){
	echo -e  "Uso: ./stats.sh -d <directorio datos> [-h] \n -d: directorio donde están los datos a procesar. \n -h: muestra este mensaje y termina."
	exit 1
}

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
	echo "La ruta  $2 no existe"
	exit
fi
#Tarea 1
Tarea1(){
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
	memUsed=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{suma_memoria=0}{suma_memoria=$9;} END{print suma_memoria}')
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
}
#Tarea2
Tarea2(){
Summary=(`find $dataIn -name '*.txt' -print | sort | grep summary | grep -v '._'`)
archivo_final2="evacuation.txt"
temporal3="all.txt"
temporal4="T_residents.txt"
temporal5="T_visitorsi.txt"
temporal6="T_residentsg0.txt"
temporal7="T_residentsg1.txt"
temporal8="T_residentsg2.txt"
temporal9="T_residentsg3.txt"
temporal10="T_visitorsg0.txt"
temporal11="T_visitorsg1.txt"
temporal12="T_visitorsg2.txt"
temporal13="T_visitorsg3.txt"
rm -f $archivo_final2
rm -f $temporal3
rm -f $temporal4
for i in ${Summary[*]};
do
        p_simuladas=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{suma_personas=0}{suma_personas+=$8} END{print suma_personas}')
        printf "$p_simuladas \n" >>$temporal3
        op_psimuladas=$(cat $temporal3 | awk 'BEGIN{ min=2**63-1; max=0}{if($temporal3<min){min=$temporal3};\
                                                                                                if($temporal3>max){max=$temporal3};\
                                                                                                        total+=$temporal3; count+=1;\
                                                                                                        } \
                                                                                                        END{ print total, total/count, min, max }')
        t_residentes=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{suma_resident=0}{if($3==0)suma_resident+=$8} END{print suma_resident}')
        printf "$t_residentes \n" >>$temporal4
        op_tresidentes=$(cat $temporal4 | awk 'BEGIN{ min=2**63-1; max=0}{if($temporal4<min){min=$temporal4};\
                                                                                                if($temporal4>max){max=$temporal4};\
                                                                                                        total+=$temporal4; count+=1;\
                                                                                                        } \
                                                                                                        END{ print total, total/count, min, max }')
        t_visitorsI=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{suma_visitors=0}{if($3==1)suma_visitors+=$8} END{print suma_visitors}')
        printf "$t_visitorsI \n" >>$temporal5
        op_tvisitorsI=$(cat $temporal5 | awk 'BEGIN{ min=2**63-1; max=0}{if($temporal5<min){min=$temporal5};\
                                                                                                if($temporal5>max){max=$temporal5};\
                                                                                                        total+=$temporal5; count+=1;\
                                                                                                        } \
                                                                                                        END{ print total, total/count, min, max }')
        t_residentg0=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{suma_residentg0=0}{if($3==0 && $4==0)suma_residentg0+=$8} END{print suma_residentg0}')
        printf "$t_residentg0 \n" >>$temporal6
        op_tresidentg0=$(cat $temporal6 | awk 'BEGIN{ min=2**63-1; max=0}{if($temporal6<min){min=$temporal6};\
                                                                                                if($temporal6>max){max=$temporal6};\
                                                                                                        total+=$temporal6; count+=1;\
                                                                                                        } \
                                                                                                        END{ print total, total/count, min, max }')
        t_residentg1=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{suma_residentg1=0}{if($3==0 && $4==1)suma_residentg1+=$8} END{print suma_residentg1}')
        printf "$t_residentg1 \n" >>$temporal7
        op_tresidentg1=$(cat $temporal7 | awk 'BEGIN{ min=2**63-1; max=0}{if($temporal7<min){min=$temporal7};\
                                                                                                if($temporal7>max){max=$temporal7};\
                                                                                                        total+=$temporal7; count+=1;\
                                                                                                        } \
                                                                                                        END{ print total, total/count, min, max }')
        t_residentg2=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{suma_residentg2=0}{if($3==0 && $4==2)suma_residentg2+=$8} END{print suma_residentg2}')
        printf "$t_residentg2 \n" >>$temporal8
        op_tresidentg2=$(cat $temporal8 | awk 'BEGIN{ min=2**63-1; max=0}{if($temporal8<min){min=$temporal8};\
                                                                                                if($temporal8>max){max=$temporal8};\
                                                                                                        total+=$temporal8; count+=1;\
                                                                                                        } \
                                                                                                        END{ print total, total/count, min, max }')
        t_residentg3=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{suma_residentg3=0}{if($3==0 && $4==3)suma_residentg3+=$8} END{print suma_residentg3}')
        printf "$t_residentg3 \n" >>$temporal9
        op_tresidentg3=$(cat $temporal9 | awk 'BEGIN{ min=2**63-1; max=0}{if($temporal9<min){min=$temporal9};\
                                                                                                if($temporal9>max){max=$temporal9};\
                                                                                                        total+=$temporal9; count+=1;\
                                                                                                        } \
                                                                                                        END{ print total, total/count, min, max }')
        t_visitorsg0=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{suma_visitorsg0=0}{if($3==1 && $4==0)suma_visitorsg0+=$8} END{print suma_visitorsg0}')
        printf "$t_visitorsg0 \n" >>$temporal10
        op_tvisitorsg0=$(cat $temporal10 | awk 'BEGIN{ min=2**63-1; max=0}{if($temporal10<min){min=$temporal10};\
                                                                                                if($temporal10>max){max=$temporal10};\
                                                                                                        total+=$temporal10; count+=1;\
                                                                                                        } \
                                                                                                        END{ print total, total/count, min, max }')
        t_visitorsg1=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{suma_visitorsg1=0}{if($3==1 && $4==1)suma_visitorsg1+=$8} END{print suma_visitorsg1}')
        printf "$t_visitorsg1 \n" >>$temporal11
        op_tvisitorsg1=$(cat $temporal11 | awk 'BEGIN{ min=2**63-1; max=0}{if($temporal11<min){min=$temporal11};\
                                                                                                if($temporal11>max){max=$temporal11};\
                                                                                                        total+=$temporal11; count+=1;\
                                                                                                        } \
                                                                                                        END{ print total, total/count, min, max }')
        t_visitorsg2=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{suma_visitorsg2=0}{if($3==1 && $4==2)suma_visitorsg2+=$8} END{print suma_visitorsg2}')
        printf "$t_visitorsg2 \n" >>$temporal12
        op_tvisitorsg2=$(cat $temporal12 | awk 'BEGIN{ min=2**63-1; max=0}{if($temporal12<min){min=$temporal12};\
                                                                                                if($temporal12>max){max=$temporal12};\
                                                                                                        total+=$temporal12; count+=1;\
                                                                                                        } \
                                                                                                        END{ print total, total/count, min, max }')
        t_visitorsg3=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{suma_visitorsg3=0}{if($3==1 && $4==3)suma_visitorsg3+=$8} END{print suma_visitorsg3}')
        printf "$t_visitorsg3 \n" >>$temporal13
        op_tvisitorsg3=$(cat $temporal13 | awk 'BEGIN{ min=2**63-1; max=0}{if($temporal13<min){min=$temporal13};\
                                                                                                if($temporal13>max){max=$temporal13};\
                                                                                                        total+=$temporal13; count+=1;\
                                                                                                        } \
                                                                                                        END{ print total, total/count, min, max }')
done
printf "alls : promedio : min : max\n residents : promedio : min : max\n visitorsI : promedio : min : max\n" >> $archivo_final2
printf "residents-G0 : promedio : min : max\n residents-G1 : promedio : min : max\n residents-G2 : promedio : min : max\n residents-G3 : promedio : min : max \n " >> $archivo_final2
printf "visitorsI-G0 : promedio : min : max\n visitorsI-G1 : promedio : min : max\n visitorsI-G2 : promedio : min : max\n visitorsI-G3 : promedio : min : max \n " >> $archivo_final2
printf "%i : %.2f : %i : %i\n %i : %.2f : %i : %i\n %i : %.2f : %i : %i \n" $op_psimuladas $op_tresidentes $op_tvisitorsI >> $archivo_final2
printf "%i : %.2f : %i : %i\n %i : %.2f : %i : %i\n %i : %.2f : %i : %i \n %i : %.2f : %i : %i\n" $op_tresidentg0 $op_tresidentg1 $op_tresidentg2 $op_tresidentg3 >> $archivo_final2
printf "%i : %.2f : %i : %i\n %i : %.2f : %i : %i\n %i : %.2f : %i : %i \n %i : %.2f : %i : %i\n" $op_tvisitorsg0 $op_tvisitorsg1 $op_tvisitorsg2 $op_tvisitorsg3 >> $archivo_final2
rm -f $temporal3
rm -f $temporal4
rm -f $temporal5
rm -f $temporal6
rm -f $temporal7
rm -f $temporal8
rm -f $temporal9
rm -f $temporal10
rm -f $temporal11
rm -f $temporal12
rm -f $temporal13
}
#Tarea 3
Tarea3(){
usePhoneFiles=(`find $dataIn -name '*.txt' -print | sort | grep usePhone | grep -v '._'`)
archivo_final3="usePhone-stats.txt"
temporal14="phone.txt"
for i in ${usePhoneFiles[*]};
	do
		tiempos=(`cat $i | tail -n+3 | cut -d ':' -f 3`)
		for i in ${tiempos[*]};
		do
			printf "%d:" $i >> $temporal14
		done
		printf "\n" >> $temporal14
	done

	totalFields=$(head -1 $temporal14 | sed 's/.$//' | tr ':' '\n'| wc -l)
	printf "#timestamp:promedio:min:max\n" >> $archivo_final3
	for i in $(seq 1 $totalFields); do
		out=$(cat $temporal14 | cut -d ':' -f $i |\
			awk 'BEGIN{ min=2**63-1; max=0}\
				{if($1<min){min=$1};if($1>max){max=$1};total+=$1; count+=1;}\
				END {print total/count":"max":"min}')
		printf "$i:$out\n" >> $archivo_final3
	done

rm -f $temporal14
}
if [  -d $dataIn ]; then
        Tarea1
	Tarea2
	Tarea3
fi
