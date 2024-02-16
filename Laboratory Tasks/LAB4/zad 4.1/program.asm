.686
.model flat

public _szukaj_max

.code

_szukaj_max PROC
		push ebp
		mov ebp, esp
		mov ebx, 0 ; najwieksza x_y
		mov eax, [ebp+8] ; x

;przypadek x i y

		cmp eax, [ebp+12]
		jge wieksza_x
		mov ebx, [ebp+12]
		jmp przypadek_zp

wieksza_x: 
		mov ebx, eax
		jmp przypadek_zp

;przypadek z i p

przypadek_zp:
		mov eax, [ebp+16]
		cmp eax, [ebp+20]
		jge wieksza_z
		mov ecx, [ebp+20]
		jmp przypadek_xyzp

wieksza_z:
		mov ecx, eax
		jmp przypadek_xyzp

przypadek_xyzp:
		cmp ebx, ecx
		jge wieksza_xy
		mov eax, ecx
		jmp koniec

wieksza_xy:
		mov eax, ebx
		jmp koniec

koniec:
		pop ebp
		ret
;najwieksza z_p i x_y

_szukaj_max ENDP
END

