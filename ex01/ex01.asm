; ET37I - Sistemas Microcontrolados 
; Exemplo 1 - Botão e Led (Assembly) PICSimLab

; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; *                  CONFIGURAÇÕES		         				  *
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; Deve-se iniciar a linha abaixo com tabulação
	CONFIG  FOSC = HS, WDT = OFF, PBADEN = OFF, LVP = OFF
; FOSC = HS		Oscilador de 20MHz -> Tcy = 200ns
; WDT = OFF		WDT desabilitado
; PBADEN = OFF	Pinos de PORTB [4:0] como I/O digital
; LVP = OFF		Gravação em modo de baixa tensão desabilitada

#INCLUDE <P18F4550.INC> ; MICROCONTROLADOR PIC18F4550

#DEFINE	BOTAO	PORTB,1	; PINO DO BOTÃO
#DEFINE	LED		PORTD,0	; PINO DO LED

	ORG	0x00			; VETOR DE RESET
	GOTO	INICIO
	
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIO DO PROGRAMA             			   *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
INICIO
	MOVLW	B'00000010'	; DEFINE RB1 COMO ENTRADA E
	MOVWF	TRISB		; O RESTO DO PORTB COMO SAÍDA
	MOVLW	B'00000000'
	MOVWF	TRISD		; DEFINE TODO O PORTD COMO SAÍDA
	
	MOVLW	B'00000000'
	MOVWF	INTCON2		; PULL-UPS HABILITADOS
	MOVLW	B'00000000'
	MOVWF	INTCON		; TODAS AS INTERRUPÇÕES DESLIGADAS

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ROTINA PRINCIPAL                      	   *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
MAIN_LOOP
	BTFSC	BOTAO		; O BOTÃO ESTÁ PRESSIONADO?
	BRA		BOTAO_LIB	; NÃO, ENTÃO TRATA BOTÃO LIBERADO
	BRA		BOTAO_PRES	; SIM, ENTÃO TRATA BOTÃO PRESSIONADO

BOTAO_LIB
	BCF		LED			; APAGA O LED
	BRA 	MAIN_LOOP	; RETORNA AO LOOP PRINCIPAL

BOTAO_PRES
	BSF		LED			; ACENDE O LED
	BRA 	MAIN_LOOP	; RETORNA AO LOOP PRINCIPAL

	END					; FIM DO PROGRAMA

