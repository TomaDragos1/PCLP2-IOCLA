section .text
	global par

;; int par(int str_length, char* str)
;
; check for balanced brackets in an expression
par:
	;;eax paranteze
	;;edx nr paranteze
	push ebx
	push esi
	push edi
	xor ebx, ebx
	xor esi, esi
	xor ecx, ecx
	;;am decrementat lungiea tot
	dec ebx
	dec edx
while:
	;conditie iesire
	cmp edx , ebx
	je bag_1
	inc ebx
	push dword[eax + ebx]
	;;iau cate 4 octeti cu paranteze 
	pop ecx
	and ecx, 255
	;;iau ultimu octet pe care se aflta parantez
	;;caz (
	cmp ecx , 40
	je adun1
	;scad la suma
	dec esi
	jmp sar

adun1:
	;aduna la suma
	inc esi
	
sar:
	;;vad daca suma e negativa
	;;daca da ies din while
	cmp esi, 0
	jl bag_0
	jmp while

bag_1:
	;;bag 1 daca e zero suma
	cmp esi, 0
	;;daca nu bag 0
	jne bag_0
	xor eax, eax
	inc eax
	jmp end

bag_0:
	xor eax, eax
	jmp end

end:

pop edi
pop esi
pop ebx
	ret