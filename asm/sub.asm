;;; sub_skel.asm
;;; D. Thiebaut, J. Macbeth
;;; 

	
	        extern  _printDec
		extern  _printInt
	        extern  _printString
	        extern  _println
	        extern  _getInput
	
		section	.data
prompt		db	"> "
promptLen	equ	$-prompt	
ansStr          db      "ans = "
ansStrLen	equ	$-ansStr	

;;; declare 5 16-bit short ints
x		dw	1       ; leave these values in
y		dw	2	; the different variables.
z		dw	3	; Moodle will use this to
t		dw	4	; verify that you haven't
ans		dw	5	; modified the original data
				; segment
	
		section	.text
		global	_start
_start:
	;; display prompt
		mov	ecx, prompt
		mov	edx, promptLen
		call	_printString
	;; get x
		call	_getInput
		mov	word[x], ax

	;; display prompt
		mov	ecx, prompt
		mov	edx, promptLen
		call	_printString
	;; get y
		call	_getInput
		mov	word[y], ax
	
	;; display prompt
		mov	ecx, prompt
		mov	edx, promptLen
		call	_printString
	;; get z
		call	_getInput
		mov	word[z], ax

	;; display prompt
		mov	ecx, prompt
		mov	edx, promptLen
		call	_printString
	;; get t
		call	_getInput
		mov	word[t], ax
	
;; -----------------------------------
;; computation: ans = 3*((t-1)+2*(y-t)) - 3*(x-10)  
;; -----------------------------------
        
        mov ax, word[y]        ;eax stores y
        sub ax, word[t]        ;eax stores y-t
        mov word[y], ax        ;word[y] stores y-t
        add word[y], ax        ;word[y] stores 2(y-t)
        
        sub word[t], 1          ;word[t] stores t-1
        
        sub word[x], 10         ;word[x] stores x-10
        mov ax, word[x]        ;eax stores x-10
        add word[x], ax        ;word[x] stores 2(x-10)
        add word[x], ax        ;word[x] stores 3(x-10)
        
        mov ax, word[t]        ;eax stores t-1
        add ax, word[y]        ;eax stores t-1 + 2(y-t)
        mov bx, ax            ;ebx stores ((t-1)+2(y-t))
        add bx, ax            ;ebx stores 2((t-1)+2(y-t))
        add bx, ax            ;ebx stores 3((t-1)+2(y-t))
        
        sub bx, word[x]        ;ebx stores 3((t-1)+2(y-t)) - 3(x-10)
        
        mov word[ans], bx      ;word[ans] stores 3((t-1)+2(y-t)) - 3(x-10)
	
;; -----------------------------------
;; display "ans = "
;; -----------------------------------
		mov	ecx, ansStr
		mov	edx, ansStrLen
		call	_printString

;; -----------------------------------
;; display ans variable
;; -----------------------------------
		mov	eax, 0
		mov	ax, word[ans]
		call	_printInt
		call	_println
		call	_println
	
;;; exit
		mov	ebx, 0
		mov	eax, 1
		int     0x80
