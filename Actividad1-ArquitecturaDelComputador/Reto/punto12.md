### Implemente en ensamblador:
````
R4 = R1 + R2 + 69

@1      // ir a R1
D=M     // D = R1
@2      // ir a R2
D=D+M   // D = R1 + R2
@69     // ir al valor 69
D=D+A   // D = R1 + R2 + 69
@4      // ir a R4
M=D     // guardar en R4
