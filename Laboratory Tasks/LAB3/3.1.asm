.686
.model flat
extern		__write : PROC
extern		_ExitProcess@4 : PROC
public _main
.data
znaki		db 12 dup (?)
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

_main PROC

		mov esi, 1
		mov eax, 1
petla: 
		CALL wyswietl_EAX
		add eax, esi
		inc esi
		cmp esi, 51
		jne petla
		

		push 0
		call _ExitProcess@4
_main ENDP
END