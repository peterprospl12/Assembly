.386
rozkazy SEGMENT use16
ASSUME CS:rozkazy





obsluga_klawiatury PROC
push ax
push bx
push es
; wpisanie adresu pamięci ekranu do rejestru ES - pamięć
; ekranu dla trybu tekstowego zaczyna się od adresu B8000H,
; jednak do rejestru ES wpisujemy wartość B800H,
; bo w trakcie obliczenia adresu procesor każdorazowo mnoży
; zawartość rejestru ES przez 16
mov ax, 0B800h ;adres pamięci ekranu
mov es, ax
; zmienna 'licznik' zawiera adres bieżący w pamięci ekranu
mov bx, cs:licznik
; przesłanie do pamięci ekranu kodu ASCII wyświetlanego znaku
; i kodu koloru: biały na czarnym tle (do następnego bajtu)
in al, 60H
cmp al, 128
jae wysw_dalej
call wyswietl_AL
; zwiększenie o 2 adresu bieżącego w pamięci ekranu
add bx,8
; sprawdzenie czy adres bieżący osiągnął koniec pamięci ekranu
cmp bx,4000
jb wysw_dalej ; skok gdy nie koniec ekranu
; wyzerowanie adresu bieżącego, gdy cały ekran zapisany
mov bx, 0
;zapisanie adresu bieżącego do zmiennej 'licznik'
wysw_dalej:
mov cs:licznik,bx
; odtworzenie rejestrów
pop es
pop bx
pop ax
; skok do oryginalnej procedury obsługi przerwania zegarowego
jmp dword PTR cs:wektor9
; dane programu ze względu na specyfikę obsługi przerwań
; umieszczone są w segmencie kodu
licznik dw 320 ; wyświetlanie począwszy od 2. wiersza
wektor9 dd ?
obsluga_klawiatury ENDP
















; podprogram 'wyswietl_AL' wyświetla zawartość rejestru AL
; w postaci liczby dziesiętnej bez znaku
wyswietl_AL PROC
; wyświetlanie zawartości rejestru AL na ekranie wg adresu
; podanego w ES:BX
; stosowany jest bezpośredni zapis do pamięci ekranu
; przechowanie rejestrów

push ax
push cx
push dx
mov cl, 10 ; dzielnik

mov ah, 0 ; zerowanie starszej części dzielnej
; dzielenie liczby w AX przez liczbę w CL, iloraz w AL,
; reszta w AH (tu: dzielenie przez 10)
div cl
add ah, 30H ; zamiana na kod ASCII
mov es:[bx+4], ah ; cyfra jedności
mov ah, 0
div cl ; drugie dzielenie przez 10
add ah, 30H ; zamiana na kod ASCII
mov es:[bx+2], ah ; cyfra dziesiątek
add al, 30H ; zamiana na kod ASCII
mov es:[bx+0], al ; cyfra setek
; wpisanie kodu koloru (intensywny biały) do pamięci ekranu
mov al, 01101111B
mov es:[bx+1],al
mov es:[bx+3],al
mov es:[bx+5],al
; odtworzenie rejestrów
pop dx
pop cx
pop ax

ret ; wyjście z podprogramu
wyswietl_AL ENDP





zacznij:
mov al, 0
mov ah, 5
int 10
mov ax, 0
mov ds,ax ; zerowanie rejestru DS
; odczytanie zawartości wektora nr 8 i zapisanie go
; w zmiennej 'wektor9' (wektor nr 8 zajmuje w pamięci 4 bajty
; począwszy od adresu fizycznego 8 * 4 = 32)
mov eax,ds:[36] ; adres fizyczny 0*16 + 32 = 32
mov cs:wektor9, eax

; wpisanie do wektora nr 8 adresu procedury 'obsluga_zegara'
mov ax, SEG obsluga_klawiatury ; część segmentowa adresu
mov bx, OFFSET obsluga_klawiatury ; offset adresu
cli ; zablokowanie przerwań
; zapisanie adresu procedury do wektora nr 8
mov ds:[36], bx ; OFFSET
mov ds:[38], ax ; cz. segmentowa
sti ;odblokowanie przerwań
; oczekiwanie na naciśnięcie klawisza 'x'
aktywne_oczekiwanie:
mov ah,1
int 16H
; funkcja INT 16H (AH=1) BIOSu ustawia ZF=1 jeśli
; naciśnięto jakiś klawisz
jz aktywne_oczekiwanie
; odczytanie kodu ASCII naciśniętego klawisza (INT 16H, AH=0)
; do rejestru AL
mov ah, 0
int 16H
cmp al, 'x' ; porównanie z kodem litery 'x'
jne aktywne_oczekiwanie ; skok, gdy inny znak
; deinstalacja procedury obsługi przerwania zegarowego
; odtworzenie oryginalnej zawartości wektora nr 8
mov eax, cs:wektor9
cli
mov ds:[36], eax ; przesłanie wartości oryginalnej
; do wektora 8 w tablicy wektorów
; przerwań
sti
; zakończenie programu
mov al, 0
mov ah, 4CH
int 21H
rozkazy ENDS
nasz_stos SEGMENT stack
db 128 dup (?)
nasz_stos ENDS
END zacznij