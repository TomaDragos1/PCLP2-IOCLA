%include "../include/io.mac"

section .text
    global is_square
    extern printf

is_square:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov ebx, [ebp + 8]      ; dist
    mov eax, [ebp + 12]     ; nr
    mov ecx, [ebp + 16]     ; sq
    ;; DO NOT MODIFY
   
    ;; Your code starts here

xor esi , esi
xor edi, edi

while:
    xor edi , edi
    xor edx, edx
    ;; iau distanta mea aici
    mov edi , dword[ebx + eax * 4 - 4]
    push eax
    xor esi ,esi
    ;;asta e un contor cu care caluculez patratul meu dorit
    mov esi , -1

    ;;functie un calculez daca e patrat perfect
sqrt:
    xor edx, edx
    inc esi
    mov eax , esi
    mul esi
    cmp edi , eax ;;in caz ca contor e mai mic decat numarul meu
    jg sqrt
    ;;daca merge sub 0 inseamna ca am trecut de el si nu e patrat perfect
    cmp edi , eax
    jl init_zero
    ;;daca e zero l-am gasit ca e patrat perfect
    cmp edi, eax
    jz init_one

    ;;incrementez
return:
    dec eax ;;contor pt patrat perfect
    jnz while

jmp end

;;aici fac initializarile in vectorul meu cu 1 si 0
init_zero:
    pop eax
    mov dword[ecx + eax * 4 - 4], 0
    jmp return

init_one:
    pop eax
    mov dword[ecx + eax * 4 - 4], 1
    jmp return    

end:
    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY