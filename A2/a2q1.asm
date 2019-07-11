;
; a2q1.asm
;
; Write a program that displays the binary value in r16
; on the LEDs.
;
; See the assignment PDF for details on the pin numbers and ports.
;
;
;
; These definitions allow you to communicate with
; PORTB and PORTL using the LDS and STS instructions
;
.equ DDRB=0x24
.equ PORTB=0x25
.equ DDRL=0x10A
.equ PORTL=0x10B



		ldi r16, 0xFF
		sts DDRB, r16		; PORTB all output
		sts DDRL, r16		; PORTL all output

		ldi r16, 0x33		; display the value
		mov r0, r16			; in r0 on the LEDs

; Your code here
.def result=r18
.def temp=r17

		;Examine bits for PortB
		ldi result, 0x00
		mov temp, r0
		andi temp, 0x20		;mask with 00100000(for pin 52)
        cpi temp, 0x20 
		breq pin52 
next1:
		mov temp, r0
		andi temp, 0x10		;mask with 00001000(for pin 50)	       
		cpi temp, 0x10
		breq pin50		
next2:	
		sts PORTB, result
		
		;Examine bits for PortL
		ldi result,0x00
		mov temp, r0 
		andi temp, 0x08	
		cpi temp, 0x08		;mask with 00001000(for pin48)
		breq pin48
next3:
		mov temp, r0		
		andi temp, 0x04		;mask with 00000100(for pin46)
		cpi temp, 0x04
		breq pin46
next4:
		mov temp, r0	
		andi temp, 0x02
		cpi temp, 0x02
		breq pin44
next5:
		mov temp, r0
		andi temp, 0x01 
		cpi temp, 0x01
		breq pin42
next6:
		sts PORTL, result

		rjmp done


pin52:
		ori result, 0x02
		rjmp next1		
pin50:
		ori result, 0x08
		rjmp next2		
pin48:
		ori result, 0x02
		rjmp next3
pin46:
		ori result, 0x08
		rjmp next4
pin44: 
		ori result, 0x20
		rjmp next5
pin42:
		ori result, 0x80	
		rjmp next6


;
; Don't change anything below here
;
done:	jmp done
