.686
.model flat
extern __write : PROC
extern _malloc : PROC

public _tablica_nieparzystych


.data
znaki db 'Blad'
tablica dd 32 dup (?)
trzy dd 3
cztery dd 4
.code

_tablica_nieparzystych PROC
		push ebp
		mov ebp, esp
		
		push ebx
		push esi
		push edi

		mov edx, [ebp+12] ; adres liczby elementow w tablicy
		mov ecx, [edx] ; liczba elementow w tablicy

		mov ebx, [ebp+8] ; adres poczatkowy tablicy

		mov edi, 0 ; nieparzyste
		mov esi, 0 ; parzyste

ptl:
		mov eax, [ebx]
		shr eax, 1
		jc nieparzysty
parzysty:
		inc esi
		jmp koniec
nieparzysty:
		inc edi
koniec:
		add ebx, 4
		loop ptl
		

		mov eax, edi
		imul cztery
		push eax
		call _malloc
		add esp, 4
		mov ebx, [ebp+8]
		mov edx, [ebp+12]
		mov ecx, [edx]
		mov edi, eax ; poczatkowy adres nowej tablicy
		mov [edx], esi ; wpisujemy parzyste do n

		
ptl1:
		mov esi, [ebx]
		shr esi, 1
		jc nieparzysty1
parzysty1:
		jmp koniec1
nieparzysty1:
		mov esi, [ebx]
		mov [eax], esi
		add eax, 4
koniec1:
		add ebx, 4
		loop ptl1
		mov eax, edi

		pop edi
		pop esi
		pop ebx

		pop ebp
		ret


_tablica_nieparzystych ENDP


 END
