;;; hw6_4_skel.asm
;;; D. Thiebaut, J. Macbeth
;;; compute ans = 4*(2*a+b+c) + 2*(c+1)


	        extern  _printDec
	        extern  _printString
	        extern  _println
	        extern  _getInput
	
		section	.data
prompt		db	"> "
promptLen	equ	$-prompt	
ansStr          db      "ans = "
ansStrLen	equ	$-ansStr	

a		dd	0
b		dd	0
c		dd	0
ans		dd	0
	
		section	.text
		global	_start
_start:
	;; display prompt
		mov	ecx, prompt
		mov	edx, promptLen
		call	_printString
	;; get a
		call	_getInput
		mov	dword[a], eax

	;; display prompt
		mov	ecx, prompt
		mov	edx, promptLen
		call	_printString
	;; get b
		call	_getInput
		mov	dword[b], eax
	
	;; display prompt
		mov	ecx, prompt
		mov	edx, promptLen
		call	_printString
	;; get c
		call	_getInput
		mov	dword[c], eax
	
;; -----------------------------------
;; computation: ans = 4*(a^2 + b^2) + c
;; -----------------------------------
	
	;; *** YOUR CODE GOES HERE *** 	

    mov eax, [a]
    mul eax         ; multiplies eax by itself, ie, a^2
    mov ebx, eax    ; stores a^2 in ebx
    
    mov eax, [b]
    mul eax         ; multiplies eax by itself, ie, b^2
    add ebx, eax    ; adds b^2 to a^2 in ebx
    
    mov eax, ebx    ; stores a^2 + b^2 in eax
    mov ebx, 4      ; stores 4 in ebx
    mul ebx         ; mults eax by 4: eax stores 4*(a^2 + b^2)
    
    add eax, [c]    ; adds c to eax
    mov [ans], eax
	
;; -----------------------------------
;; display "ans ="
;; -----------------------------------
		mov	ecx, ansStr
		mov	edx, ansStrLen
		call	_printString

;; -----------------------------------
;; display ans variable
;; -----------------------------------
		mov	eax, dword[ans]
		call	_printDec
		call	_println
		call	_println
	
;;; exit
		mov	ebx, 0
		mov	eax, 1
		int     0x80
