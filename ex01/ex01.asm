; ET37I - Sistemas Microcontrolados 
; Exemplo 1 - Bot�o e Led (Assembly) PICSimLab

; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; *                  CONFIGURA��ES		         				  *
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; Deve-se iniciar a linha abaixo com tabula��o
	CONFIG  FOSC = HS, WDT = OFF, PBADEN = OFF, LVP = OFF
; FOSC = HS		Oscilador de 20MHz -> Tcy = 200ns
; WDT = OFF		WDT desabilitado
; PBADEN = OFF	Pinos de PORTB [4:0] como I/O digital
; LVP = OFF		Grava��o em modo de baixa tens�o desabilitada

#INCLUDE <P18F4550.INC> ; MICROCONTROLADOR PIC18F4550

#DEFINE	BOTAO	PORTB,1	; PINO DO BOT�O
#DEFINE	LED		PORTD,0	; PINO DO LED

	ORG	0x00			; VETOR DE RESET
	GOTO	INICIO
	
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIO DO PROGRAMA             			   *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
INICIO
	MOVLW	B'00000010'	; DEFINE RB1 COMO ENTRADA E
	MOVWF	TRISB		; O RESTO DO PORTB COMO SA�DA
	MOVLW	B'00000000'
	MOVWF	TRISD		; DEFINE TODO O PORTD COMO SA�DA
	
	MOVLW	B'00000000'
	MOVWF	INTCON2		; PULL-UPS HABILITADOS
	MOVLW	B'00000000'
	MOVWF	INTCON		; TODAS AS INTERRUP��ES DESLIGADAS

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ROTINA PRINCIPAL                      	   *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
MAIN_LOOP
	BTFSC	BOTAO		; O BOT�O EST� PRESSIONADO?
	BRA		BOTAO_LIB	; N�O, ENT�O TRATA BOT�O LIBERADO
	BRA		BOTAO_PRES	; SIM, ENT�O TRATA BOT�O PRESSIONADO

BOTAO_LIB
	BCF		LED			; APAGA O LED
	BRA 	MAIN_LOOP	; RETORNA AO LOOP PRINCIPAL

BOTAO_PRES
	BSF		LED			; ACENDE O LED
	BRA 	MAIN_LOOP	; RETORNA AO LOOP PRINCIPAL

	END					; FIM DO PROGRAMA

