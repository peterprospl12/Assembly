.686
.model flat
extern		__write : PROC
extern		__read	: PROC
extern		_ExitProcess@4 : PROC
public _main
.data
znaki		db 12 dup (?)
obszar		db 12 dup (?)
dekoder		db '0123456789ABCDEF'
dziesiec	dd 10 ; mnoznik
znak db '0'

.code

wczytaj_do_EAX_hex PROC
		push ebx
		push ecx
		push edx
		push esi
		push edi
		push ebp

		sub esp, 12
		mov esi, esp

		push dword PTR 10
		push esi
		push dword PTR 0
		call __read

		add esp, 12

		mov eax, 0 

pocz_konw:
		mov dl, [esi]
		inc esi
		cmp dl, 10
		je gotowe

		cmp dl, '0'
		jb pocz_konw
		cmp dl, '9'
		ja sprawdzaj_dalej
		sub dl, '0'

dopisz:
		shl eax, 4
		or al, dl
		jmp pocz_konw

sprawdzaj_dalej:
		cmp dl, 'A'
		jb pocz_konw
		cmp dl, 'F'
		ja sprawdzaj_dalej2
		sub dl, 'A' - 10
		jmp dopisz

sprawdzaj_dalej2:
		cmp dl, 'a'
		jb pocz_konw
		cmp dl, 'f'
		ja pocz_konw
		sub dl, 'a' - 10
		jmp dopisz

gotowe:
		add esp, 12


		pop ebp
		pop edi
		pop esi
		pop edx
		pop ecx
		pop ebx
		ret


wczytaj_do_EAX_hex ENDP




wyswietl_EAX_hex	PROC
		pusha
		sub esp, 12
		mov edi, esp

		mov ecx, 8
		mov esi, 1

ptl3hex:
		rol	eax, 4
		mov ebx, eax
		and ebx, 0000000FH
		mov	dl, dekoder[ebx]
		cmp dl, znak
		jne tutaj1
		mov dl, ' '
		jmp tutaj2

tutaj1:
		mov znak, 'a'
tutaj2:
		mov [edi][esi], dl
		
		inc esi
		loop ptl3hex

		mov byte PTR [edi][0], 10
		mov byte PTR [edi][9], 10

		push 10
		push edi
		push 1
		call __write
		add esp, 24

		popa
		ret
wyswietl_EAX_hex	ENDP

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
				pop ebp
				pop edi
				pop esi
				pop edx
				pop ecx
				pop ebx
				ret
wczytaj_EAX	ENDP



_main PROC
		call	wczytaj_do_EAX_hex
		call	wyswietl_EAX
		call	_ExitProcess@4
_main ENDP
END