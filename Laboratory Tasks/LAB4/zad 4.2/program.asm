.686
.model flat

public _liczba_przeciwna

.code

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

