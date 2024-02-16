.686
.model flat
extern __write : PROC
public _dot_product
public _merge
.data
znaki db 'Blad'
tablica dd 32 dup (?)
.code

_merge PROC
		push ebp
		mov ebp, esp
		
		
		push esp
		push edi
		push esi
		push ebx
		
		
		mov edx, [ebp+8]
		mov ebx, [ebp+12]
		mov ecx, [ebp+16]

		cmp ecx, 32
		jg error

		mov esi, 0
ptl:   
	mov edi, [edx]
	mov dword ptr tablica[esi], edi
	add esi, 4
	
	mov edi, [ebx]
	mov dword ptr tablica[esi], edi
	add esi, 4

	add edx, 4
	add ebx, 4
	
	loop ptl
	mov eax, offset tablica
	jmp tutaj

error:
	mov eax, 0
	push dword ptr 4
	push offset znaki
	push dword ptr 1
	call __write
	add esp, 12

tutaj:
	pop ebx
	pop esi
	pop edi
	pop esp
	pop ebp
	ret


_merge ENDP









_dot_product PROC
		push ebp
		mov ebp, esp
		push ebx
		push esi
		push edi

		mov ecx, [ebp+16]
		
		mov edi, [ebp+12]
		mov esi, [ebp+8]
		mov ebx, 0

ptl: mov eax, [edi]
	 mov edx, [esi]

	 imul edx

	 add ebx, eax

	 add edi, 4
	 add esi, 4
	 loop ptl


	mov eax, ebx



		pop edi
		pop esi
		pop ebx
		pop ebp
		
		ret
_dot_product ENDP
 END
