; ET37I - Sistemas Microcontrolados
; Ex. 2 - Contador com leds (Assembly)
; 	(b)Utilizando atraso no bot�o

; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; *                  CONFIGURA��ES					                *
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; Deve-se iniciar a linha abaixo com tabula��o
	CONFIG  FOSC = HS, WDT = OFF, PBADEN = OFF, LVP = OFF, DEBUG = ON
; FOSC = HS: Oscilador de 20MHz -> Tcy = 200ns
; WDT = OFF: WDT desabilitado
; PBADEN = OFF:	Pinos de PORTB [4:0] configurados como I/O digital. 
; LVP = OFF: Grava��o em modo de baixa tens�o desabilitada
; DEBUG = ON: Depurador habilitado, RB6 and RB7 s�o dedicados a depura��o in-circuit

 #INCLUDE <P18F4550.INC> ; MICROCONTROLADOR UTILIZADO

; VARI�VEIS
    CBLOCK  0X00    ;ACCESS BANK
		CONTADOR	;ARMAZENA O VALOR DA CONTAGEM
		ATRASO		;VARI�VEL DE ATRASO PARA O BOT�O
    ENDC

; CONSTANTES
TEMPO_ATRASO	EQU	.250	;ATRASO PARA BOT�O

#DEFINE	BOTAO_1	PORTB,0	;PINO DO BOT�O_1

	ORG	0x00			;ENDERE�O INICIAL DO PROGRAMA
	GOTO	INICIO
	

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIO DO PROGRAMA                          *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
INICIO
	MOVLW	B'00000001'
	MOVWF	TRISB		;DEFINE RB0 COMO ENTRADA
	MOVLW	B'00000000'
	MOVWF	TRISD		;DEFINE TODO O PORTD COMO SA�DA
	CLRF	INTCON2		;PULL-UPS HABILITADOS

	MOVLW	B'00000000'
	MOVWF	INTCON		;TODAS AS INTERRUP��ES DESLIGADAS
	
	SETF	LATD		;INICIA PORTD COM LEDS APAGADOS
	CLRF	CONTADOR	;INICIA CONTADOR = 0

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ROTINA PRINCIPAL                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
MAIN
	MOVLW	TEMPO_ATRASO
	MOVWF	ATRASO		;INICIALIZA ATRASO = TEMPO_ATRASO

VERIFICA_BT1
	BTFSC	BOTAO_1		;O BOT�O_1 EST� PRESSIONADO?
	BRA		MAIN		;N�O, VOLTA
						;SIM
	DECFSZ	ATRASO,F	;DECREMENTA O ATRASO DO BOT�O
						;TERMINOU?
	BRA		VERIFICA_BT1;N�O, CONTINUA ESPERANDO
						;SIM
	INCF	CONTADOR,F	;INCREMENTA O CONTADOR
	COMF	CONTADOR,W	;INVERTE O CONTADOR E COLOCA EM W
	MOVWF	LATD		;ATUALIZA O PORTD

ESPERA_BT1
	BTFSS	BOTAO_1		;O BOT�O CONTINUA PRESSIONADO?
	BRA		ESPERA_BT1	;SIM, ENT�O ESPERA LIBERA��O
	BRA		MAIN		;N�O, VOLTA AO LOOP PRINCIPAL

	END					;FIM DO PROGRAMA
