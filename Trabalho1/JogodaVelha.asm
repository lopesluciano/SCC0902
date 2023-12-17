Tabela : string "_________"
Titulo : string "Jogo Da Velha Trabalho Arq e Org"
Reset : string "Aperte Espaco Para Resetar"
Vazio : string "                          "
Selecionador : var #1
Vez : var #1;
Controles : string "Controles:"
Movimentacao : string "Selecionar - 1 a 9"
Colocar : string "Efetuar Jogada - Enter "

main:
  loadn r0, #0
  loadn r5, #578
  loadn r6, #0
  store Selecionador, r0
  store Vez, r0
  
  call ImprimeTitulo
  
  mainloop :
  call LeTecla
  
  mov r2, r5
  call Imprimi
  
  jmp mainloop

halt

Compara:
  push r0
  push r1
  push r2
  loadn r3, #Tabela
  add r0, r0, r3
  add r1, r1, r3
  add r2, r2, r3
  loadi r0, r0
  loadi r1, r1
  loadi r2, r2
  
  cmp r0, r1
  jne Diferente
  cmp r0, r2
  jne Diferente 
  
  loadn r3, #'_'
  cmp r3, r0
  jeq Diferente
  loadn r3, #1
  
  jmp ComparaEnd
  
  Diferente :
  loadn r3, #0
  
  ComparaEnd :
  pop r2
  pop r1
  pop r0
rts

Ganhou:
  push r0
  push r1
  push r2
  push r3
  push r4
  loadn r4, #1
  
  loadn r0,#0
  loadn r1,#1
  loadn r2,#2
  call Compara
  cmp r4, r3
  jeq HouveVencedor
  
  loadn r0,#3
  loadn r1,#4
  loadn r2,#5
  call Compara
  cmp r4, r3
  jeq HouveVencedor
  
  loadn r0,#6
  loadn r1,#7
  loadn r2,#8
  call Compara
  cmp r4, r3
  jeq HouveVencedor
  
  loadn r0,#0
  loadn r1,#3
  loadn r2,#6
  call Compara
  cmp r4, r3
  jeq HouveVencedor
  
  loadn r0,#1
  loadn r1,#4
  loadn r2,#7
  call Compara
  cmp r4, r3
  jeq HouveVencedor
  
  loadn r0,#2
  loadn r1,#5
  loadn r2,#8
  call Compara
  cmp r4, r3
  jeq HouveVencedor
  
  loadn r0,#0
  loadn r1,#4
  loadn r2,#8
  call Compara
  cmp r4, r3
  jeq HouveVencedor

  loadn r0,#2
  loadn r1,#4
  loadn r2,#6
  call Compara
  cmp r4, r3
  jeq HouveVencedor
  
  
  jmp NinguemGanhou
  HouveVencedor :

  call Colore
  call ApertaEspaco
  call reinicia
  
  NinguemGanhou :
  call Velha
  pop r4
  pop r3
  pop r2
  pop r3
  pop r0
rts

Velha:
  push r0
  loadn r0, #9
  cmp r0, r6
  jne NotVelha
  call PrintValor
  call ApertaEspaco
  call reinicia
  NotVelha :
  
  pop r0
rts

MudaVez:
  push r0
  push r1
  load r0, Vez
  loadn r1, #0
  cmp r0, r1
  jne MudaVezEnd
  loadn r1, #1
  MudaVezEnd :
  store Vez, r1
  pop r1
  pop r0
rts
Jogador2:
  loadn r1, #Tabela
    load r0, Selecionador
    add r1, r1, r0
    
    loadi r0 , r1
    loadn r2, #'_'
    cmp r2, r0
    jne JogoEnd
    loadn r0, #'O'
    storei r1, r0
    inc r6
    call MudaVez
    call Ganhou
rts

Jogo:
  push r0
  push r1
  push r2

  load r0, Vez
  loadn r1, #0
  cmp r0, r1
  jeq Jogador1
  call Jogador2
  jmp JogoEnd
  Jogador1 :
    loadn r1, #Tabela
    load r0, Selecionador
    add r1, r1, r0
    
    loadi r0 , r1
    loadn r2, #'_'
    cmp r2, r0
    jne JogoEnd
    loadn r0, #'X'
    storei r1, r0
    inc r6
    call MudaVez
    call Ganhou
  
  JogoEnd :
    pop r2
    pop r1
    pop r0
    rts

LeTecla:
  push r0
  push r1
  inchar r0
  
  loadn r1, #13
  cmp r0, r1
  jne LeTecladoNaoEnter

  call Jogo
  jmp LeTecladoFim
  
  LeTecladoNaoEnter :
  loadn r1, #49
  sub r0, r0, r1
  loadn r1, #9
  cmp r0, r1
  jgr LeTecladoFim
  store Selecionador, r0
  
  LeTecladoFim :
  pop r1
  pop r0
rts


