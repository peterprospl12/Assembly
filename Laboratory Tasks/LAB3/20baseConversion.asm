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
dekoder_dw	db '0123456789ABCDEFGHJ'


dziesiec	dd 10 ; mnoznik
dwanascie	dd 12 ; mnoznik
dwadziescia dd 20 ; mnoznik
znak db '0'
przecinek db ','
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
		mul dword PTR dwadziescia
		add eax, ecx
		jmp pocz_konw
		

sprawdzaj_dalej:
		cmp dl, 'A'
		jb pocz_konw 
		cmp dl, 'J'
		ja sprawdzaj_dalej2
		sub dl, 'A' - 10
		jmp dopisz

sprawdzaj_dalej2:
		cmp dl, 'a'
		jb pocz_konw 
		cmp dl, 'j'
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
		mov ebx, 10

		
konwersja:
		mov edx, 0
		inc ecx
		div ebx
		add dl, 30H
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
	; dzielna edx:eax
	; dzielnik ecx

	mov esi, 0
	mov ebp, 10 ; mnoznik
	mov edi, 0
dzielenie:
	mov edx, 0
	mov ebx, eax
	div ecx

	;wpisywanie do tablicy
	call liczba_dwunastkowa
	
	cmp przecinek, ','
	jne tutaj
	cmp edx, 0
	je tutaj
	mov znaki[esi], ','
	mov przecinek, '0'
	inc esi

tutaj:
	mul ecx
	cmp przecinek, ','
	je tutaj1
	inc edi
tutaj1:
	cmp edi, 4
	je koniec
	sub ebx, eax ; odejmowanie reszty
	mov eax, ebx
	mul ebp

	jmp dzielenie

koniec:


	popa
	ret


zadanie ENDP


_main PROC
		CALL wczytaj_do_eax_dw
		mov ebx, eax
		CALL wczytaj_do_eax_dw
		mov ecx, eax
		mov eax, ebx
		call zadanie

		push dword PTR 6
		push dword PTR OFFSET znaki
		push dword PTR 1
		call __write
		call	_ExitProcess@4
_main ENDP
END