.686
.model flat
extern __write : PROC
extern _malloc : PROC
extern _strtol : PROC
public _srednia_harm
public _nowy_exp
.data
jeden dd 1.0
zero dd 0
.code


_nowy_exp proc
	push ebp
	mov ebp, esp
	mov ecx, 20; 
	mov ebx, 1 ; licznik obiegow mianownika
	
	fld jeden
	fldz
	fld jeden 
	fld jeden
	;st0 mianownik, st1 licznik
	cmp ecx, 1
	je koniec

ptl:
;licznik
	fmul dword ptr [ebp+8]
	;st0 licznik

;mianownik
	fxch st(1) ; zamiana st0 i st1
	push ebx
	fimul dword ptr [esp]
	;st0 mianownik st1 licznik
	pop ebx
	inc ebx
	fxch st(1)
	;st0 licznik st1 mianownik
;dzielenie
	fxch st(2)
	fimul zero
	fxch st(2)
	fadd st(2), st(0)
	;st0 licznik st1 mianownik st2 licznik
	fxch st(1)
	;st0 mianownik st1 licznik st2 licznik
	fdiv st(2), st(0)
	;st0 licznik st1 mianownik st2; wynik dzielenia
	fxch st(2)
    ;st0 wynik dzielenia st1 mianownik st2 licznik st3 calkowity wynik
	fadd st(3), st(0)
	;st0 wynik dzielenia st1 licznik st2 mianownik st3 calkowity wynik

	fxch st(2)
	;st0 mianownik st1 licznik st2 wynik dzielenia st3 calkowity wynik

	fxch st(1)
	;st0 licznik st1 mianownik st2 wynik dzielenia st3 calkowity wynik

	loop ptl
	fxch st(3)
koniec:

	pop ebp
	ret
_nowy_exp endp


_srednia_harm proc
	push ebp
	mov ebp, esp
	push ebx
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

	pop ebx
	pop ebp
	ret
_srednia_harm endp


 END
