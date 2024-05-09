;;; program_name.asm
;;; your name
;;; 
;;; a description of the program
;;;
;;; to assemble and run:
;;;
;;;     nasm -f elf -F  stabs program.asm
;;;     ld -melf_i386  -o program program.o
;;;     ./program
;;; -------------------------------------------------------------------

;%include files here...

 
        
      	;; ------------------------------------------------------------
	;; data areas
	;; ------------------------------------------------------------

	section	.data

	msg	db	"  ____ ____   ____   ____  _____ _", 10
		db	" / ___/ ___| / ___| |___ \|___ // |", 10
		db	"| |   \___ \| |       __) | |_ \| |", 10
		db	"| |___ ___) | |___   / __/ ___) | |", 10
		db	" \____|____/ \____| |_____|____/|_|", 10
	MSGLEN	equ	$-msg
        
	;; ------------------------------------------------------------
	;; code area
	;; ------------------------------------------------------------

	section	.text
	global	_start

_start:


        ;; (add your code here!!!!)
        
	mov	eax, 4
	mov	ebx, 1
	mov	ecx, msg

	mov	edx, MSGLEN
	int	0x80
        

	;; exit()

	mov	eax,1
	mov	ebx,0
	int	0x80		; final system call
