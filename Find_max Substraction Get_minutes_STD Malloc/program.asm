.686
.model flat
extern __write : PROC
extern _GetSystemTime@4 : PROC
extern _malloc : PROC
public _dot_product
public _merge
public _szukaj_elem_max
public _odejmowanie
public _get_minuty
public _funkcja
.data
znaki db 'Blad'
tablica dd 32 dup (?)
trzy dd 3
.code


_funkcja PROC
		push ebp
		mov ebp, esp
		push ebx
		push edi
		push esi

		mov ebx, 0 ; h
		mov edx, 4 ; sizeof(int)
		mov eax, [ebp+8] ; e
		imul edx
		push eax
		call _malloc
		add esp, 4
		; byc moze trzeba tutaj wyregulowac stos
		cmp eax, 0
		je blad
		mov ecx, [ebp+8] ; e
		mov esi, 0
		mov edi, eax

ptl:
		mov eax, ebx
		imul trzy
		dec eax
		mov [edi][esi], eax

		add esi, 4
		inc ebx
		
		loop ptl
		mov eax, edi
		jmp koniec



blad:
		push dword ptr 4
		push offset znaki
		push dword ptr 1
		call __write
		add esp, 12
koniec:
		pop esi
		pop edi
		pop ebx
		pop ebp
		ret
		
_funkcja ENDP






_get_minuty PROC
		push ebp
		mov ebp, esp
		push ebx

		sub esp, 16
		mov ebx, esp ; adres poczatka struktury

		push ebx
		call _GetSystemTime@4

		mov ax, [ebx+10]
		movzx eax, ax
		add esp, 16
		pop ebx
		pop ebp
		ret

_get_minuty ENDP


_odejmowanie PROC
		push ebp
		mov ebp, esp
		push ebx
		push edi
		push esi

		mov edx, [ebp+8]
		mov ecx, [edx]
		mov ebx, [ecx]

		mov edx, [ebp+12]
		mov eax, [edx]

		sub eax, ebx




		pop esi
		pop edi
		pop ebx
		pop ebp
		ret

_odejmowanie ENDP


_szukaj_elem_max PROC
		push ebp
		mov ebp, esp
		push edi
		push esi
		push ebx

		mov eax, 0 ; najwiekszy element
		mov ecx, [ebp+12] ; liczba elementow
		mov ebx, [ebp+8] ; adres pierwszego elementu tablicy
		mov esi, 0 ; najwieksza wartosc

ptl:
		mov edi, [ebx]
		cmp esi, edi
		jg tutaj
		mov esi, [ebx]
		mov eax, ebx
tutaj:
		add ebx, 4
		loop ptl

		pop ebx
		pop esi
		pop edi
		pop ebp
		ret
_szukaj_elem_max ENDP





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
