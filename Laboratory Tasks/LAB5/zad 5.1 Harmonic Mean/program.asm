.686
.model flat
extern __write : PROC
extern _malloc : PROC
extern _strtol : PROC
public _srednia_harm
.data
jeden dd 1.0
.code

_srednia_harm proc
	push ebp
	mov ebp, esp
	mov ebx, [ebp+8] ; adres poczatku tablicy
	fild dword ptr [ebp+12]
	fldz
	;st0 = 0
	mov ecx, [ebp+12]
ptl:
	fld jeden
	; st0 = 1, st0 = wynik mianownika
	fdiv dword ptr [ebx]
	add ebx, 4

	faddp 

	loop ptl
	
	fdivp

	pop ebp
	ret
_srednia_harm endp


 END
