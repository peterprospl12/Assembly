.686
.XMM
.model flat
extern __write : PROC
extern _malloc : PROC
extern _strtol : PROC
public _srednia_harm
public _nowy_exp
public _sumuj
public _int2float
public _pm_jeden
public _dodawanie_SSE
.data
ALIGN 16
tabl_A dd 1.0, 2.0, 3.0, 4.0
tabl_B dd 2.0, 3.0, 4.0, 5.0
;liczba db 1
tabl_C dd 3.0, 4.0, 5.0, 6.0
jeden dd 1.0
zero dd 0
tbl dd 1.0, 1.0, 1.0, 1.0
.code
_dodawanie_SSE PROC
	push ebp
	mov ebp, esp
	mov eax, [ebp+8]
	movaps xmm2, tabl_A
	
	movaps xmm3, tabl_B
	movaps xmm4, tabl_C
	addps xmm2, xmm3
	addps xmm2, xmm4
	movups [eax], xmm2
	pop ebp
	ret
_dodawanie_SSE ENDP

_pm_jeden proc
	push ebp
	mov ebp, esp
	
	mov eax, [ebp+8]
	movups xmm5, [eax]
	movups xmm6, tbl

	addsubps xmm5, xmm6

	movups [eax], xmm5
	

	pop ebp
	ret
_pm_jeden endp




_int2float proc
	push ebp
	mov ebp, esp
	push edi
	push esi
	push ebx

	mov ebx, [ebp+8] ; tbl wejsciowa
	mov esi, [ebp+12] ;tbl wynikowa

	cvtpi2ps xmm5, qword PTR [ebx]

	movups [esi], xmm5


	pop ebx
	pop esi
	pop edi
	pop ebp
	ret

_int2float endp


_sumuj proc
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi
	
	mov ebx, [ebp+8] ; adres 1 tbl
	mov esi, [ebp+12] ; adres 2 tbl
	mov edi, [ebp+16] ; tablica wynikowa

	movups xmm5, [ebx]
	movups xmm6, [esi]

	paddsb xmm5, xmm6

	movups [edi], xmm5
	
	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_sumuj endp


_nowy_exp proc
	push ebp
	mov ebp, esp
	mov ecx, 19; 
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
