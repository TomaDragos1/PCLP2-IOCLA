%include "../include/io.mac"

section .text
    global spiral
    extern printf

section .data
    cont dd 0
    n_square dd 0
    line_up dd 0
    line_down dd 0
    col_left dd 0
    col_right dd 0
    i dd 0
    j dd 0

;; mai sus am declarat diferite variabile pe care le-am folosit pe parcurs
; void spiral(int N, char *plain, int key[N][N], char *enc_string);
spiral:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; N (size of key line)
    mov ebx, [ebp + 12] ; plain (address of first element in string)
    mov ecx, [ebp + 16] ; key (address of first element in matrix)
    mov edx, [ebp + 20] ; enc_string (address of first element in string)
    ;; DO NOT MODIFY
    ;; TODO: Implement spiral encryption
    ;; FREESTYLE STARTS HERE

    mov esi, [ebp + 8]
    dec esi
    mov edi , 0
    ;;contor cu care numar la ce poz ma aflu
    mov [cont], edi
    ;; n ^ 2
    mov [n_square], edi
    ;; tin minte linia si coloana pe care sunt
    ;;ficare, efectiv fac un fel de patrat si scad din coordonate
    ;;in functie de iteratie
    mov [line_up], edi
    mov [line_down], esi
    mov [col_left], edi
    mov [col_right], esi
    ;;doi contori
    mov [i], edi
    mov [j], edi
    mov eax , [ebp + 8]
    mov ebx , eax
    xor edx, edx
    mul ebx
    ;;am pus n ^ 2 in variabila globala
    mov [n_square], eax

while:
    ;; incrementaz i cu inceputul coloanei din dreapta
    mov ebx , [col_left]
    mov [i], ebx
    line1:
        ;; conditie de iesire din loop
        mov esi , [i] ;i
        ;;merg pana la coloana din dreapta pt a stii cand sa ma opresc
        ;;adica merg din stanga in dreapta
        mov edi , [col_right]
        inc edi
        cmp edi, esi
        jz next1

        ;;aici vreau sa imi iau elementul din matrice
        ;;formula pt el este line_up * n * 4 + i * 4
        ;;unde i este coloana pe care ma aflu
        mov edi , [ebp + 16]
        mov ebx, [line_up] ;linie
        mov eax , [ebp + 8] ;n
        xor edx, edx
        mul ebx ;; ebx are n * line_up
        add eax, esi
        mov edx , [edi + 4 * eax] ; element matrix

        ;;aici imi iau valoarea din vector cu ajorul lui cont
        ;;un contor care tine minte la ce pas sunt
        mov edi , [ebp + 12]
        mov ecx , [cont]
        xor eax, eax
        mov al , byte[edi + ecx]
        add eax, edx
        mov edi , [ebp + 20]
        ;;pune in sirul de raspunsuri enc_string
        mov [edi + ecx], al ; adunat in sir

        ;;aici doar incrementez i -ul cu care merg pe coloana
        ;;si cont pe a acutaliza pasul curent
        mov eax, [cont]
        mov ebx, [i]
        inc eax
        inc ebx
        mov [cont], eax
        mov [i], ebx
        jmp line1
    
next1:

;; pregatesc j pt a parcurge coloana din stanga de tot
;; ii dau adresa liniei de sus
    mov ebx , [line_up]
    inc ebx
    mov [j], ebx

    col1:
        ;; conditie de iesire din loop
        mov esi , [j]
        ;;merge de la linia de sus pana jos 
        mov edi , [line_down]
        inc edi
        cmp edi , esi
        jz next2

        ;;aici fac calculele pt a lua elementul din matrice
        ;;formula este j * n * 4 + col_right * 4
        mov edi , [ebp + 16]
        mov ebx, [j] ;
        mov eax , [ebp + 8]
        xor edx, edx
        mul ebx  ;;n * j
        mov esi , [col_right]
        add eax, esi
        mov edx , [edi + 4 * eax] ; element matrix

        ;;la fel ca mai sus bag in vectorul meu de char
        ;;litera criptata cu elementul din matrice
        mov edi , [ebp + 12]
        mov ecx , [cont]
        xor eax, eax
        mov al , byte[edi + ecx] ; litera
        add eax, edx
        mov edi , [ebp + 20]
        mov [edi + ecx], al ; mut in sir

        ;;incrementez cont si j
        mov eax, [cont]
        mov ebx, [j]
        inc eax
        inc ebx
        mov [cont], eax
        mov [j], ebx
        mov ebx , [j]
        jmp col1
    
next2:

    ;;incep din stanga jos a matricei
    mov ebx, [col_right]
    dec ebx
    jl end
    mov [i], ebx

    line2:
        ;;cond de iesire numai ca acum ma duc din stanga in dreapta
        ;;aidca trb sa scad
        mov esi , [i]
        mov edi , [col_left]
        inc esi
        cmp esi , edi
        jz next3

        ;;aici iau elementul din matrice
        ;;formula pt el este:  line_down * 4 * n + i
        mov esi , [i]
        mov edi , [ebp + 16]
        mov ebx, [line_down]
        mov eax , [ebp + 8]
        xor edx, edx
        mul ebx ;;aici e line_down * n
        add eax, esi
        mov edx , [edi + 4 * eax] ; element matrix

        ;;aici bag in sir de caractere
        mov edi , [ebp + 12]
        mov ecx , [cont]
        xor eax, eax
        mov al , byte[edi + ecx]
        add eax, edx
        mov edi , [ebp + 20]
        mov [edi + ecx], al ; adunat in sir

        ;;se acutalizeaza i si cont numai ca i se scade
        ;;pt ca merg in jos
        mov eax, [cont]
        mov ebx, [i]
        inc eax
        dec ebx
        mov [i], ebx
        mov [cont], eax
        mov [i], ebx
        mov ebx , [i]
        jmp line2
next3:

;;aici initializez cu linia de jos si
;;o sa ma duc in sus (utlima linia din stanga)   
    mov ebx, [line_down]
    dec ebx
    mov [j], ebx
    col2:
        ;;conditie de iesire
        mov esi , [j]
        mov edi , [line_up]
        inc edi
        cmp esi , edi
        jl next4

        ;;aici obtin adresa matricei
        ;;formula este: j * n * 4 + col_left
        mov esi , [col_left]
        mov edi , [ebp + 16]
        mov ebx, [j]
        mov eax , [ebp + 8]
        xor edx, edx
        mul ebx ; j * n
        add eax, esi 
        mov edx , [edi + 4 * eax] ; element matrix

        ;;aici bag in sir de caractere
        mov edi , [ebp + 12]
        mov ecx , [cont]
        xor eax, eax
        mov al , byte[edi + ecx]
        add eax, edx
        mov edi , [ebp + 20]
        mov [edi + ecx], al ; adunat in sir

        ;;incrementez j si cont
        mov eax, [cont]
        mov ebx, [j]
        inc eax
        dec ebx
        mov [j], ebx
        mov [cont], eax
        jmp col2

next4:

;;aici trb sa imi updatez toate variabilele mele
;;ca sa micsorez spirala
    mov eax, [line_up]
    mov ebx, [line_down]
    mov ecx, [col_left]
    mov edx , [col_right]
    inc eax
    dec ebx
    inc ecx
    dec edx
    mov [line_up], eax
    mov [line_down], ebx
    mov [col_left], ecx
    mov [col_right], edx

;;verificare pt cont si n ^ 2
    mov eax , [cont]
    mov ebx, [n_square]
    cmp eax, ebx
;;ca un while
    jnz while

end:
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
