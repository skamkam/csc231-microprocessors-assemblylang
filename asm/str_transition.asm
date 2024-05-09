;;; hw8 change lowercase to uppercase
;;; Sarah Kam

	        extern  _printString
	        extern  _println
	        extern  _getString
	
		section	.data
prompt		db	"> "
promptLen	equ	$-prompt	
	
string      db  0
strlen      db  0

		section	.text
		global	_start
_start:
	;; display prompt
		mov	ecx, prompt
		mov	edx, promptLen
		call	_printString
		
	;; get user input
		call	_getString ; address of first char in ecx, len of string in edx
		mov [string], ecx
		mov [strlen], edx
		
		mov eax, [string]        ; address of first character is in eax
		mov ecx, [strlen]        ; len of string is in ecx so L1 can loop
	
	L1: mov al, [eax]       ; byte at address eax
	    call _lowerToUpper
	    call _periodToExcl
	    inc eax
	    loop L1
	    
	    ; ascii a-z lowercase are 97 to 122 inclusive
	_lowerToUpper:
    	;cmp al, 97
    	;jl  quit            ; if it's less than ascii for a, quit
    	;cmp al, 122
    	;jg  quit            ; if it's greater than ascii for z, quit
    	sub al, 32         ; otherwise, subtract 32 from ascii code
    	ret
	
        ; ascii period is 46, exclamation mark is 33
	_periodToExcl:
	    ;cmp al, 46
	    ;jne quit
	    sub al, 13
	    ret
	
    quit:                   ; define quit code here
        ret
	
;; -----------------------------------
;; display output
;; -----------------------------------

		mov ecx, [string]
		mov edx, [strlen]
		call _printString
	
;;; exit
		mov	ebx, 0
		mov	eax, 1
		int     0x80
