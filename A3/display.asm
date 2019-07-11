#define LCD_LIBONLY
.include "lcd.asm"

.cseg 

	call lcd_init	;call lcd_init to initialize the lcd
	call lcd_clr
	call init_strings
	
	ldi r17, 0x00 

for:				;loop 3 times	
	cpi r17, 0x03
	brge end_for
	call display_strings	;print both messages
	ldi r20, 0x40
	call delay
	call delay
	call lcd_clr
	call delay
	call display1
	call delay
	call display2
	call delay 
	call display3
	call delay
	call display4
	call delay
	inc r17
	rjmp for 
end_for:
	call display5
	call delay
	call lcd_clr
	call delay
	rjmp end_for

init_strings:
	push r16
	; copy strings from program memory to data memory
	ldi r16, high(msg1)		; this the destination
	push r16
	ldi r16, low(msg1)
	push r16
	ldi r16, high(msg1_p << 1) ; this is the source
	push r16
	ldi r16, low(msg1_p << 1)
	push r16
	call str_init			; copy from program to data
	pop r16					; remove the parameters from the stack
	pop r16
	pop r16
	pop r16

	ldi r16, high(msg2)
	push r16
	ldi r16, low(msg2)
	push r16
	ldi r16, high(msg2_p << 1)
	push r16
	ldi r16, low(msg2_p << 1)
	push r16
	call str_init
	pop r16
	pop r16
	pop r16
	pop r16

	ldi r16, high(msg3)
	push r16
	ldi r16, low(msg3)
	push r16
	ldi r16, high(msg3_p << 1)
	push r16
	ldi r16, low(msg3_p << 1)
	push r16
	call str_init
	pop r16
	pop r16
	pop r16
	pop r16

	pop r16
	ret


display_strings:

	; This subroutine sets the position the next
	; character will be output on the lcd
	;
	; The first parameter pushed on the stack is the Y position
	; 
	; The second parameter pushed on the stack is the X position
	; 
	; This call moves the cursor to the top left (ie. 0,0)

	push r16

	call lcd_clr

	ldi r16, 0x00
	push r16
	ldi r16, 0x00
	push r16
	call lcd_gotoxy
	pop r16
	pop r16

	; Now display msg1 on the first line
	ldi r16, high(msg1)
	push r16
	ldi r16, low(msg1)
	push r16
	call lcd_puts
	pop r16
	pop r16

	; Now move the cursor to the second line (ie. 0,1)
	ldi r16, 0x01
	push r16
	ldi r16, 0x00
	push r16 
	call lcd_gotoxy
	pop r16
	pop r16

	; Now display msg2 on the second line
	ldi r16, high(msg2)
	push r16
	ldi r16, low(msg2)
	push r16
	call lcd_puts
	pop r16
	pop r16

	pop r16
	ret

display1:			;print "Han Wei Lin" at (0,0)

	push r16

	call lcd_clr

	ldi r16, 0x00
	push r16
	ldi r16, 0x00
	push r16
	call lcd_gotoxy
	pop r16
	pop r16

	
	ldi r16, high(msg1)
	push r16
	ldi r16, low(msg1)
	push r16
	call lcd_puts
	pop r16
	pop r16
	
	pop r16
	ret

display2:			;print "CSC230: Spring 2016"

	push r16

	call lcd_clr

	ldi r16, 0x00
	push r16
	ldi r16, 0x00
	push r16
	call lcd_gotoxy
	pop r16
	pop r16

	ldi r16, high(msg2)
	push r16
	ldi r16, low(msg2)
	push r16
	call lcd_puts
	pop r16
	pop r16

	pop r16
	ret

display3:			;print "Han Wei Lin" at (1,1)

	push r16

	call lcd_clr

	ldi r16, 0x01
	push r16
	ldi r16, 0x01
	push r16
	call lcd_gotoxy
	pop r16
	pop r16
 
 	ldi r16, high(msg1)
	push r16
	ldi r16, low(msg1)
	push r16
	call lcd_puts
	pop r16
	pop r16

	pop r16
	ret

display4:			;print "CSC230: Sping 2016" at (1,1)

	push r16

	call lcd_clr

	ldi r16, 0x01
	push r16
	ldi r16, 0x01
	push r16
	call lcd_gotoxy
	pop r16
	pop r16
 
 	ldi r16, high(msg2)
	push r16
	ldi r16, low(msg2)
	push r16
	call lcd_puts
	pop r16
	pop r16

	pop r16
	ret
	
display5:

	push r16

 	call lcd_clr

	ldi r16, 0x00
	push r16
	ldi r16, 0x07
	push r16
	call lcd_gotoxy
	pop r16
	pop r16

	ldi r16, high(msg3)
	push r16
	ldi r16, low(msg3)
	push r16
	call lcd_puts
	pop r16
	pop r16

	ldi r16, 0x01
	push r16
	ldi r16, 0x07
	push r16 
	call lcd_gotoxy
	pop r16
	pop r16

	ldi r16, high(msg3)
	push r16
	ldi r16, low(msg3)
	push r16
	call lcd_puts
	pop r16
	pop r16

	pop r16
	ret

; delay_1s
;
; set r20 before calling this function
; r20 = 0x40 is approximately 1 second delay
;
; registers used:
;	r20
;	r21
;	r22
;
delay:	
del1:	nop
		ldi r21,0x40
del2:	nop
		ldi r22, 0xFF
del3:	nop
		dec r22
		brne del3
		dec r21
		brne del2
		dec r20
		brne del1	
		ret

half_second_delay:
	ldi r21, 0x22
for2:
	ldi DREG, 0xF
	call dly_ms
	dec r21
	brne for2
	ret


;These are in program memory
msg1_p: .db "Han Wei Lin", 0
msg2_p: .db "CSC 230: Spring 2016", 0 
msg3_p:	.db "**", 0

.dseg 

; The program copies the strings from program memory into data memory 

msg1: .byte 200
msg2: .byte 200
msg3: .byte 200

line1: .byte 17
line2: .byte 17
line3: .byte 17
