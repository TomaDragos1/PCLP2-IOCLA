global get_words
global compare_func
global sort
global cmp

section .data
    vector db 0
    strlen1 dd 0
    strlen2 dd 0

section .text

extern strtok
extern strcmp
extern strlen
extern qsort
extern malloc
extern strcpy
extern free

;; sort(char **words, int number_of_words, int size)
;  functia va trebui sa apeleze qsort pentru soratrea cuvintelor 
;  dupa lungime si apoi lexicografix
cmp:
    enter 0, 0
    mov ecx, dword[ebp + 8]
    mov ecx , dword[ecx]

    ;;strlen primul cuvant
    push ecx
    call strlen
    add esp, 4
    mov dword[strlen1], eax
    mov ecx, dword[ebp + 12]
    mov ecx , dword[ecx]
    push ecx
    ;;strlen al doile cuvant
    call strlen
    add esp, 4
    mov dword[strlen2], eax

    mov edx , [strlen1]
    mov ecx, [strlen2]
    sub edx, ecx
    mov eax, edx
    ;;compar cele 2 strlen
    ;;daca dif de ele este != 0 atunci returnez valoare
    cmp eax, 0
    jne end2
    ;;pt cazul de egalitate dereferentiez de 2 ori
    ;;is fac strcmp
    mov edx, dword[ebp + 8]
    mov ecx, dword[ebp + 12]
    mov edx, dword[edx]
    mov ecx, dword[ecx]
    push ecx
    push edx
    call strcmp

end2:
    leave
    ret

sort:
    enter 0, 0
    push ebx
	push esi
	push edi
    ;;iau toti parametrii ce imi trb
    ;;pt qsort
    mov ebx, dword[ebp + 16] ;size
    mov edi, dword[ebp + 12]    ;len
    mov esi, dword[ebp + 8] ;sir
    push cmp
    ;;functie cmp
    push ebx
    push edi
    push esi
    call qsort
    add esp, 16
    pop edi
    pop esi
    pop ebx
    leave
    ret

;; get_words(char *s, char **words, int number_of_words)
;  separa stringul s in cuvinte si salveaza cuvintele in words
;  number_of_words reprezinta numarul de cuvinte
get_words:
    enter 0, 0
    push ebx
	push esi
	push edi
    mov eax, 5
    push eax
    call malloc
    add esp, 4
    mov [vector], eax
    ;;vector alocat dinamic in care imi bag separatorii
    mov eax , [vector]
    mov byte[eax], ' '
    mov byte[eax + 1], '.'
    mov byte[eax + 2], ','
    mov byte[eax + 3], 10
    mov byte[eax + 4], 0
    mov [vector], eax
    mov ebx , [vector]
    mov ecx , [ebp + 8]
    
    push ebx
    push ecx
    ;;apelez strtok pt primul caz ca si in c
    call strtok
    add esp, 8
    mov ecx , [ebp + 12]
    mov [ecx], eax
    xor esi ,esi
    mov esi , 1

while:
    ;;aici fac strtok in loop
    mov eax , [ebp + 16]
    cmp eax , esi
    ;;cond iesire
    je end
    xor eax, eax
    mov ebx , [vector]
    mov ecx , 0
    push esi
    ;;aici parametrii strtok
    ;;null + vector de separatori
    push ebx
    push ecx
    call strtok
    add esp, 8
    pop esi
    mov ecx , [ebp + 12]
    ;;mut pointer la cuvant in vector word
    mov [ecx + 4 * esi], eax
    inc esi
    jmp while
end:
    ;free la memorie
    mov eax, [vector]
    push eax
    call free
    pop edi
    pop esi
    pop ebx
    leave
    ret
