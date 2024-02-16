
public szukaj64_max
public suma_siedmiu_liczb
.code


suma_siedmiu_liczb PROC
		
		; RCX = 1 liczba
		; RDX = 2 liczb
		; R8 = 3 liczba
		; R9 = 4 liczba
		; stos = 5,6,7 liczba
		; 32 bitowy shadow space (kompilator)
		push rbp
		mov rbp, rsp
		push rbx
		mov rax, 0
		
		add rax, rcx
		add rax, rdx
		add rax, r8
		add rax, r9
		add rax, [rbp+48] 
		add rax, [rbp+56]
		add rax, [rbp+64]


		pop rbx
		pop rbp
		ret


suma_siedmiu_liczb ENDP

szukaj64_max PROC
		push rbx
		push rsi

		mov rbx, rcx
		mov rcx, rdx
		mov rsi, 0
;w rejestrze RAX przechowywany bêdzie najwiêkszy dotychczas
; znaleziony element tablicy - na razie przyjmujemy, ¿e jest
; to pierwszy element tablicy
		mov rax, [rbx + rsi*8]

		dec rcx

ptl:	inc rsi

		cmp rax, [rbx + rsi*8]
		jge dalej
		mov rax, [rbx+rsi*8]
dalej: loop ptl

		
		pop rsi
		pop rbx
		ret

szukaj64_max ENDP

END