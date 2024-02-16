.686
.XMM
.model flat
extern __write : PROC
extern _malloc : PROC
extern _strtol : PROC

public _progowanie_sredniej_kroczacej

.data

.code

_progowanie_sredniej_kroczacej proc
	push ebp
	mov ebp, esp
	push esi
	push edi
	push ebx

	push 6
	fild dword ptr [esp]
	push 10
	fild dword ptr [esp]
	add esp, 8
	fdivp
	;st0 0.6

	mov ebx, [ebp+8] ; tablica
	mov ecx, [ebp+12] ; ilosc el tabl
	mov edx, [ebp+16] ; ile elem brac
	sub ecx, edx


	fldz
tutaj1:
	fadd dword ptr [ebx]
	add ebx, 4

	dec edx
	cmp edx, 0
	jne tutaj1
	mov ebx, [ebp+8] ; tablica
	add ebx, 4
	mov edx, [ebp+16]
	fidiv dword ptr [ebp+16]
	fldz
ptl:
	push ebx
tutaj:
	fadd dword ptr [ebx]
	add ebx, 4

	dec edx
	cmp edx, 0
	jne tutaj
	fidiv dword ptr [ebp+16]
	pop ebx
	fxch st(1)
	fsub st(0), st(1)
	fabs 
	fcomi st(0), st(2)
	jc mniejsze
	nop
	fstp st(0)
	fldz

	add ebx, 4
	mov edx, [ebp+16]
	loop ptl

mniejsze:
	fstp st(0)
	fxch st(1)
	fstp st(0)
	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
_progowanie_sredniej_kroczacej endp

 END
