# Las posiciones de memoria RAM de 0 a 15 tienen los nombres simbólico R0 a R15. Escribe un programa en lenguaje ensamblador que guarde en R1 la operación 2 * R0.
````
@0        // Apuntamos a R0
D=M       // D = M[R0]  (Cargamos el valor de R0 en D)
@0
D=D+M     // D = D + M[R0] => D = R0 + R0 (multiplicamos por 2)
@1
M=D      // Guardamos el resultado en R1

