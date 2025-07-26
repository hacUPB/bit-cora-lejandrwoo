### Implementa en ensamblador:
````
if R0 >= 0 then R1 = 1
else R1 = –1

(LOOP)
goto LOOP
````
 @R0
    D=M            // Carga el valor de R0 en el registro D
    @POS
    D;JGE          // Si D (es decir, R0) es mayor o igual a 0, salta a la etiqueta POS
    @R1
    M=-1           // Si no, guarda -1 en R1
    @LOOP
    0;JMP          // Salta a LOOP (bucle infinito)
    @R1
    M=1            // Si R0 >= 0, guarda 1 en R1
    @LOOP
    0;JMP          // Bucle infinito
