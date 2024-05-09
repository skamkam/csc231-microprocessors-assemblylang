;;; hw8 change lowercase to uppercase
;;; Sarah Kam

	        extern  _printString
	        extern  _println
	        extern  _getString
	
		section	.data
prompt		db	"> "
promptLen	equ	$-prompt	
	
string      dd  0
strlen      dd  0

		section	.text
		global	_start
_start:
	;; display prompt
		mov	    ecx, prompt
		mov	    edx, promptLen
		call	_printString
		
	;; get user input
		call	_getString  ; address of first char in ecx, len of string in edx

;; -----------------------------------
;; change the string in place
;; -----------------------------------

    ;; set up loop
        mov     esi, ecx    ; make a copy of address for scanning
        mov     edi, ecx    ; another copy for printing at the end
        mov     ecx, edx    ; set up string length for loop
        
        cmp     ecx, 0
        je      end
        
    L1:
        mov     al, [esi]
        cmp     al, 'a'     ; compare val at str address w/ 'a'
        jl      checkPeriod ; if [eax] < a, not a letter
        cmp     al, 'z'     ; compare with 'z'
        jg      checkPeriod ; if [eax] > z, not a letter
        mov     ebx, 32
        sub     [esi], ebx  ; otherwise, subtract 32 from [eax]
        
    checkPeriod:
        cmp     al, '.'
        jne     nochange
        mov     ebx, 13     ; ascii for ! is 33, and 46-13 = 33
        sub     [esi], ebx
    
    nochange:
        inc     esi         ; move address along by 4 bytes
	    loop    L1

;; -----------------------------------
;; display output
;; -----------------------------------
        mov     ecx, edi    ; string address, edx still has strlen

		call    _printString
		call    _println
	
;;; exit
    end:
		mov	ebx, 0
		mov	eax, 1
		int     0x80
