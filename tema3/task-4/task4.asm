


section .text
	global cpu_manufact_id
	global features
	global l2_cache_info

	extern printf


;; void cpu_manufact_id(char *id_string);
;
;  reads the manufacturer id string from cpuid and stores it in id_string
cpu_manufact_id:
	enter 	0, 0
	push ebx
	push esi
	push edi
	;;am vazut ca aici trb facut
	mov eax, 0
	cpuid
	mov eax , [ebp + 8]
	;;pun id in vector
	mov [eax], ebx
	mov [eax + 4], edx	
	mov [eax + 8], ecx	
	pop edi
	pop esi
	pop ebx
	leave
	ret

;; void features(int *apic, int *rdrand, int *mpx, int *svm)
;
;  checks whether apic, rdrand and mpx / svm are supported by the CPU
;  MPX should be checked only for Intel CPUs; otherwise, the mpx variable
;  should have the value -1
;  SVM should be checked only for AMD CPUs; otherwise, the svm variable
;  should have the value -1
features:
	enter 	0, 0
	push ebx
	push esi
	push edi
	;;fac apel pt apic
	mov eax, 1
	cpuid
	;;iau bitii apic
	and edx , 0x00000100
	cmp edx, 0
	;;verific daca exista
	jne pun_1_apic
	mov edi, [ebp + 8]
	mov dword[edi], 0
	jmp end_apic

pun_1_apic:
	mov edi, [ebp + 8]
	mov dword[edi], 1

 end_apic:
	;;incep rdrand
	and ecx, 0x40000000
	cmp ecx, 0
	;;la fel si la apic
	jne pun_1_rdrand
	mov edi , [ebp + 12]
	mov dword[edi], 0
	jmp end_rdrand

pun_1_rdrand:
	mov edi , [ebp + 12]
	mov dword[edi], 1

end_rdrand:
	;;incep mpx
	mov eax, 0
	cpuid
	;;veirifc daca sunt pe intel
	cmp edx, 0x49656e69
	jnz pun_amd
	mov eax, 7
	cpuid
	and ebx, 0x00004000
	cmp ebx, 0
	jnz pun_1_mpx
	mov eax, dword[ebp + 16]
	;;daca nu pun 0 daca nu are mpx
	mov dword[eax], 0
	jmp end_mpx

pun_1_mpx:
	;;daca e ok pun 1
	mov eax, [ebp + 16]
	mov dword[eax], 1

pun_amd:
	;;daca nu pun -1 sunt pe amd
	mov eax, [ebp + 16]
	mov dword[eax], -1

end_mpx:
	;;la fel ca la mpx aici
	mov eax, 0
	cpuid
	cmp edx, 0x49656e69
	je pun_intel
	mov eax, 0x80000001
	cpuid
	;aici am shiftat si am pus valoarea direct 
	;nu am mai dat and ca prosut
	shr ecx, 2
	and ecx, 1
	mov edi, [ebp + 20]
	mov [edi], ecx
	jmp end_svm

pun_intel:
	;sunt pe intel
	mov eax, [ebp + 20]
	mov dword[eax], -1

end_svm:

	pop edi
	pop esi
	pop ebx
	leave
	ret

;; void l2_cache_info(int *line_size, int *cache_size)
;
;  reads from cpuid the cache line size, and total cache size for the current
;  cpu, and stores them in the corresponding parameters
l2_cache_info:
	enter 	0, 0
	;;am luat adresa si eax si l-am pus unde trebuie
	push ebx
	push esi
	push edi
	mov eax, 0x80000006
	cpuid
	and ecx, 0x000000FF
	mov ebx, [ebp + 8]
	mov [ebx], ecx

	pop edi
	pop esi
	pop ebx
	
	leave
	ret
