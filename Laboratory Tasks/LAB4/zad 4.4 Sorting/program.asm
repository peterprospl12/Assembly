.686
.model flat

public _liczba_przeciwna
public _odejmij_jeden
public _przestaw
.code

_przestaw PROC
		push ebp
		mov ebp, esp
		push ebx

		mov ebx, [ebp+8] ; adres tablicy
		mov ecx, [ebp+12] ; liczba elementow tablicy
		dec ecx
		
ptl:	mov eax, [ebx]
		cmp eax, [ebx+4]
		jle gotowe
		
		mov edx, [ebx+4]
		mov [ebx], edx
		mov [ebx+4], eax

gotowe:
		add ebx, 4
		loop ptl

		pop ebx
		pop ebp
		ret 
_przestaw ENDP






_odejmij_jeden PROC
		push ebp
		mov ebp, esp
		; ebp + 8 = wskaznik na adres pamieci wskaznika
		push ebx
		
		mov eax, [ebp+8]
		mov ebx, [eax]
		mov ecx, [ebx]
		
		dec ecx
		mov [ebx], ecx

		pop ebx
		pop ebp
		ret
_odejmij_jeden ENDP





_liczba_przeciwna PROC
		push ebp
		mov ebp, esp
		push ebx

		mov ebx, [ebp+8]

		mov eax, [ebx]	
		not eax
		inc eax
		; mozna tez po prostu uzyc neg eax
		mov [ebx], eax


		pop ebx	
		pop ebp
		ret

_liczba_przeciwna ENDP
END

