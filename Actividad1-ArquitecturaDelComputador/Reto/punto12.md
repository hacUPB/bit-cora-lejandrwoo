### Implemente en ensamblador:
````
R4 = R1 + R2 + 69
````
### Respuesta
````
@1      // Accede a R1 (que está en RAM[1])
D = M   // Guarda el valor de R1 en el registro D

@2      // Accede a R2 (RAM[2])
D = D + M   // Suma R1 + R2 y guarda el resultado en D

@69     // Accede al valor constante 69 (no es una dirección, es el número)
D = D + A   // Suma D + 69 → ahora D = R1 + R2 + 69

@4      // Accede a R4 (RAM[4])
M = D   // Guarda el resultado en R4
