.686
.model flat
extern __write : PROC
extern _malloc : PROC

public _dodaj

.data
znaki db 'Blad'
tablica dd 32 dup (?)
trzy dd 3
cztery dd 4
dziesiec dd 10
dwa dd 2
.code

_dodaj proc
		push ebp
		mov ebp, esp
		push edi
		push esi
		push ebx

		mov ebx, [ebp+8]
		mov eax, 0
		mov ecx, 0 ; licznik znakow
licz_znaki:
		mov ax, [ebx]
		cmp ax, 0
		je koniec
		inc ecx
		add ebx, 2
		jmp licz_znaki
koniec:
		inc ecx
		mov esi, ecx
		mov eax, ecx
		
		imul dwa
		mov ebx, eax ; suma mnozenia
		
		push eax
		call _malloc
		add esp, 4

		mov edi, eax; adres poczatku nowej tablicy
		sub ebx, 2 ; adres przedostatniego bajtu tablicy
		add edi, ebx ; adres osatatniego elementu tablicy
		
		
		; [ebp+12] liczba do dodania
		mov eax, 0 ; wyzerowanie eax
		mov ecx, esi
		dec esi; liczba cyfr w poczatkowej tablicy
		mov ebx, [ebp+8] ; adres poczatku wejsciowej tablicy
		add ebx, esi
		add ebx, esi
		sub ebx, 2

		mov ax, [ebx]
		mov edx, [ebp+12]
		cmp edx, 48
		je fill
		add eax, [ebp+12] ; dodanie cyfry
		
		sub eax, 58
		cmp eax, 48 ; sprawdzenie czy bêdzie reszta
		jl fill
reszta:
		dec esi
		dec ecx
		cmp esi, 0
		je tutaj1
		sub ebx, 2
		mov [edi], ax
		mov ax, [ebx]
		inc ax
		sub edi, 2
		cmp ax, 58
		jl fill
		sub ax, 10
		
		jmp reszta
tutaj1:
		mov[edi], ax
		sub edi, 2
		mov ax, 49
		mov [edi], ax
		jmp koniec1

fill:
		cmp esi, 0
		je fill1
		mov [edi], ax
		sub edi, 2
		sub ebx, 2
		mov ax, [ebx]
		dec esi
		dec ecx
		jmp fill

fill1:
		
		mov ax, 32
		mov [edi], ax
		dec ecx
		cmp ecx, 0
		je koniec1
		sub edi, 2
		jmp fill1


koniec1:
		
		mov ecx, [ebp+16]
		mov [ecx], edi
		
		mov eax, 0
		pop ebx
		pop esi
		pop edi
		pop ebp
		ret

_dodaj endp


 END
