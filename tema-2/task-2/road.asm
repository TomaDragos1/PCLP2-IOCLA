%include "../include/io.mac"

struc point
    .x: resw 1
    .y: resw 1
endstruc

section .text
    global road
    extern printf

road:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]      ; points
    mov ecx, [ebp + 12]     ; len
    mov ebx, [ebp + 16]     ; distances
    ;; DO NOT MODIFY

    ;; Your code starts here
    xor esi, esi
    xor edi, edi
    xor edx, edx
    dec ecx
while:
    mov edx , [ebp + 8]
    xor eax, eax
    ;;fac ca la task 1 numai ca iterez prin vector
    mov ax , word[edx  + 4 * ecx - 4] 
    add ax , word[edx + 2 + 4 * ecx - 4]
    sub ax , word[edx + 4 + 4 * ecx - 4]
    sub ax , word[edx + 6 + 4 * ecx - 4]
    
    ;;fac exact la fel
    cmp ax, 0
    jg not_neg
    neg ax

not_neg:    
    mov ebx, [ebp + 16]
    ;;aici mut in vector de distante in functie de contor
    mov [ebx + 4 * ecx - 4] , eax
    dec ecx
    jne while

    ;; Your code ends here
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY