.686
.model flat
extern __write : PROC
extern __read : PROC
extern _ExitProcess@4 : PROC
public _main
.data
znaki db 52 dup (?)
dziesiec dd 10
w2 dd 0
w1 dd 0
w0 dd 0
.code



wczytaj_hex_96 PROC
		push ebp
		push esi
		push edi

		sub esp, 24
		mov esi, esp

		push dword ptr 22
		push esi
		push dword ptr 0	
		call __read
		add esp, 12

		;ECX:EDX:EAX
		mov ecx, 0
		mov edx, 0
		mov eax, 0

pocz_konwersji:
		mov bl, [esi]
		inc esi

		cmp bl, 10
		je gotowe

		cmp bl, '0'
		jb pocz_konwersji
		cmp bl, '9'
		ja sprawdzaj_dalej
		sub bl, '0'
			
dopisz:
		shl eax, 1
		rcl edx, 1
		rcl ecx, 1

		shl eax, 1
		rcl edx, 1
		rcl ecx, 1

		shl eax, 1
		rcl edx, 1
		rcl ecx, 1

		shl eax, 1
		rcl edx, 1
		rcl ecx, 1

		or al, bl
		jmp pocz_konwersji


sprawdzaj_dalej:
		cmp bl, 'A'
		jb pocz_konwersji
		cmp bl, 'F'
		ja sprawdzaj_dalej2
		sub bl, 'A' - 10
		jmp dopisz
sprawdzaj_dalej2:
		cmp bl, 'a'
		jb pocz_konwersji
		cmp bl, 'f'
		ja pocz_konwersji
		sub bl, 'a' - 10
		jmp dopisz
gotowe:
		add esp, 24
		pop edi
		pop esi
		pop ebp


		ret
wczytaj_hex_96 ENDP

substract PROC
		sub esi, eax
		sbb edi, edx
		sbb ebp, ecx
		
		ret
		
substract ENDP

wyswietl_96 PROC
		pusha
		mov ebx, 50
		mov dword ptr w2, ebp
		mov dword ptr w1, edi
		mov dword ptr w0, esi


konwersja:
		mov edx,0
		mov eax, w2
		div dziesiec

		mov w2, eax
		mov eax, w1
		div dziesiec

		mov w1, eax
		mov eax, w0
		div dziesiec
		
		mov w0, eax

		add dl, '0'
		mov znaki[ebx], dl
		dec ebx

		or eax, w2
		jne konwersja
		or eax, w1
		jne konwersja
		or eax, w0
		jne konwersja

wypeln:
		or ebx,ebx
		jz wyswietl
		mov byte ptr znaki [ebx], 20H
		dec ebx
		jmp wypeln

wyswietl:
		mov byte ptr znaki [0], 0ah

		push dword ptr 52
		push dword ptr offset znaki
		push dword ptr 1
		call __write
		add esp, 12


		popa
		ret
wyswietl_96 ENDP

_main PROC

		call wczytaj_hex_96
		; ECX:EDX:EAX - odjemna
		; EBP:EDI:ESI - odjemnik

		mov ebp, ecx
		mov edi, edx
		mov esi, eax

		call wczytaj_hex_96

		call substract
		call wyswietl_96
		call _ExitProcess@4
_main ENDP
END