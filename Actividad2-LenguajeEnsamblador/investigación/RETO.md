## RETO 1
Escribe un programa en lenguaje ensamblador que sume los primeros 100 números naturales.
    
    ```cpp
    int i = 1;
    int sum = 0;
    While (i <= 100){
       sum += i;
       i++;
    }
    ```
    
###  - ¿Cómo están implementadas las variables `i` y `sum`?
Se implementan como registros o espacios en memoria donde se guarda su valor.
    
### - ¿En qué direcciones de memoria están estas variables?
Pueden estar en la pila (stack) o en la sección de datos, con direcciones asignadas por el compilador o el programador (si se usa ensamblador puro).

###  - ¿Cómo está implementado el ciclo `while`?
El while se convierte en una etiqueta con una comparación (cmp) y un salto condicional (jle, jne, etc.) que repite el bloque mientras se cumple la condición.

###  - ¿Cómo se implementa la variable `i`?
Puede estar en un registro o en una posición de memoria. Se incrementa con instrucciones como inc i o add i, 1.

###    - ¿En qué parte de la memoria se almacena la variable `i`?


###    - Después de todo lo que has hecho, ¿Qué es entonces una variable?

###    - ¿Qué es la dirección de una variable?

###    - ¿Qué es el contenido de una variable?

## RETO 2
Transforma el programa en alto nivel anterior para que utilice un ciclo `for` en vez de un ciclo `while`.
## RETO 3
Escribe un programa en lenguaje ensamblador que implemente el programa anterior.
## RETO 4
Ahora vamos a acercarnos al concepto de puntero. Un puntero es una variable que almacena la dirección de memoria de otra variable. Observa el siguiente programa escrito en C++:
````
int var = 10;
int *punt;
punt = &var;
*punt = 20;
````
​
El programa anterior modifica el contenido de la variable var por medio de la variable punt. punt es un puntero porque almacena la dirección de memoria de la variable var . En este caso el valor de la variable var  será 20 luego de ejecutar *punt = 20;. Ahora analiza:
¿Cómo se declara un puntero en C++? int *punt;. punt es una variable que almacenará la dirección de un variable que almacena enteros.
¿Cómo se define un puntero en C++? punt = &var;. Definir el puntero es inicializar el valor del puntero, es decir, guardar la dirección de una variable. En este caso punt contendrá la dirección de var .
¿Cómo se almacena en C++ la dirección de memoria de una variable? Con el operador &. punt = &var;
¿Cómo se escribe el contenido de la variable a la que apunta un puntero? Con el operador . punt = 20;. En este caso como punt contiene la dirección de var  entonces punt a la izquierda del igual indica que quieres actualizar el valor de la variable var .

## RET0 5
### Traduce este programa a lenguaje ensamblador

````
int var = 10;
int *punt;
punt = &var;
*punt = 20;
````
````
@10
D=A                  //var=10
@VAR
M=D

@VAR
D=A                 //*punt=&var
@PUNT
M=D

@20
D=A                  // D = 20
@PUNT
A=M                  // A = *punt
M=D                  // *punt = 20

