;
; CSc 230 Assignment 1 
; Question 1
; Author: Jason Corless
; Modified: Sudhakar Ganti

; This program should calculate:
; R0 = R16 + R17 + R18
;
;--*1 Do not change anything between here and the line starting with *--
.cseg
	ldi	r16, 0x30
	ldi r17, 0x31
	ldi r18, 0x32
;*--1 Do not change anything above this line to the --*

;***
;-------------------------
; Question: Why did we use r16 to r18? Can we use r0 to 15?
; Answer: The destination register number in the LDI instruction is
; specified by 4 bits, which only allows 16 combinations. Therefore,
; the instruction can only specify 16 different registers, r16 - r31.
;-------------------------
; Your code goes here:
;
	add r16, r17
	add r16, r18
	mov r0, r16

;****

;--*2 Do not change anything between here and the line starting with *--
done:	jmp done
;*--2 Do not change anything above this line to the --*


