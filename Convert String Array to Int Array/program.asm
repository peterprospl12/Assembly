.686
.model flat
extern __write : PROC
extern _malloc : PROC

public _convert_to_array


.data
znaki db 'Blad'
tablica dd 32 dup (?)
trzy dd 3
cztery dd 4
dziesiec dd 10
.code

_convert_to_array PROC
		push ebp
		mov ebp, esp
		push edi
		push esi
		push ebx

		mov ebx, [ebp+8] ; adres poczatek tablicy
		mov eax, 0
		mov ecx, 1 ; licznik 
sprawdzaj:
 		mov al, [ebx]
		inc ebx
		cmp al, 00 ; sprawdzamy czy enter
		je zakoncz
		cmp al, 20h ; sprawdzamy czy spacja
		jne sprawdzaj
		inc ecx
		jmp sprawdzaj
zakoncz:
		
		mov eax, ecx
		imul cztery
		push eax
		call _malloc
		add esp, 4
		mov edi, eax ; adres nowej tablicy
		mov ebx, [ebp+8] ; adres poczatkowej tablicy


		call wyswietl_eax
		mov eax, edi
		pop ebx
		pop esi
		pop edi
		pop ebp
		ret
_convert_to_array ENDP



wyswietl_eax PROC
		pusha
		;bie��ca warto�� przekszta�canej liczby przechowywana jest
		; w rejestrze EAX; przyjmujemy 0 jako warto�� pocz�tkow�
		mov eax, 0
		
		jmp pobieraj_znaki
		;ebx adres obszaru ze znakami
spacja:
		mov [edi], eax
		mov eax,0 
		add edi, 4
		cmp cl, 00
		je byl_enter
	
pobieraj_znaki:
		mov cl, [ebx] ; pobranie kolejnej cyfry w kodzie
		; ASCII
		inc ebx ; zwi�kszenie indeksu
		cmp cl,00 ; sprawdzenie czy naci�ni�to Enter
		je spacja ; skok, gdy naci�ni�to Enter
		cmp cl, 20H
		je spacja
		sub cl, 30H ; zamiana kodu ASCII na warto�� cyfry
		movzx ecx, cl ; przechowanie warto�ci cyfry w
		; rejestrze ECX
		; mno�enie wcze�niej obliczonej warto�ci razy 10
		mul dword PTR dziesiec
		add eax, ecx ; dodanie ostatnio odczytanej cyfry
		jmp pobieraj_znaki ; skok na pocz�tek p�tli
byl_enter:
		popa
		ret
wyswietl_eax ENDP


 END
