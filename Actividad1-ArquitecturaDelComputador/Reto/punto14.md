### Implementa en ensamblador:
R4 = RAM[R1]

````
   @R1       // Ir a la dirección de R1
    A=M       // A = contenido de RAM[R1]
    D=M       // D = valor en RAM[RAM[R1]]
    @R4       // Ir a la dirección de R4
    M=D       // Guardar D en R4 (R4 = RAM[R1])
