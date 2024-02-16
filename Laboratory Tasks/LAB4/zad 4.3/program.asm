.686
.model flat

public _liczba_przeciwna
public _odejmij_jeden
.code

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

