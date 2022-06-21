; ET37I - Sistemas Microcontrolados 
; Exemplo 1 - Botão e Led (Assembly) PICSimLab

; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; *                  CONFIGURAÇÕES				                    *
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; Deve-se iniciar a linha abaixo com tabulação
	CONFIG  FOSC = HS, WDT = OFF, PBADEN = OFF, LVP = OFF, DEBUG = ON
; FOSC = HS: Oscilador de 20MHz -> Tcy = 200ns
; WDT = OFF: WDT desabilitado
; PBADEN = OFF:	Pinos de PORTB [4:0] configurados como I/O digital. 
; LVP = OFF: Gravação em modo de baixa tensão desabilitada
; DEBUG = ON: Depurador habilitado, RB6 and RB7 são dedicados a depuração in-circuit

#INCLUDE <P18F4550.INC> ; MICROCONTROLADOR PIC18F4550

#DEFINE	BOTAO	PORTB,1	; PINO DO BOTÃO

#DEFINE	LED		PORTD,0	; PINO DO LED

	ORG	0x00			; VETOR DE RESET
	GOTO	INICIO
	
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIO DO PROGRAMA                          *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
INICIO
	MOVLW	B'00000010'
	MOVWF	TRISB		;DEFINE TODO O PORTB COMO SAÍDA, MENOS RB1
	MOVLW	B'00000000'
	MOVWF	TRISD		;DEFINE TODO O PORTD COMO SAÍDA
	
	MOVLW	B'00000000'
	MOVWF	INTCON2		;PULL-UPS HABILITADOS
	MOVLW	B'00000000'
	MOVWF	INTCON		;TODAS AS INTERRUPÇÕES DESLIGADAS

	BCF		LED			;APAGA O LED

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ROTINA PRINCIPAL                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
MAIN_LOOP
	BTFSC	BOTAO		;O BOTÃO ESTÁ PRESSIONADO?
	BRA		BOTAO_LIB	;NÃO, ENTÃO TRATA BOTÃO LIBERADO
	BRA		BOTAO_PRES	;SIM, ENTÃO TRATA BOTÃO PRESSIONADO

BOTAO_LIB
	BCF		LED			;APAGA O LED
	BRA 	MAIN_LOOP	;RETORNA AO LOOP PRINCIPAL

BOTAO_PRES
	BSF		LED			;ACENDE O LED
	BRA 	MAIN_LOOP	;RETORNA AO LOOP PRINCIPAL

	END					;FIM DO PROGRAMA