Imprimi:
  push r0
  push r1
  push r2
  push r3
  push r4
  loadn r0, #0
  loadn r1, #Tabela
  
  printloop :
  loadi r3, r1
  load r4, Selecionador
  cmp r4, r0
  jne printsemcursor

  loadn r4, #3072
  add r3, r3, r4
  printsemcursor :
  
  outchar r3, r2
  inc r2
  inc r1
  inc r0
  
  loadn r3, #3
  mod r3, r0, r3
  loadn r4, #0
  cmp r4, r3
  jne printnaoenter
  

  loadn r3, #37
  add r2, r2, r3
  printnaoenter :
  loadn r3, #9
  cmp r0, r3
  jle printloop
  
  pop r4
  pop r3
  pop r2
  pop r1
  pop r0
rts

reinicia:
  push r0
  push r1
  push r2
  push r3
  loadn r6, #0
  loadn r0, #Tabela
  loadn r1, #0
  
  reinicialoop :
  add r2, r0, r1
  loadn r3, #'_'
  storei r2, r3
  inc r1
  loadn r3, #9
  cmp r1, r3
  jne reinicialoop
  
  pop r3
  pop r2
  pop r1
  pop r0
rts

ImprimeTitulo:
  push r0
  push r1
  push r2
  push r3
  loadn r0, #Titulo
  loadn r1, #44
  loadi r2, r0
  LoopImprimeMsg :
  outchar r2, r1
  inc r1
  inc r0
  loadi r2, r0
  loadn r3, #'\0'
  cmp r2, r3
  jne LoopImprimeMsg

  pop r3
  pop r2
  pop r1
  pop r0
  
  push r0
  push r1
  push r2
  push r3
  loadn r0, #Controles
  loadn r1, #841
  loadi r2, r0
  LoopImprimeMsg2 :
  outchar r2, r1
  inc r1
  inc r0
  loadi r2, r0
  loadn r3, #'\0'
  cmp r2, r3
  jne LoopImprimeMsg2
  pop r3
  pop r2
  pop r1
  pop r0
  
  push r0
  push r1
  push r2
  push r3
  loadn r0, #Movimentacao
  loadn r1, #881
  loadi r2, r0
  LoopImprimeMsg3 :
  outchar r2, r1
  inc r1
  inc r0
  loadi r2, r0
  loadn r3, #'\0'
  cmp r2, r3
  jne LoopImprimeMsg3
  pop r3
  pop r2
  pop r1
  pop r0
  
    push r0
  push r1
  push r2
  push r3
  loadn r0, #Colocar
  loadn r1, #921
  loadi r2, r0
  LoopImprimeMsg4 :
  outchar r2, r1
  inc r1
  inc r0
  loadi r2, r0
  loadn r3, #'\0'
  cmp r2, r3
  jne LoopImprimeMsg4
  pop r3
  pop r2
  pop r1
  pop r0
  
  
rts


ImprimeReset:
  push r0
  push r1
  push r2
  push r3
  loadn r0, #Reset
  loadn r1, #1127
  loadi r2, r0
  LoopImprimeMsg :
  outchar r2, r1
  inc r1
  inc r0
  loadi r2, r0
  loadn r3, #'\0'
  cmp r2, r3
  jne LoopImprimeMsg
  
  pop r3
  pop r2
  pop r1
  pop r0
  
rts

ImprimeVazio:
  push r0
  push r1
  push r2
  push r3
  loadn r0, #Vazio
  loadn r1, #1127
  loadi r2, r0
  LoopImprimeMsg :
  outchar r2, r1
  inc r1
  inc r0
  loadi r2, r0
  loadn r3, #'\0'
  cmp r2, r3
  jne LoopImprimeMsg
  
  pop r3
  pop r2
  pop r1
  pop r0
  
rts

ApertaEspaco:
  inchar r6
  loadn r7, #' '
  call ImprimeReset
  cmp r6, r7
  jne ApertaEspaco
  call ImprimeVazio

Colore:
  
  push r4
  push r3
  push r2
  push r1
  push r0
  push r7
  
  load r4, Vez
  loadn r3, #0
  cmp r4, r3
  loadn r7, #2816
  jmp SaiCor
  SaiCor :
  
  loadn r3, #Tabela
  add r3, r3, r0
  loadi r4, r3
  
  add r4, r4, r7
  storei r3, r4
  
  loadn r3, #Tabela
  add r3, r3, r1
  loadi r4, r3

  add r4, r4, r7
  storei r3, r4
  
  loadn r3, #Tabela
  add r3, r3, r2
  loadi r4, r3

  add r4, r4, r7
  storei r3, r4
  
  call PrintValor
  
  pop r7
  pop r0
  pop r1
  pop r2
  pop r3
  pop r4
  
rts
PrintValor:
  push r0
  push r1
  push r2
  
  load r0, Selecionador
  loadn r1, #10
  store Selecionador, r1
  
  mov r2, r5
  call Imprimi
  
  store Selecionador, r0
  pop r2
  pop r1
  pop r0
rts