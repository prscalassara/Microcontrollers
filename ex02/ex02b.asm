; ET37I - Sistemas Microcontrolados
; Ex. 2 - Contador com leds (Assembly) PICSimLab
; 	(b)Utilizando atraso no bot�o

; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; *                  CONFIGURA��ES					                *
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; Deve-se iniciar a linha abaixo com tabula��o
	CONFIG  FOSC = HS, CPUDIV = OSC1_PLL2, WDT = OFF, PBADEN = OFF, LVP = OFF
; FOSC = HS		Oscilador de 20MHz -> Tcy = 200ns
; WDT = OFF		WDT desabilitado
; PBADEN = OFF	Pinos de PORTB [4:0] como I/O digital
; LVP = OFF		Grava��o em modo de baixa tens�o desabilitada

#INCLUDE <P18F4550.INC> 

    CBLOCK  0X00   
		CONTADOR		; ARMAZENA O VALOR DA CONTAGEM
		ATRASO			; VARI�VEL DE ATRASO PARA O BOT�O
    ENDC

; CONSTANTES
TEMPO_ATRASO	EQU	.250	; ATRASO PARA BOT�O

#DEFINE	BOTAO_1	PORTB,0	; PINO DO BOT�O_1

	ORG	0x00			
	GOTO	INICIO

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIO DO PROGRAMA                 		   *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
INICIO
	MOVLW	B'00000001'
	MOVWF	TRISB		; DEFINE RB0 COMO ENTRADA
	CLRF	TRISD		; DEFINE TODO O PORTD COMO SA�DA
	CLRF	INTCON2		; PULL-UPS HABILITADOS
	CLRF	INTCON		; TODAS AS INTERRUP��ES DESLIGADAS
	
	CLRF	LATD		; INICIA PORTD COM LEDS APAGADOS
	CLRF	CONTADOR	; INICIA CONTADOR = 0

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ROTINA PRINCIPAL                      	   *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
MAIN
	MOVLW	TEMPO_ATRASO
	MOVWF	ATRASO		; INICIALIZA ATRASO = TEMPO_ATRASO

VERIFICA_BT1
	BTFSC	BOTAO_1		; O BOT�O_1 EST� PRESSIONADO?
	BRA		MAIN		; N�O, VOLTA
						; SIM
	DECFSZ	ATRASO,F	; DECREMENTA O ATRASO DO BOT�O
						; TERMINOU?
	BRA		VERIFICA_BT1; N�O, CONTINUA ESPERANDO
						; SIM
	INCF	CONTADOR,F	; INCREMENTA O CONTADOR
	MOVF	CONTADOR,W	; COLOCA CONTADOR EM W
	MOVWF	LATD		; ATUALIZA O PORTD

ESPERA_BT1
	BTFSS	BOTAO_1		; O BOT�O CONTINUA PRESSIONADO?
	BRA		ESPERA_BT1	; SIM, ENT�O ESPERA LIBERA��O
	BRA		MAIN		; N�O, VOLTA AO LOOP PRINCIPAL

	END					; FIM DO PROGRAMA
