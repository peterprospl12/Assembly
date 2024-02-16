.686
.model flat
extern __write : PROC
extern _malloc : PROC
extern _strtol : PROC
public _convert_to_array
.data
osiem dd 8
x dd 0
licznik dd 0
sprawdzacz db 0
.code

_convert_to_array PROC
		push ebp
		mov ebp, esp
		push edi 
		push esi
		push ebx

		mov ebx, [ebp+8] ; adres poczatku tablicy
		mov ecx, 1 ; licznik
		
licz:
		mov al, [ebx]
		inc ebx
		cmp al, 00
		je zakoncz
		cmp al, 20h
		jne licz
		inc ecx
		jmp licz
zakoncz:
		mov esi, ecx ; licznik cyfr
		mov eax, ecx
		imul osiem
		push eax
		call _malloc
		add esp, 4
		mov ebx, [ebp+8] ; adres poczatku podstawowej tablicy
		mov edi, eax ; adres poczatku nowej tablicy

		mov eax, 0
		mov ecx, 0


		mov edx, [ebp+8]
		mov esi, edi
		jmp konwertuj
spacja:
		mov sprawdzacz, cl  ; zapisujemy wartosc cl zeby potem sprawdzicz czy by³ enter
		mov edx, ebx ; przenosimy koncowy adres liczby
		sub edx, licznik ; przechodzimy na poczatek liczby
		mov licznik, 0 ; resetujemy licznik
		
		push dword ptr 10
		push dword ptr x
		push edx
		call _strtol
		add esp, 12
		
		mov [edi], eax ; ³adujemy m³odsz¹ czeœæ
		add edi, 4 
		mov [edi], edx ; ³adujemy starsz¹ czêœæ
		add edi, 4
		
		mov ecx, 0 ; zeryjumey ecx
		inc ebx 
		cmp sprawdzacz, 10 ; sprawdzamy czy by³ enter
		je byl_enter
konwertuj:
		mov cl, [ebx]
		
		cmp cl, 20h
		je spacja
		cmp cl, 10
		je spacja
		add licznik, 1
		inc ebx

		jmp konwertuj


byl_enter:
		
		mov eax, esi
		pop ebx
		pop esi
		pop edi
		pop ebp
		ret
_convert_to_array ENDP


 END
