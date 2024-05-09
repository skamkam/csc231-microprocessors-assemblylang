;;; hw7_3_chardec.asm
;;;                              
;;; To assemble, link, and run:  
;;;     nasm -f elf  hw7_3_prep.asm
;;;     ld -melf_i386 -o hw7_3_prep hw7_3_prep.o 231Lib.o
;;;     ./hw7_3_chardec
;;;      
	extern	_printString
	extern	_println
	extern	_getInput
	
        section .data
prompt  db      "> "	
x       dd      0
	
        section .text
        global  _start
_start:
;;; display prompt
	mov	eax, 4
	mov	ebx, 1
	mov	ecx, prompt
	mov	edx, 2
	int	0x80

;;; get 32-bit integer, as a decimal
	call	_getInput

;;; now int entered by user is in eax.  Save in x
	mov	dword[x], eax

;;; CODE STARTS HERE
;;; flip X lower 4 bits
;;; flip X+1 upper 4 bits
;;; flip X+2 middle 4 bits
;;; flip X+3 upper 2 and latter 2 bits
;;; NASM stores the last byte at x, the second-to-last byte at x+1, etc
;;; 0x44554F4C -> x: 0x4C, x+1: 0x4F, x+2: 0x55, x+3: 0x44
;;; 0xAABBCCDD -> x: 0xDD, x+1: 0xCC, x+2: 0xBB, x+3: 0xAA
;;; so when flipping the bits, rmr that in mem it goes x+3 -> x+2 -> x+1 -> x
;;; XOR with: 11000011 00111100 11110000 00001111 x+3 x+2 x+1 x
    xor eax, 0b11000011001111001111000000001111     ; rmr to tell nasm it's bin
    mov [x], eax

;;; display x as a string of 4 ascii chars
	mov	eax, 4
	mov	ebx, 1
	mov	ecx, x		; address of "string"
	mov	edx, 4		; number of chars: 1 int = 4 bytes
	int	0x80

	call	_println	; print a line-feed
	
;;; exit
        mov     ebx, 0
        mov     eax, 1
        int     0x80
