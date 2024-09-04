## Exemplo 2

Crie um *firmware* em *Assembly* para o PIC18F4550 do circuito abaixo, no qual, a função do botão BT1, conectado em 
`PORTB,0`, é incrementar um contador de 4 bits cuja contagem seja apresentada nos leds D1 (LSB) a D4 (MSB), conectados 
em `PORTD,0` a `PORTD,3` respectivamente. Utilize duas abordagens:

(a) Execute a função do botão somente após este ser pressionado e liberado.  
(b) Utilize um atraso para o botão ser considerado pressionado.

![circ_ex02_picsim](https://github.com/user-attachments/assets/3aec42fb-22dc-455e-9f9d-8cd84acfe51b)

Utilizou-se o fluxograma abaixo, modificado do ex. 1, para implementar o algoritmo do item (a):

![fluxograma_ex2a](https://github.com/user-attachments/assets/62bb7482-b543-47f0-aa3f-9822c8d58f5b)

Para o item (b), tem-se:

![fluxograma_ex2b](https://github.com/user-attachments/assets/47e162be-e404-429b-901f-f0eb994fe6bf)

W. S. Zanco. Microcontroladores PIC18 com Linguagem C: Uma Abordagem Prática e Objetiva com base no PIC18F4520. São Paulo: Érica, 2010.
