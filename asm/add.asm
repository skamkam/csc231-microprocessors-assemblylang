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
;; computation: ans =  4*(2*a+b+c) + 2*(c+1) 
;; -----------------------------------
	
        mov eax, 0
        mov ebx, 0
        add eax, dword[a]       ;; adds a to eax
        add eax, dword[a]       ;; adds another a to eax - now eax = 2a
        add eax, dword[b]       ;; eax = 2a+b
        add eax, dword[c]       ;; eax = 2a+b+c
        add ebx, eax            ;; ebx = eax = 2a+b+c
        add ebx, eax            ;; ebx = 2eax = 2(2a+b+c)
        add ebx, eax
        add ebx, eax            ;; ebx = 4eax = 4(2a+b+c)
    
    ;; increment c' = c++
        inc dword[c]
    ;; add c" = c' + c'
        mov eax, 0
        add eax, dword[c]       ;; eax = c+1
        add eax, dword[c]       ;; eax = 2(c+1)
    
    ;; final addition: add dword[a] and dword[c] to ans
        add dword[ans], ebx
        add dword[ans], eax
	
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
