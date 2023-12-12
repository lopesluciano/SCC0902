; Pong - Protótipo Simples

; Variáveis
Paddle1Pos: var #10  ; Posição do jogador 1
Paddle2Pos: var #10 ; Posição do jogador 2
BallPos:    var #400 ; Posição da bola
BallDir:    var #0   ; Direção da bola (0 - direita superior, 1 - esquerda superior, 2 - direita inferior, 3 - esquerda inferior)

; Constantes
ScreenWidth:  var #40
ScreenHeight: var #40
PaddleHeight: var #3
BallSpeed:    var #1

; Função principal
main:
    call Initialize
    loop:
        call DrawPaddles
        call MovePaddle
        call Delay
        jmp loop

; Inicialização do Jogo
Initialize:
    loadn r0, #400
    store Paddle1Pos, r0
    loadn r0, #439
    store Paddle2Pos, r0
    rts

; Desenhar as paletas
DrawPaddles:
    loadn r2, #40
    loadn r0, #'|'
    load r1, Paddle1Pos
    outchar r0, r1
    add r1, r1, r2
    outchar r0, r1
    add r1, r1, r2
    outchar r0, r1
    add r1, r1, r2
    outchar r0, r1
    add r1, r1, r2
    outchar r0, r1
    add r1, r1, r2
    outchar r0, r1
    add r1, r1, r2
    outchar r0, r1
    add r1, r1, r2
    outchar r0, r1
    add r1, r1, r2
    outchar r0, r1
    add r1, r1, r2
    outchar r0, r1
    
    load r1, Paddle2Pos
    outchar r0, r1
    add r1, r1, r2
    outchar r0, r1
    add r1, r1, r2
    outchar r0, r1
    add r1, r1, r2
    outchar r0, r1
    add r1, r1, r2
    outchar r0, r1
    add r1, r1, r2
    outchar r0, r1
    add r1, r1, r2
    outchar r0, r1
    add r1, r1, r2
    outchar r0, r1
    add r1, r1, r2
    outchar r0, r1
    add r1, r1, r2
    outchar r0, r1
    rts
    
MovePaddle:
    inchar r0
    call MovePaddle1
    call MovePaddle2
    rts

; Mover a paleta do jogador 1
MovePaddle1:
    loadn r1, #119 ; 'w'
    loadn r2, #115 ; 's'
    loadn r4, #40
    loadn r6, #360

    cmp r0, r1
    jeq MovePaddle1Up
    cmp r0, r2
    jeq MovePaddle1Down
    jmp MovePaddle1End

    MovePaddle1Up:
        load r3, Paddle1Pos
        loadn r5, #' '
        add r7, r3, r6
        outchar r5, r7
        sub r3, r3, r4
        store Paddle1Pos, r3
        jmp MovePaddle1End

    MovePaddle1Down:
        load r3, Paddle1Pos
        loadn r5, #' '
        outchar r5, r3
        add r3, r3, r4
        store Paddle1Pos, r3
        
    MovePaddle1End:
        rts
        
; Mover a paleta do jogador 2
MovePaddle2:
    loadn r1, #107 ;'k'
    loadn r2, #109 ; 'm'
    loadn r4, #40
    loadn r6, #360

    cmp r0, r1
    jeq MovePaddle2Up
    cmp r0, r2
    jeq MovePaddle2Down
    jmp MovePaddle2End

    MovePaddle2Up:
        load r3, Paddle2Pos
        loadn r5, #' '
        add r7, r3, r6
        outchar r5, r7
        sub r3, r3, r4
        store Paddle2Pos, r3
        jmp MovePaddle2End

    MovePaddle2Down:
        load r3, Paddle2Pos
        loadn r5, #' '
        outchar r5, r3
        add r3, r3, r4
        store Paddle2Pos, r3
        
    MovePaddle2End:
        rts

; Atraso para controle de velocidade
Delay:
    loadn r0, #50000
    loop_delay:
        dec r0
        loadn r1, #0
        cmp r0, r1
        jne loop_delay
    rts