
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
   
    @R0
    A=M
    M=-1          

   
    @LOOP
    0;JMP

(ERASE)
 
    @R0
    A=M
    M=0

    @LOOP
    0;JMP

