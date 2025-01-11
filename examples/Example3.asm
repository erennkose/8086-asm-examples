org 100h

; KULLANILACAK REGISTERLAR SIFIRLANDI
MOV CX,0
MOV BX,0
MOV SI,0

; BU KOD ORNEGIN 3 DEGERININ KARESI ILE 4 DEGERININ KARESI ARASINDAKI HER DEGERIN KAREKOKUNE 3 DER. [9,16)

; 0 ILE 100 ARASINDA TUM DEGERLERIN [0900:0200] ADRESINDEN ITIBAREN YAZILMASI ICIN 100 KERE CALISACAK DONGU
DONGU:
 MOV AX,0900H
 MOV DS,AX ; DS SEGMENT REGISTERINA [0900H] ADRESINI ATADIM, BURAYA OFFSET EKLENEREK HER DEGERIN KAREKOKU EKLENECEK
 CALL KAREKOK ; FONKSIYON CAGRISI
 MOV [0200H + SI],BX ; ALT PROGRAMDAN GELEN VE SONUC OLAN BX DEGERI GEREKLI ADRESE ATANIR
 INC SI ; SONRAKI ADRESE ATAMAK ICIN SI 1 ARTTIRILIR
 INC CX ; COUNTER OLARAK KULLANDIGIM CX 1 ARTTIRILIR
 CMP CX,101 ; CX 101 OLANA KADAR DONGUNUN DEVAM ETTIRILMESI SAGLANIR
 JNZ DONGU

; BX'TEKI DEGERE GORE KAREKOK HESAPLAYAN ALT PROGRAM
KAREKOK PROC
 J3:
  MOV AX,BX ; AX REGISTERINA KARESI ALINACAK DEGER ATANIYOR
  MUL BX ; BX * AX ISLEMI ILE KARE ALINIP AX REGISTERINA ATANIR
  CMP AX,CX ; AX CX'E 
  JE J1 ; ESIT ISE J1 KISMINA GIT
  JAE J2 ; AX DAHA KUCUKSE
  INC BX ; BX 1 ARTTIRILIYOR VE BIR SONRAKI SAYININ KARESININ HESAPLANMASINA GECIYORUZ.
  JMP J3 ;KAREKOK FONKSIYONU TEKRAR CAGIRILIYOR VE HESAPLAMA DEVAM EDIYOR.
 J1:
  ret ; BURADA DIREKT KAREKOKUNE ESIT SAYI GELECEGI ICIN DIREKT BX DEGERIMIZ KAREKOKUMUZ OLUYOR 
 J2:
  DEC BX ; BURADA KAREKOK DEGERIMIZ, BIZIM DEGERIMIZDEN KUCUK EN BUYUK TAM KAREKOK DEGERI OLARAK ADRESE ATANACAK SEKILDE CX 1 AZALTILIYOR
  ret
KAREKOK endp