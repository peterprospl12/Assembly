.686
.XMM
.model flat
extern __write : PROC
extern _malloc : PROC
extern _strtol : PROC

public _Matmul
.data
cztery db 4
;S[K][l] P[l][m]
wierA dd 0
kolB dd 0
wierB dd 0
adres dd 0
.code

;If the product is defined, the resulting matrix will have the same number of rows as the first matrix and the same number of columns as the second matrix.
_Matmul proc
	push ebp
	mov ebp, esp
	push ebx
	push edi
	push esi

	mov ebx, [ebp+8] ; adres tablicy a
	mov edi, [ebp+12] ; adres tablicy B

	mov eax, [ebp+24]
	mov ecx, [ebp+16]
	mov edx, 0
	mul ecx
	mov edx, 0
	mul dword ptr cztery
	push eax
	call _malloc
	add esp, 4
	
	mov esi, eax ; adres wynikowej tablicy
	mov adres, eax

	mov eax, [ebp+16]
	mov wierA,  eax
	mov edx, 0 ; wierA counter    A
	mov eax, [ebp+24]
	mov kolB, eax
	mov ecx, 0 ; kolB counter    H
	mov eax, [ebp+20]
	mov wierB, eax
	mov eax, 0 ; wierB counter   G

	;zajete rejestry eax,ebx,ecx,edx,esi,edi,ebp

ptl1:
	push ebx
	push edi
		ptl2:
			fldz
			push ebx
			push edi
				
				ptl3:
					fld qword ptr [ebx]
					fld dword ptr [edi]
					fmulp 
					faddp 
					add ebx, 8
					add edi, 12

					inc eax
					cmp eax, wierB
					jne ptl3
			mov eax, 0
			pop edi
			pop ebx
			fstp dword ptr [esi]
			add edi, 4 ; przesuniecie kolumny tablicy B
			add esi, 4 ; przesuniecie kolumny wyjsciowej tablicy
			inc ecx
			cmp ecx, kolB
			jne ptl2
	pop edi
	pop ebx
	mov ecx, 0
	add ebx, 24 ; przesuniecie wiersza tablicy A
	inc edx
	cmp edx, wierA
	jne ptl1



	mov eax, adres

	pop esi
	pop edi
	pop ebx
	pop ebp
	ret
_Matmul endp


 END
