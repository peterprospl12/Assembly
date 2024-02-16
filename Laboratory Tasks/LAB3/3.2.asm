.686
.model flat
extern		__write : PROC
extern		__read	: PROC
extern		_ExitProcess@4 : PROC
public _main
.data
znaki		db 12 dup (?)
obszar		db 12 dup (?)
dziesiec	dd 10 ; mnoznik

.code

wyswietl_EAX	PROC
		pusha
		mov esi, 10
		mov ebx, 10
konwersja:
		mov edx, 0
		div ebx
		
		add dl, 30H

		mov znaki[esi], dl
		dec esi
		cmp eax, 0
		jne konwersja

wypeln:
		or esi, esi
		jz wyswietl
		mov byte PTR znaki [esi], 20H
		dec esi
		jmp wypeln

wyswietl:
		mov byte PTR znaki [0], 0AH
		mov byte PTR znaki [11], 0AH

		push dword PTR 12
		push dword PTR OFFSET znaki
		push dword PTR 1
		call __write
		add esp, 12


		popa
		ret
wyswietl_EAX	ENDP


wczytaj_EAX	PROC
		
		push ebx
		push ecx
		push edx
		push esi
		push edi
		push ebp

		
		push	dword PTR 12
		push	dword PTR OFFSET obszar
		push	dword PTR 0
		call __read
		add esp, 12

		mov		eax, 0
		mov		ebx, OFFSET obszar

		pop ebp
		pop edi
		pop esi
		pop edx
		pop ecx
		pop ebx

pobieraj_znaki:
		mov		cl, [ebx]
		inc		ebx
		cmp		cl,10
		je		byl_enter
		sub		cl,30H
		movzx	ecx,cl

		mul		dword PTR dziesiec
		add		eax,ecx
		jmp		pobieraj_znaki
byl_enter:
				ret
wczytaj_EAX	ENDP



_main PROC
		call	wczytaj_EAX
		call	wyswietl_EAX
		call	_ExitProcess@4
_main ENDP
END