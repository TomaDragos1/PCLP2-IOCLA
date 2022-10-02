%include "../include/io.mac"

section .data
    letter db 0 
    cont_plain dd 0
    cont_key dd 0

section .text
    global beaufort
    extern printf

; void beaufort(int len_plain, char *plain, int len_key, char *key, char tabula_recta[26][26], char *enc) ;
beaufort:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; len_plain
    mov ebx, [ebp + 12] ; plain (address of first element in string)
    mov ecx, [ebp + 16] ; len_key
    mov edx, [ebp + 20] ; key (address of first element in matrix)
    mov edi, [ebp + 24] ; tabula_recta
    mov esi, [ebp + 28] ; enc
    
    ;; DO NOT MODIFY
    ;; TODO: Implement spiral encryption
    ;; FREESTYLE STARTS HERE
    
;;am facut niste contori pentru sirurile mele
    mov esi , 0
    mov [cont_plain], esi
    mov [cont_key], esi
    mov [letter], esi

while:
    xor eax, eax
    mov ebx , [ebp + 12]
    mov esi , [cont_plain]
    xor eax, eax
    ;;pastrez aici litera din plain
    mov al , byte[ebx + esi]
    push eax
    mov edi , [cont_key]
    xor edx, edx
    xor eax, eax
    mov eax, edi
    mov ebx , [ebp + 16]

    ;;impart contorului la lungimea cheie si iau restu
    ;;mereu imi trebuie restu pt a putea itera complet prin cheie
    div ebx
    mov [cont_key], edx
    mov edi , [ebp + 8]
    mov edx , [cont_plain]
    mov eax , [cont_key]
    xor ebx , ebx
    pop ebx ; litera plain in bl
    mov esi , [ebp + 20]
    xor ecx , ecx
    mov cl , [esi + eax] ;litera key in cl
    mov eax, ecx

    ;;scad din litera key litera plan
    ;;de aici fac algoritm pt program
    sub ecx, ebx
    jl negativ
    ;;daca nu e negativ doar ii adin cod ascii aa
    mov esi , [ebp + 28]
    mov edx , [cont_plain]
    add ecx, 'A'
    mov byte[esi + edx], cl

return:

    mov edi , [ebp + 8]
    mov edx , [cont_plain]
    mov eax , [cont_key]
    ;;se incrementeaza indicii
    inc eax
    mov [cont_key], eax
    inc edx
    mov [cont_plain], edx
    cmp edi , edx
    jnz while
jmp end

negativ:
;;daca e negatov ii adun 25 dupa cod ascii A
;;asta e formula pt matrice
    add ecx, 25
    add ecx , 'A'
    inc ecx
    mov esi , [ebp + 28]
    mov edx , [cont_plain]
    mov [esi + edx], cl
    jmp return

end:

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
