11. Considera el siguiente programa:
    
    ```nasm
    i = 1000
    LOOP:
    if (i == 0) goto CONT
    i = i - 1
    goto LOOP
    CONT:
    ```
    
    La traducción a lenguaje ensamblador del programa anterior es:
    
    ```nasm
    // i = 1000
    @1000
    D=A
    @i
    M=D
    (LOOP)
    // if (i == 0) goto CONT
    @i
    D=M
    @CONT
    D;JEQ
    // i = i - 1
    @i
    M=M-1
    // goto LOOP
    @LOOP
    0;JMP
    (CONT)
    ```
    
### ¿Qué hace este programa?
Cuenta hacia atrás desde 1000 hasta 0.
### ¿En qué memoria está almacenada la variable i? ¿En qué dirección de esa memoria?
En la RAM, en la dirección 16 (asignada automáticamente por el ensamblador).
### ¿En qué memoria y en qué dirección de memoria está almacenado el comentario //i = 1000?`
No se almacena en memoria; los comentarios son ignorados por el ensamblador.
### ¿Cuál es la primera instrucción del programa anterior? ¿En qué memoria y en qué dirección de memoria está almacenada esa instrucción?
@1000, está almacenada en la ROM, en la dirección 0.
### ¿Qué son CONT y LOOP?
Etiquetas que marcan posiciones en el código para saltos.
### ¿Cuál es la diferencia entre los símbolos i y CONT?
i es una variable (almacenada en RAM), CONT es una etiqueta de instrucción (ubicada en ROM).
