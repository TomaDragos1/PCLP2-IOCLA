section .text
	global cmmmc

;; int cmmmc(int a, int b)
;
;; calculate least common multiple fow 2 numbers, a and b
cmmmc:

	push ebx
	push esi
	push edi
	xor ecx, ecx
	xor ebx, ebx
	;;salvez cele doua numere
	push eax
	pop ecx
	push edx
	pop ebx
	;;cmmdc cu metoda scaderii repetate
while:
	cmp eax, edx
	je end
	cmp eax, edx
	jg schimb
	;;a - b
	sub edx, eax
back:
	jmp while

jmp end

;;fac sub b-a
schimb:
	sub eax, edx
	jmp back

end:

	xor edx, edx
	push eax
	push ecx
	pop eax
	;;fac inmultirea a * b
	mul ebx
	xor edx, edx
	pop ebx
	;;(a * b) / cmmdc(a,b)
	div ebx

	pop edi
	pop esi
	pop ebx
	ret
