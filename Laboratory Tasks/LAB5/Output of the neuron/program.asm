.686
.XMM
.model flat
extern __write : PROC
extern _malloc : PROC
extern _strtol : PROC

public _single_neuron
.data

.code

_single_neuron proc
	push ebp
	mov ebp, esp
	push ebx
	push edi
	push esi
	
	mov ebx, [ebp+8] ; neurony
	mov edx, [ebp+12] ; wagi
	mov ecx, [ebp+16] ; rozmiar tablicy
	fldz
ptl:
	fld qword ptr [ebx]
	fld dword ptr [edx]
	fmul
	fadd
	add ebx, 8
	add edx, 4
	loop ptl
	mov eax, 4 
	push eax
	call _malloc
	add esp, 4

	fldz
	fxch st(1)
	fcomi st(0), st(1)
	jc mniejsze
	fst dword ptr [eax]
	jmp koniec
	

mniejsze:
	mov ebx, 0
	mov [eax], dword ptr 0
	jmp koniec

koniec:
	
	pop esi
	pop edi
	pop ebx
	pop ebp
	ret
_single_neuron endp

 END
