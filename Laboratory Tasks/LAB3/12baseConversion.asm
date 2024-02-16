.686
.model flat
extern		__write : PROC
extern		__read	: PROC
extern		_ExitProcess@4 : PROC
public _main
.data
znaki		db 80 dup (?)
obszar		db 12 dup (?)
dekoder		db '0123456789ABCDEF'
dekoder_dw	db '0123456789AB'

dziesiec	dd 10 ; mnoznik
dwanascie	dd 12 ; mnoznik
znak db '0'

.code

wczytaj_do_eax_dw PROC
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
		mov ecx, 0
		mov ebx, OFFSET obszar

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
	    movzx ecx, dl
		mul dword PTR dwanascie
		add eax, ecx
		jmp pocz_konw
		

sprawdzaj_dalej:
		cmp dl, 'A'
		jb pocz_konw 
		cmp dl, 'B'
		ja sprawdzaj_dalej2
		sub dl, 'A' - 10
		jmp dopisz

sprawdzaj_dalej2:
		cmp dl, 'a'
		jb pocz_konw 
		cmp dl, 'b'
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

wczytaj_do_eax_dw ENDP




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


		pop ebp
		pop edi
		pop esi
		pop edx
		pop ecx
		pop ebx
		ret
wyswietl_EAX	ENDP


liczba_dwunastkowa PROC
		push ebx
		push ecx
		push edx
		push eax
		push edi
		push ebp
		
		sub esp, 12
		mov ecx, 0 ; counter
		mov edi, esp
		mov ebx, 12

		
konwersja:
		mov edx, 0
		inc ecx
		div ebx
		mov dl, dekoder_dw[edx]
		mov [edi][ecx], dl
		cmp eax, 0
		jne konwersja

wpisanie:
		mov bl, [edi][ecx]
		mov znaki[esi], bl
		dec ecx
		inc esi
		cmp ecx, 0
		jne wpisanie
		
		add esp, 12
		pop ebp
		pop edi
		pop eax
		pop edx
		pop ecx
		pop ebx
		ret
liczba_dwunastkowa ENDP

zadanie PROC
	pusha
	;ecx obiegi petli
	mov esi, 0
	mov edx, 1
	mov znaki[esi], 0AH
	inc esi
petla:
	call liczba_dwunastkowa
	cmp znak, '0'
	je odejmij
dodaj:
	mov znak, '0'
	add eax, edx
	inc edx
	jmp tutaj
odejmij:
	mov znak, '1'
	sub eax, edx
	inc edx
	
tutaj:
	mov znaki[esi], 0AH
	inc esi
loop petla


	popa
	ret


zadanie ENDP


_main PROC
		CALL wczytaj_do_eax_dw
		mov ecx, eax
		CALL wczytaj_do_eax_dw
		mov ebx, eax
		
		call zadanie
		push dword PTR 30
		push dword PTR OFFSET znaki
		push dword PTR 1
		call __write
		call	_ExitProcess@4

_main ENDP
END