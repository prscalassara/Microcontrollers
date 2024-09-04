; ET37I - Sistemas Microcontrolados
; Ex. 3 - Contador com displays de 7 segmentos (Assembly) -> PICSimLab
;
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; *                  CONFIGURA��ES 					                
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; Deve-se iniciar a linha abaixo com tabula��o
	CONFIG  FOSC = HS, WDT = OFF, PBADEN = OFF
; FOSC = HS		Oscilador de 20MHz -> Tcy = 200ns
; WDT = OFF		WDT desabilitado
; PBADEN = OFF	Pinos de PORTB [4:0] como I/O digital. 

 #INCLUDE <P18F4550.INC> 

	CBLOCK  0X00        ;BANCO DE ACESSO
		CONTADOR    ;ARMAZENA O VALOR DA CONTAGEM
		ATRASO	       ;ATRASO PARA O BOT�O
	ENDC

T_ATRASO    EQU	.250	;ATRASO PARA BOT�O

#DEFINE	BOTAO_1	PORTB,1	;PINO DO BOT�O_1
						
	ORG		0x00	;ENDERE�O INICIAL
	GOTO	INICIO


; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;  SUBROTINA DE CONVERS�O PARA DISPLAY DE 7 SEGMENTOS   
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;  ROTINA PARA CONVERS�O DO VALOR N�M�RICO PARA OS SEGMENTOS
;  QUE DEVEM SER ACESOS E APAGADOS NO DISPLAY
CONV_DISP_7SEG
	MOVF	CONTADOR,W	; MOVE CONTADOR PARA W PARA FAZER MASCARAMENTO
	ANDLW	B'00001111'	; EXECUTA MASCARA P/ EVITAR PULOS ERRADOS
	MULLW	.2			; MULTIPLICA POR 2, POIS PC USA 2 BYTES
	MOVF	PRODL,W
	ADDWF	PCL,F		; SOMA DESLOCAMENTO AO PC
						; POSI��O RELATIVA AOS SEGMENTOS: PGFEDCBA
	RETLW	B'00111111'	; 0H - 0
	RETLW	B'00000110'	; 1H - 1
	RETLW	B'01011011'	; 2H - 2
	RETLW	B'01001111'	; 3H - 3
	RETLW	B'01100110'	; 4H - 4
	RETLW	B'01101101'	; 5H - 5
	RETLW	B'01111101'	; 6H - 6
	RETLW	B'00000111'	; 7H - 7
	RETLW	B'01111111'	; 8H - 8
	RETLW	B'01101111'	; 9H - 9
	RETLW	B'01110111'	; AH - 10
	RETLW	B'01111100'	; BH - 11
	RETLW	B'00111001'	; CH - 12
	RETLW	B'01011110'	; DH - 13
	RETLW	B'01111001'	; EH - 14
	RETLW	B'01110001'	; FH - 15

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;                     INICIO DO PROGRAMA                         
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
INICIO
	MOVLW	B'00000010'
	MOVWF	TRISB		;DEFINE RB1 COMO ENTRADA
	MOVLW	B'00000000'
	MOVWF	TRISD		;DEFINE TODO O PORTD COMO SA�DA
	CLRF	TRISA
	
	MOVLW	B'00000000'
	MOVWF	INTCON2		;PULL-UPS HABILITADOS
	MOVLW	B'00000000'
	MOVWF	INTCON		;TODAS AS INTERRUP��ES DESLIGADAS
	
	MOVLW	H'0F'
	MOVWF	ADCON1		; DESLIGA PINOS ANAL�GICOS
	
	CLRF	CONTADOR	;INICIA CONTADOR = 0
	MOVLW	B'00111111'	;CARREGA O ZERO DO DISPLAY
	MOVWF	LATD		;LIGADO AO DISPLAY
	BSF		LATA,5		;HABILITA DISPLAY4
	
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; ROTINA PRINCIPAL                            
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
MAIN
	MOVLW	T_ATRASO
	MOVWF	ATRASO		;INICIALIZA ATRASO = T_ATRASO

VERIFICA_BT1
	BTFSC	BOTAO_1		;O BOT�O_1 EST� PRESSIONADO?
	BRA		MAIN		;N�O, VOLTA
						;SIM
	DECFSZ	ATRASO,F	;DECREMENTA O ATRASO DO BOT�O
						;TERMINOU?
	BRA		VERIFICA_BT1	;N�O, CONTINUA ESPERANDO
						;SIM
	INCF		CONTADOR,F	;INCREMENTA O CONTADOR
	CALL	CONV_DISP_7SEG	;CHAMA SUBROTINA DE CONVERS�O 
	MOVWF	LATD		;ATUALIZA O PORTD

ESPERA_BT1
	BTFSS	BOTAO_1		;O BOT�O CONTINUA PRESSIONADO?
	BRA		ESPERA_BT1	;SIM, ENT�O ESPERA LIBERA��O
	BRA		MAIN		;N�O, VOLTA AO LOOP PRINCIPAL
	END					;FIM DO PROGRAMA

