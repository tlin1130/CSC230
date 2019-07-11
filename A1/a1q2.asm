;
; CSc 230 Assignment 1 
; Question 2
; Author: Jason Corless
 ; Modified: Sudhakar Ganti
 
; This program should calculate:
; R0 = R16 + R17
; if the sum of R16 and R17 is > 255 (ie. there was a carry)
; then R1 = 1, otherwise R1 = 0
;

;--*1 Do not change anything between here and the line starting with *--
.cseg
	ldi	r16, 0xF0
	ldi r17, 0x31
;*--1 Do not change anything above this line to the --*

;***
;---------------------------
;Question: What are we trying to do in this program? What is the
;meaning of if sum > 255 then set R1=1?
;Why did we say that if sum > 255 then there was a carry?
;Answer: We are trying to add the two numbers in R16 and R17 and then store
;the result in register 0. The register is 8-bit, so it only allows 256 combinations. 
;Therefore, the maximum number that can be stored is 255. If the sum is greater
;than 255, we need a to use anoter register to store the extra hex digit.
;---------------------------
; Your code goes here:
;
	adc r16,r17
	ldi r18, 0xC8
	ldi r19, 0x37
	adc r18,r19
	cpc r16,r18
	brsh higher

higher:    ldi r20, 0x01
           mov r0, r16
		   mov r1, r20   





;****
;--*2 Do not change anything between here and the line starting with *--
done:	jmp done
;*--2 Do not change anything above this line to the --*


