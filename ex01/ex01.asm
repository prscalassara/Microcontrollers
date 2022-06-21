; ET37I - Sistemas Microcontrolados 
; Exemplo 1 - Bot�o e Led (Assembly) PICSimLab

; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; *                  CONFIGURA��ES				                    *
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; Deve-se iniciar a linha abaixo com tabula��o
	CONFIG  FOSC = HS, WDT = OFF, PBADEN = OFF, LVP = OFF, DEBUG = ON
; FOSC = HS: Oscilador de 20MHz -> Tcy = 200ns
; WDT = OFF: WDT desabilitado
; PBADEN = OFF:	Pinos de PORTB [4:0] configurados como I/O digital. 
; LVP = OFF: Grava��o em modo de baixa tens�o desabilitada
; DEBUG = ON: Depurador habilitado, RB6 and RB7 s�o dedicados a depura��o in-circuit

#INCLUDE <P18F4550.INC> ; MICROCONTROLADOR PIC18F4550

#DEFINE	BOTAO	PORTB,1	; PINO DO BOT�O

#DEFINE	LED		PORTD,0	; PINO DO LED

	ORG	0x00			; VETOR DE RESET
	GOTO	INICIO
	
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIO DO PROGRAMA                          *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
INICIO
	MOVLW	B'00000010'
	MOVWF	TRISB		;DEFINE TODO O PORTB COMO SA�DA, MENOS RB1
	MOVLW	B'00000000'
	MOVWF	TRISD		;DEFINE TODO O PORTD COMO SA�DA
	
	MOVLW	B'00000000'
	MOVWF	INTCON2		;PULL-UPS HABILITADOS
	MOVLW	B'00000000'
	MOVWF	INTCON		;TODAS AS INTERRUP��ES DESLIGADAS

	BCF		LED			;APAGA O LED

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ROTINA PRINCIPAL                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
MAIN_LOOP
	BTFSC	BOTAO		;O BOT�O EST� PRESSIONADO?
	BRA		BOTAO_LIB	;N�O, ENT�O TRATA BOT�O LIBERADO
	BRA		BOTAO_PRES	;SIM, ENT�O TRATA BOT�O PRESSIONADO

BOTAO_LIB
	BCF		LED			;APAGA O LED
	BRA 	MAIN_LOOP	;RETORNA AO LOOP PRINCIPAL

BOTAO_PRES
	BSF		LED			;ACENDE O LED
	BRA 	MAIN_LOOP	;RETORNA AO LOOP PRINCIPAL

	END					;FIM DO PROGRAMA

