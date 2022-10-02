%include "../include/io.mac"

section .text
    global simple
    extern printf

simple:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

    ;; DO NOT MODIFY
   
    ;; Your code starts here


while:
    xor eax, eax
    mov al , byte[esi + ecx - 1]
    sub al, 'A'
    add al, dl
    mov bl , 26
    xor ah, ah
    ;;impart pozitia din alfabet a lui A
    ;; la numarul de litere
    ;;iau doar restu
    div bl
    mov al , ah
    add al , 'A'
    ;;mut val criptata la adresa buna
    mov byte[edi + ecx - 1], al
    sub ecx, 1
    jnz while
    ;; Your code ends here


    ;; DO NOT MODIFY
    popa
    leave
    ret
    
    ;; DO NOT MODIFY
