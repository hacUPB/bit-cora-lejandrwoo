### Implementa en lenguaje ensamblador:
if ( (D - 7) == 0) goto a la instrucción en ROM[69]

````
 @7         // Cargar constante 7
    D=D-A      // D = D - 7
    @69        // Dirección ROM[69]
    D;JEQ      // Si D == 0, salta a ROM[69]
