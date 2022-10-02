%include "../include/io.mac"

struc point
    .x: resw 1
    .y: resw 1
endstruc

section .text
    global points_distance
    extern printf

points_distance:
    ;; DO NOT MODIFY
    
    push ebp
    mov ebp, esp
    pusha

    mov ebx, [ebp + 8]      ; points
    mov eax, [ebp + 12]     ; distance
    ;; DO NOT MODIFY
   
    ;; Your code starts here

    xor esi, esi
    xor edi, edi
    ;;adun si scad coordonatele
    mov ax , word[ebx]
    add ax , word[ebx + 2]
    sub ax , word[ebx + 4]
    sub ax , word[ebx + 6]
    ;;compar cu zero
    cmp ax , 0
    jg not_neg
    
    ;;fac absolut aici de fapt
    neg ax
not_neg:
    ;;mut la adresa mea
    mov ebx, [ebp + 12]
    mov [ebx], ax


    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret

    ;; DO NOT MODIFY