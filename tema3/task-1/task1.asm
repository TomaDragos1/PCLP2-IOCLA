
section .data
	contor: dd 0
	first_element: dd 0

section .text
	global sort

; struct node {
;     	int val;
;    	struct node* next;
; };

;; struct node* sort(int n, struct node* node);
; 	The function will link the nodes in the array
;	in ascending order and will return the address
;	of the new found head of the list
; @params:
;	n -> the number of nodes in the array
;	node -> a pointer to the beginning in the array
; @returns:
;	the address of the head of the sorted list
sort:
	enter 0, 0
	push ebx
	push esi
	push edi
	;iau cele 2 numere
	mov ebx , [ebp + 12]
	mov ecx, [ebp + 8]
	mov esi , 1
	;primul for unde vad unde e primu element
	xor edi, edi
for1:
	mov eax , [ebx]
	inc edi
	add ebx, 8
	;gasesc element
	cmp esi ,eax
	jne for1

	sub ebx , 8
	mov eax , ebx
	;;salvez primul element
	mov [first_element], eax
	push eax
	xor eax, eax
	;fac contor 2
	mov eax, [contor]
	add eax , 2
	mov [contor], eax
	while:
		;primul loop
		mov ebx, [ebp + 12]

		for2:
			mov esi, [contor]
			mov eax , [ebx]
			add ebx, 8
			;caut element urmator
			cmp eax, esi
			jne for2

	sub ebx , 8
	mov eax, ebx
	;iau elementul trecut din stiva
	pop ecx
	;;i pun adresa la urmator
	mov [ecx + 4], eax
	;;pun inapoi in stiva elementul curent
	push eax

	;;incrementez contor
	mov eax, [contor]
	inc eax
	mov ebx , [ebp + 8]
	inc ebx
	;;conditie de iesire
	mov [contor], eax
	cmp eax, ebx
	jne while

	pop ebx
	;;ii dau adresa la primul element
	mov eax, [first_element]

	pop edi
	pop esi
	pop ebx
	leave
	ret
