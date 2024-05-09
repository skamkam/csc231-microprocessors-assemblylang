;;; Sarah Kam
;;; CSC231 Assgt 7 Modified Fibonacci


	        extern  _printDec
	        extern  _printString
	        extern  _println
	        extern  _getInput
	
		section	.data
prompt		db	"> "
promptLen	equ	$-prompt	

x		dd	0
a       dd  1
b       dd  1
c       dd  1
d       dd  1
	
		section	.text
		global	_start
_start:
	;; display prompt
		mov	ecx, prompt
		mov	edx, promptLen
		call	_printString
	;; get a
		call	_getInput
		mov	dword[x], eax
	
;; -----------------------------------
;; computation: f(1) = 1, f(2) = 1, f(3) = 1;
;;              f(n) = f(n-1) + f(n-2) + f(n-3) if n > 3
;; -----------------------------------
        
        ; base case: n = 3
        ; initalized all of [a], [b], [c], [d] as = 1
        
        mov ecx, [x]        ; stores value of index at ecx
        sub ecx, 3          ; iterates minus the first 3 steps
L1:     mov eax, ecx        ; loop uses ecx as counter

        ; Organization:
        ; [a] = Fn
        ; [b] = Fn-1
        ; [c] = Fn-2
        ; [d] = Fn-3
        
        ; next case: n = 4
        ; each iteration, shift things over: move Fn to Fn-1 register, etc
        mov eax, [c]        ; eax stores [c] which was Fn-2
        mov [d], eax        ; [d] now stores old Fn-2, now Fn-3
        mov eax, [b]
        mov [c], eax
        mov eax, [a]
        mov [b], eax        ; now [d] stores Fn-3, [c] stores Fn-2, [b] stores Fn-1
                            ; note eax is currently storing [b] value
        add eax, [c]
        add eax, [d]        ; now eax is storing [b]+[c]+[d]
        mov [a], eax        ; [a] stores [b]+[c]+[d] aka Fn-1 + Fn-2 + Fn-3
        
        loop L1
	
;; -----------------------------------
;; display ans variable when loop ends
;; -----------------------------------
		mov	eax, dword[a]
		call	_printDec
		call	_println
	
;;; exit
		mov	ebx, 0
		mov	eax, 1
		int     0x80
