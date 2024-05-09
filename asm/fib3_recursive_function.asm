
global fib3

; int fib3(int n) {
;     if (n <= 0) {
;         return 0
;     }
;     if (n == 1 OR n == 2 OR n == 3) {
;         return 1
;     } else {
;         return fib3(n-1) + fib3(n-2) + fib3(n-3) ;
;     }
; }

fib3:                      ; fib3 returns val to eax, so don't save/restore it
    push    ebp             ; save base pointer
    mov     ebp, esp        ; establish new base pointer for this call
    push    ebx             ; save ebx
    push    ecx             ; save ecx
    push    edx             ; save edx
        ;; main function code here
        ;; access arguments using [ebp+8], [ebp+12], etc
    
    mov     ebx, [ebp+8]    ; ebx stores n
    
    ;; n <= 0
    mov     eax, 0          ; returns 0 if n <= 0
    cmp     ebx, 0          ; n <= 0?
    jle     end             ; jump over all other code and return 0
    
    ;; n == 1, 2, or 3
    mov     eax, 1          ; returns 1 if n <= 3
    cmp     ebx, 3          ; n <= 3? (we alr checked for n <= 0 case)
    jle     end
    
    ;; recursion
    dec     ebx             ; ebx stores n-1
    push    ebx             ; ebx is now a parameter for call _funct
    call    fib3            ; call f(n-1) answer is in eax; eax has f(n-1) in it
    mov     ecx, eax        ; ecx has f(n-1) in it
    
    dec     ebx
    push    ebx
    call    fib3
    add     ecx, eax        ; ecx has f(n-1) + f(n-2) in it
    
    dec     ebx
    push    ebx
    call    fib3
    add     ecx, eax        ; ecx has f(n-1) + f(n-2) + f(n-3) in it
    
    mov     eax, ecx        ; eax stores f(n-1) + f(n-2) + f(n-3) in it
        
        ;; end of main function code
end:
    pop     edx             ; restore edx
    pop     ecx             ; restore ecx
    pop     ebx             ; restore ebx
    pop     ebp             ; restore ebp
    ret     4               ; 4, since the function has one parameter
