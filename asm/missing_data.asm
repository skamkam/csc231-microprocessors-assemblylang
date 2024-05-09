;;; ; missing_data.asm
;;; ; your name(s) here
;;; ;
;;; ; add a description of the program here
;;; ;
;;; ; to assemble and run:
;;; ;
;;; ; nasm -f elf missing_data.asm
;;; ; ld -melf_i386 -o missing_data missing_data.o
;;; ; ./missing_data
;;; ; -------------------------------------------------------------------
;;; ------------------------------------------------------------
;;; data areas
;;; ------------------------------------------------------------
section .data
;;; ENTER YOUR STRING(S) HERE!!!

    ;;; the char for message+27 is actually not used; can be anything
    ;;; ie, "...likemilk!", 10; "...likemilk", 10, 10
    message     db      " chocolateIwithnutslikemilk ", 10


;;; ------------------------------------------------------------
;;; code area
;;; ------------------------------------------------------------
        section .text
        global _start
_start:
;;; print "I"
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, message+10
    mov     edx, 1
    int     0x80
;;; print " "
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, message
    mov     edx, 1
    int     0x80
;;; print "like"
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, message+19
    mov     edx, 4
    int     0x80
;;; print " " (space)
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, message
    mov     edx, 1
    int     0x80
;;; print "milk"
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, message+23
    mov     edx, 4
    int     0x80
;;; print " " (space)
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, message
    mov     edx, 1
    int     0x80
;;; print "chocolate"
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, message+1
    mov     edx, 9
    int     0x80
;;; print " " (space)
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, message
    mov     edx, 1
    int     0x80
;;; print "with"
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, message+11
    mov     edx, 4
    int     0x80
;;; print " " (space)
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, message
    mov     edx, 1
    int     0x80
;;; print "nuts"
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, message+15
    mov     edx, 4
    int     0x80
;;; print a final newline character
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, message+28
    mov     edx, 1
    int     0x80

;;; exit()
    mov     eax,1
    mov     ebx,0
    int     0x80 ; final system call
