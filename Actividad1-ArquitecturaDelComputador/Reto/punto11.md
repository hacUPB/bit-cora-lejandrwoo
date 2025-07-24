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
    
    - ¿Qué hace este programa?
      Cuenta hacia atrás desde 1000 hasta 0.
    - ¿En qué memoria está almacenada la variable i? ¿En qué dirección de esa memoria?
    - ¿En qué memoria y en qué dirección de memoria está almacenado el comentario //`i = 1000?`
    - ¿Cuál es la primera instrucción del programa anterior? ¿En qué memoria y en qué dirección de memoria está almacenada esa instrucción?
    - ¿Qué son CONT y LOOP?
    - ¿Cuál es la diferencia entre los símbolos `i` y `CONT`?
