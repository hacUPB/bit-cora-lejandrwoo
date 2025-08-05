// Inicialización: R0 = SCREEN base
@SCREEN
D=A
@R0
M=D

(LOOP)
    @KBD
    D=M
    @100
    D=D-A
    @DRAW
    D;JEQ
    @ERASE
    0;JMP

(DRAW)
    // guarda retorno
    @LOOP
    D=A
    @R13
    M=D

    // R0 ya contiene SCREEN base → usaremos A=M desde R0

    // ROW 1
    @R0
    A=M
    M=-1
    @R0
    M=M+1
    A=M
    M=0
    @R0
    M=M+1
    A=M
    M= ? // aquí ajusta según patrón de valores en fila 1
    @R0
    M=M+1

    // ROW 2 .. ROW 32
    // Continúa copiando cada fila exactamente como en tu bloque original,
    // usando lógica similar: 
    // @offset
    // D=...; A=...; M=...; @R0 M=M+1

    // Al final del bloque completo:
    @R13
    A=M
    0;JMP

(ERASE)
    @R0
    A=M
    M=0
    @LOOP
    0;JMP
