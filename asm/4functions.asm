;;; ------------------------------------------------------
;;; funcs.asm
;;; Sarah Kam
;;; Add your documentation here
;;; ------------------------------------------------------
global f1, f2, f3, f4

f1:     ;; takes in a string & turns all lowercase to uppercase
        push    ebp             ; save base pointer
        mov     ebp, esp        ; establish new base pointer for this call
        push    eax             ; save eax
        push    ebx             ; save ebx
        push    ecx             ; save ecx
        push    edx             ; save edx
        ;; main function code here
        ;; access arguments using [ebp+8], [ebp+12], etc
        
        mov     ecx, [ebp+8]    ; strlen
        mov     esi, [ebp+12]   ; str address
        
        cmp     ecx, 0          ; check if strlen = 0
        je      endf1
        
    stringloop:
        mov     al, [esi]
        cmp     al, 'a'         ; compare letter at [esi] w/ 'a'
        jl      nochange
        cmp     al, 'z'
        jg      nochange

        mov     ebx, 32
        sub     [esi], ebx      ; this works w/o jumps
        
        nochange:
        inc     esi             ; increment along string
        loop    stringloop
        
    endf1:
        ;; end main function code
        pop     edx             ; restore edx
        pop     ecx             ; restore ecx
        pop     ebx             ; restore ebx
        pop     eax             ; restore eax
        pop     ebp             ; restore ebp
        ret     8               ; 4, since the function has one parameter

f2:     ;; 4*(a + b) + 3*c, return in eax
        push    ebp             ; save base pointer
        mov     ebp, esp        ; establish new base pointer for this call
        push    ebx             ; save ebx
        push    ecx             ; save ecx
        push    edx             ; save edx
        ;; main function code here
        ;; access arguments using [ebp+8], [ebp+12], etc
        
        mov     eax, [ebp+16]   ; eax stores a. NOTE: a is pushed 1st, so it's 3rd place away, hence ebp+16
        add     eax, [ebp+12]   ; eax stores a + b
        add     eax, eax        ; eax stores 2*(a + b)
        add     eax, eax        ; eax stores 4*(a + b)
        
        add     eax, [ebp+8]
        add     eax, [ebp+8]
        add     eax, [ebp+8]    ; eax stores 4*(a + b) + 3*c
        
        ;; end function code
        pop     edx             ; restore edx
        pop     ecx             ; restore ecx
        pop     ebx             ; restore ebx
        pop     ebp             ; restore ebp
        ret     12

f3:     ;; takes in array & arraylen and counts how many neg nums in array
        push    ebp             ; save base pointer
        mov     ebp, esp        ; establish new base pointer for this call
        push    ebx             ; save ebx
        push    ecx             ; save ecx
        push    edx             ; save edx
        ;; main function code here
        ;; access arguments using [ebp+8], [ebp+12], etc
        
        mov     eax, 0          ; starts with 0 negative nums
        mov     ebx, [ebp+12]   ; ebx stores array address which was pushed after arrayLen
        mov     ecx, [ebp+8]    ; ecx stores arrayLen
        
        cmp     ecx, 0          ; make sure arrayLen =/= 0
        je      endf3
        
    countNeg:
        mov     edx, 0
        cmp     [ebx], edx      ; [ebx] compare 0
        jge     nonNeg          ; if [ebx] >= 0, skip counter
        inc     eax             ; otherwise, if int at address ebx < 0, eax++
    nonNeg:
        add     ebx, 4          ; move along array
        loop    countNeg
        
    endf3:      ;; end main function code
        pop     edx             ; restore edx
        pop     ecx             ; restore ecx
        pop     ebx             ; restore ebx
        pop     ebp             ; restore ebp
        ret     8               ; 8, since the function has two parameters

f4:     ;; takes in 3 numbers and returns the smallest one in eax
        push    ebp             ; save base pointer
        mov     ebp, esp        ; establish new base pointer for this call
        push    ebx
        push    ecx
        push    edx
        ;; access arguments using [ebp+8], [ebp+12], etc
    ;;--------------------------------
    ;; main function code starts here
    ;;--------------------------------
    
    ;; f4(a, b, c)
    ;; if ever find a smaller integer, move it into eax
    ;; pushes a, then b, then c; so a is ebp+16, b is ebp+12, c is ebp+8
        mov     eax, [ebp+16]       ; a is current_smallest
        cmp     eax, [ebp+12]       ; compare a to b
        jl      L1                  ; if a < b, then we jump to compare a and c;
        mov     eax, [ebp+12]       ; else make b current_smallest; skips this code if a < b
    
    L1:
        cmp     eax, [ebp+8]        ; compare (a or b) with c
        jl      L2                  ; if (a or b) < c, jump to L2 and don't change current smallest
        mov     eax, [ebp+8]        ; else make c current_smallest; skips this code if (a or b) < c
        
    L2:
        pop     edx
        pop     ecx
        pop     ebx
        pop     ebp                 ; restore ebp
        ret     12                  ; 12, since function has 3 parameters

