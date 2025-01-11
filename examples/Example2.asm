CODE SEGMENT
ASSUME CS:CODE, DS:CODE
ORG 0

start:
MOV WORD PTR [0502H],1239h ;ilk sayi (12395678h)
MOV WORD PTR [0500H],5678h

MOV WORD PTR [0506H],2314h ;ikinci sayi (23145719h)
MOV WORD PTR [0504H],5719h

MOV AX,0000h ;Carpim sonucunun (BX sonrasi) 16 biti (Son kisimda DI'ya aktariliyor)
MOV BX,0000h ;Carpim sonucunun (en sol) 16 biti
MOV CX,0000h ;Carpim sonucunun (en sag) 16 biti
MOV DX,0000h ;Carpim sonucunun (CX oncesi) 16 biti
MOV SI,20h ;dongu degiskeni (32 kez donmesi icin)


tekrar:
MOV DI,[0500H] ;DI=[0500H] adresindeki degerleri atadim
AND DI,01h ;DI'nin LSB biti haricindeki bitlerini sifirla
XOR DI,01h ;Carpan'in en anlamsiz biti lojik 1 mi?
JZ topla_kaydir ;Evet ise Carpim sonucunu Carpilan ile topla
CLC

devam:
RCR BX,1 ;Carpim sonucunun en ust 16 bitini 1 bit saga kaydir.
RCR AX,1 ;Capim sonucunun 3. 16 bitini 1 bit saga kaydir.
RCR DX,1 ;Carpim sonucunun 2. 16 bitini 1 bit saga kaydir.
RCR CX,1 ;Capim sonucunun en alt 16 bitini 1 bit saga kaydir.
CLC
SHR WORD PTR [0502H],1
RCR WORD PTR [0500H],1 ;Carpan'i bir bit saga kaydir

DEC SI ;dongu degiskenini bir azalt
CMP SI,0 ;dongu degiskeni sifir mi?
JNZ tekrar ;Eger sifir degil ise ayni islemleri tekrarla
JMP son ;Carpim sonucunu goster

topla_kaydir:
ADD AX,[0504H]
ADC BX,[0506H] ; Carpan degeri sonucun en ust 32 bitine ekledim
JMP devam

;Burada AX registerimiz kullanilacagi icin AX degerinde bulmus oldugum degeri bosta kalan DI registerina gecirdim.
son:
MOV DI,AX 
MOV SI,DX ;DX'teki bilgiyi SI registerine yedekle. DX, I/O erisiminde kullanilacak.
MOV SP,2000H ;stack pointerin baglangiç adresini 2000h olarak belirle
MOV AX,CS ;DS=CS
MOV DS,AX ;Data Segment=Code Segment

dongu:
MOV AH,0  ;AX registerindaki AL kismini kullanirken islemi bozmamasi icin AH'i sifirladik.
IN AL,110 ;PORTA daki buton bilgisini AL'ye yukle
CMP AL,1 ;Girdi olarak 1 mi girildi?
JNZ J1 ;Hayir ise J1'e dallan
MOV AX,CX ;AX=CX, 64 bitlik carpim sonucunun ilk (en sag) 16 bitini AX'e yukle

JMP yazdir

J1:
CMP AL,2 ;Girdi olarak 2 mi girildi?
JNZ J2 ;Hayir ise J2'e dallan
MOV AX,DX ;AX=DX, 64 bitlik carpim sonucunun ikinci 16 bitini AX'e yukle
JMP yazdir
J2:
CMP AL,3 ;Girdi olarak 3 mu girildi?
JNZ J3 ;Hayir ise J3'e dallan
MOV AX,DI ;AX=DX, 64 bitlik carpim sonucunun ucuncu 16 bitini AX'e yukle
JMP yazdir
J3:
MOV AX,BX ;AX=DX, 64 bitlik carpim sonucunun en soldaki 16 bitini AX'e yukle (ustteki diger kosullar girilmediyse son 16 biti goster)

yazdir:
OUT 199,AX ;LED_Display'de AX registerini yazdir.
JMP dongu