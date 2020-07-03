# TSSOO-taller1

##### Autor: Ignacio Alvarado Torreblanca - Correo: ignacio.alvarado@alumnos.uv.cl

## 1. Diseño de Solución

En este problema se dividen los procesos del script en tareas, cada tarea hace una lectura de cada archivo descrito anteriormente: executionSummary.txt, summary.txt y usePhone.txt. Y estas cumplen con distintos requerimientos que permiten la lectura de archivo y el procesamiento de los datos necesarios para realizar las estadisticas descriptivas. El codigo de cada tarea en este script es similar, por lo que varian en el archivo que leen y los datos de estos.

Para poder tener un desarrollo correcto del problema, se tienen que tener en cuenta los requerimientos que se necesitan, para este problema tenemos: Pasar por parametro el directorio donde se encuentran los archivos a analizar, verificar que exista el directorio, acceder a los archivos de la simulacion, toma de los datos requeridos en el problema, estadisticas descriptivas de estos datos (Minimo, maximo y promedio), almacenar las estadísticas con la estructura de cada archivo correspondientemente.
![Ialvarado](http://imgfz.com/i/cOP6VAv.png)

Al ejecutar el script,  tienen que existir parametros de entrada, los cuales seran: “-d ” para ejecutar el script con el directorio correspondiente y “-h” para mostrar la forma de uso del script. Al tener el problema dividido en tres tareas, cada una de estas funciona de una forma similar, toma los archivos correspondientes, los lee, procesa los datos, calcula las estadísticas descriptivas y almacena los resultados dentro de los archivos correspondientes por tarea : metric.txt, evacuation.txt y usePhone-stats.txt. Tambien se considerara utilizar archivos temporales para una mayor organización de los datos de cada tarea, ya que necesitamos tener un orden y claridad de estos para el calculo de las estadisticas descriptivas, una vez utilizados estos archivos temporales para almacenar los datos en el archivo final de cada tarea, seran removidos ya que no contendran datos relevantes.

## 2. Estructura del Código

### 2.1 Parametros del script
Al usar el script desarrollado en bash, tenemos que pasar por parámetro la ruta del directorio que contienen los archivos de la simulación o también se puede ver la forma de uso del script, esto se hace pasando por parámetro "-d" o "-h", si usamos el primero tendremos que poner luego de este el directorio ya nombrado, si ponemos lo segundo se nos mostrara la forma de uso del script. Si la ruta especificada no existe mostrara un mensaje por pantalla para advertir que la ruta era incorrecta. También si no hay parámetros de entrada al ejecutar el script, este mostrara la forma de uso. 


### 2.2 Tarea 1.

Al verificar que la ruta del directorio existe, se instancio en cada tarea, cual es el archivo buscado para cada una de estas. Para buscarlos se usa el comando `find` dentro de los archivos del directorio ingresado por parametro, en este caso,  de "executionSummary.txt", se le asigna la ruta donde se encuentran los archivos a una variable, para recorrer el contenido de esa variable y con eso sacar los datos necesario de los archivos. Esto se hace con el siguiente comando:

```
executionSummary=(`find $dataIn -name '*.txt' -print | sort | grep executionSummary | grep -v '._'`)`
```

Para el calculo del tiempo de simulación total y la memoria utilizada por el simulador, recorremos el arreglo  `executionSummary[*]` el que contiene los archivos que se necesitan con los datos correspondientes , para luego asignar correspondientemente los valores de suma del tiempo a la variable `tsimTotal` y memoria total utilizada a `memUsed`, donde posteriormente se almacenan dentro de los archivos temporales `temporal` y `temporal2`. El primer archivo temporal sera utilizado por el siguiente comando:

```
op_tsimtotal=$(cat  $temporal  |  awk 'BEGIN{ min=2**63-1; max=0}{if($temporal<min){min=$temporal};\
if($temporal>max){max=**$temporal};\
total+=**$temporal**; count+=1;\
}  \
END{ print total, total/count, min, max }')
```

y el segundo (`temporal2`) sera utilizado por el siguiente:

```
op_memused=$(cat  $temporal2  |  awk 'BEGIN{ min=2**63-1; max=0}{if($temporal2<min){min=$temporal2};\
if($temporal2>max){max=$temporal2};\
total+=$temporal2; count+=1;\
}  \
END{print total, total/count, min, max}')
```
Luego de la ejecución de esta tarea, se tiene como salida el archivo metrics.txt, el cual contiene los resultados almacenados en los archivos temporales, luego se eliminan los archivos temporales ya que no contienen datos que sirvan.

Cabe explicar que el comando `cat` es usado para concatenar el contenido del archivo temporal, para que con el comando `awk`  se puedan procesar los comandos del calculo estadistico de los datos.
### 2.3 Tarea 2.

Al igual que en la tarea anterior, se deberá encontrar el archivo summary.txt de cada simulación que están en la ruta ya almacenada en dataIn, para almacenar estos datos en nuevos archivos temporales. 

En este caso, solo se ejemplificara el primer proceso, que corresponde al calculo del total de personas simuladas, los datos de estos seran almacenados en el `temporal3`:

```
p_simuladas=$(cat  $i  | tail -n+2 |  awk -F ':'  'BEGIN{suma_personas=0}{suma_personas+=$8} END{print suma_personas}')
printf  "$p_simuladas \n"  >>$temporal3
op_psimuladas=$(cat  $temporal3  |  awk 'BEGIN{ min=2**63-1; max=0}{if($temporal3<min){min=$temporal3};\
if($temporal3>max){max=$temporal3};\
total+=$temporal3; count+=1;\
}  \
END{ print total, total/count, min, max }')
```

Con esto se calcula, el promedio , el maximo  y el minimo de todas las personas simuladas, para luego almacenarlo en el archivo  "`evacuation.txt`". Luego esto se realiza para todos los demás procesos de la tarea 2, solo cambian los datos filtrados por el comando `cut`  por cada tipo de persona incluyendo el grupo etario.
 
 El comando `tail` se tomará todo el contenido por debajo de la primera linea de los archivos de lectura, y, `cut`, se encargará de tomar el ítem ubicado en la posición señalada, en este caso el octavo item de cada columna con los ítems separados por ":".
