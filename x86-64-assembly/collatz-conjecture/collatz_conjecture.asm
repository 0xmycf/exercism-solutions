section .text
global steps
; Provide your implementation here

; edi is the number were dividing etc
; esi is where we store the current count in

steps:
    cmp     edi, 0   ; compare to 0
    jle      .err
    xor     esi, esi ; zero rsi 

.loop:
    cmp     edi, 1 
    je      .end
    add     esi, 1
    test    edi, 1 ; stackoverflow check if lowest bit is set 
    je      .even
    jmp     .odd
.even:
    ; right shift
    sar     edi, 1
    jmp     .loop
.odd:
    imul    edi, 3
    add     edi, 1
    jmp     .loop
.end:
    mov     eax, esi ; move final value into return register
    ret
.err:
    mov     eax, -1
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
