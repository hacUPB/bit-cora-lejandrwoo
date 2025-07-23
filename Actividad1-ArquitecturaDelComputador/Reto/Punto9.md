### Considera el siguiente programa:

i = 1
sum = 0
sum = sum + i
i = i + 1

### La traducción a lenguaje ensamblador del programa anterior es:
// i = 1
@i
M=1
// sum = 0
@sum
M=0
// sum = sum + i
@i
D=M
@sum
M=D+M
// i = i + 1
@i
D=M+1
@i
M=D
​
### ¿Qué hace este programa?
Suma 1 a una variable llamada sum, y luego le suma 1 a otra variable llamada i. Al final, sum = 1 e i = 2.
### ¿En qué parte de la memoria RAM está la variable i y sum? ¿Por qué en esas posiciones?
i y sum están en la memoria desde la posición 16 en adelante (por ejemplo, i = 16, sum = 17) porque Hack 
guarda las variables nuevas empezando desde la casilla 16.


### Optimiza esta parte del código para que use solo dos instrucciones:
// i = i + 1
@i
D=M+1
@i
M=D

### RESPUESTA:
@i 
M=M+1               //Esto hace lo mismo (i = i + 1), pero en una sola línea en vez de dos.
