; ET37I - Sistemas Microcontrolados
; Ex. 2 - Contador com leds (Assembly)
; (a) Pressionando e liberando o botão

; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; *                  CONFIGURAÇÕES					                *
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; Deve-se iniciar a linha abaixo com tabulação
	CONFIG  FOSC = HS, WDT = OFF, PBADEN = OFF, LVP = OFF, DEBUG = ON
; FOSC = HS: Oscilador de 20MHz -> Tcy = 200ns
; WDT = OFF: WDT desabilitado
; PBADEN = OFF:	Pinos de PORTB [4:0] configurados como I/O digital. 
; LVP = OFF: Gravação em modo de baixa tensão desabilitada
; DEBUG = ON: Depurador habilitado, RB6 and RB7 são dedicados a depuração in-circuit

 #INCLUDE <P18F4550.INC> ; MICROCONTROLADOR UTILIZADO

; VARIÁVEIS
    CBLOCK  0X00    ; ACCESS BANK
		CONTADOR	; ARMAZENA O VALOR DA CONTAGEM
    ENDC

#DEFINE	BOTAO_1	PORTB,0	;PINO DO BOTÃO_1

	ORG	0x00			;ENDEREÇO INICIAL DO PROGRAMA
	GOTO	INICIO
	

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIO DO PROGRAMA                          *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
INICIO
	BSF		TRISB,0
	CLRF	TRISD		;DEFINE TODO O PORTD COMO SAÍDA
	CLRF	INTCON2		;PULL-UPS HABILITADOS

	MOVLW	B'00000000'
	MOVWF	INTCON		;TODAS AS INTERRUPÇÕES DESLIGADAS
	
	SETF	LATD		;INICIA PORTD COM LEDS APAGADOS
	CLRF	CONTADOR	;INICIA CONTADOR = 0

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ROTINA PRINCIPAL                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
MAIN
	BTFSC	BOTAO_1		;O BOTÃO_1 ESTÁ PRESSIONADO?
	BRA		MAIN		;NÃO, VOLTA
						;SIM
	INCF	CONTADOR,F	;INCREMENTA O CONTADOR
	COMF	CONTADOR,W	;INVERTE O CONTADOR E COLOCA EM W
	MOVWF	LATD		;ATUALIZA O PORTD

ESPERA
	BTFSS	BOTAO_1		;O BOTÃO CONTINUA PRESSIONADO?
	BRA		ESPERA		;SIM, ENTÃO ESPERA LIBERAÇÃO
	BRA		MAIN		;NÃO, VOLTA AO LOOP PRINCIPAL

	END					;FIM DO PROGRAMA

