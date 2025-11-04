### 16. Implementa en lenguaje ensamblador el siguiente programa:
    
    ```cpp
    int[] arr = new int[10];
    int sum = 0;
    for (int j = 0; j < 10; j++) {
        sum = sum + arr[j];
    }
    ```
    
    - ¿Qué hace este programa?
    - ¿Cuál es la dirección base de arr en la memoria RAM?
    - ¿Cuál es la dirección base de sum en la memoria RAM y por qué?
    - ¿Cuál es la dirección base de j en la memoria RAM y por qué?
### RESPUESTAS
````

@0
D=A
@26      // sum
M=D

@0
D=A
@27      
M=D

@27
D=M
@10
D=D-A
@END
D;JGE         // si j >= 10 salta al final

// D = j
@27
D=M
@16
A=D+A         
D=M           


@26
M=D+M

// j = j + 1
@27
M=M+1

@LOOP
0;JMP

````
### ¿Qué hace este programa?
Este programa crea una lista de 10 números y empieza una variable llamada sum en cero. Luego, con un ciclo, 
va sumando uno por uno los números de la lista y al final guarda el total en sum.

### ¿Cuál es la dirección base de arr en la memoria RAM?
arr empieza en la dirección RAM[16]. En Hack, las variables empiezan desde ahí, así que es el primer espacio
libre donde se guarda el arreglo.

### ¿Cuál es la dirección base de sum y por qué?
sum está en RAM[26], porque el arreglo arr ocupa desde RAM[16] hasta RAM[25] (son 10 espacios), 
así que sum se guarda justo después.

### ¿Cuál es la dirección base de j y por qué?
j está en RAM[27]. Es la variable del ciclo (el que cuenta de 0 a 9), y como ya usamos hasta la RAM[26] para sum, 
lo lógico es guardar j en la siguiente dirección.
