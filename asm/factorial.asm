
global fact

; int fact(int n) {
;     if (n == 1) {
;         return 1
;     } else {
;         return n * fact(n-1) ;
;     }
; }

fact:                      ; _fact returns val to eax, so don't save/restore it
    push    ebp             ; save base pointer
    mov     ebp, esp        ; establish new base pointer for this call
    push    ebx             ; save ebx
    push    ecx             ; save ecx
    push    edx             ; save edx
        ;; main function code here
        ;; access arguments using [ebp+8], [ebp+12], etc
    
    ;; base
    mov     eax, 1          ; by default the function returns 1
    mov     ebx, [ebp+8]    ; ebx stores n
    cmp     ebx, 1          ; n == 1?
    je      end             ; jump over stuff we don't want to execute (recursion code) and go to the end
    
    ;; recursion
    dec     ebx             ; ebx stores n-1
    push    ebx             ; ebx is now a parameter for call _funct
    call    fact           ; call f(n-1) answer is in eax; eax has f(n-1) in it
    mul     dword[ebp+8]    ; calculate f(n-1) * n, store to eax
        
        ;; end of main function code
end:
    pop     edx             ; restore edx
    pop     ecx             ; restore ecx
    pop     ebx             ; restore ebx
    pop     ebp             ; restore ebp
    ret     4               ; 4, since the function has one parameter
        





