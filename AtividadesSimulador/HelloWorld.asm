

jmp main


mensagem : var #21
mensagem2 : string "Hello World!"

; Main

main:
	loadn r0, #0		; posicao da mensagem na tela 
	loadn r1, #mensagem2	; carrega o endereco de vetor da string
	loadn r2, #512		; cor 
	
	call Imprimestr   ;  r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"

	halt
	
; Subrotinas
	
Imprimestr:	
	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	
	loadn r3, #'\0'	; Criterio de parada

ImprimestrLoop:	; Loop de impressao da string (char por char)
	loadi r4, r1
	cmp r4, r3
	jeq ImprimestrSai
	add r4, r2, r4
	outchar r4, r0
	inc r0
	inc r1
	jmp ImprimestrLoop
	
ImprimestrSai:	
	pop r4	
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	

