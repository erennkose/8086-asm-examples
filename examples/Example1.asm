org 100h

LIST DB 12H,1BH,3CH,40H,11H,29H,23H,5EH,43H,7FH ;Rastgele sirada sayilardan olusan bir liste tanimladim.

MOV AX, 0 ;En kucugu alirken adresimiz ustteki DB isleminden etkilenmemesi icin AX'i 0 yaptik.
MOV BX,OFFSET LIST ;(7000:0100 adresinden itibaren ilk 10 adreste sayilar tutuluyor) BX registerinde bulunan konumdan itibaren sayilari yerlestirdim.

MOV SI,0 ;SI ve DI registerlarini bir nevi indeksleme amaciyla kullandim. 
MOV DI,1 

MOV CX,10D ;Dis dongu icin counter degeri atadim.

dis_dongu:
 
 CMP SI,9 ;Verdigimiz 10 adet degerin disina cikip yanlis degerleri de siralamaya calismasin.
 JZ J3 ;Eger listenin disina ciktiysak J3'e gidip ret etsin.
 
 
 MOV DL,[BX+SI] ;DL --> Elimizdeki kucuk deger, bir turda her daha kucuk geldikce guncellenir.
 MOV DH,[BX+SI+1] ;En kucukten bir sonraki deger, her adimda bir sonraki indisteki degeri alacak.
  
  PUSH CX ;disaridaki dongumun counteri ile icerideki dongumun counteri karismasin diye dis dongunun counterini stacke pushladim.
  MOV CX,9 ;ilk durumda 9 kez karsilastirma islemini yapacak.
  SUB CX,SI ;ilk durumdan sonra ise her seferinde 1 az kez karsilastirma yapacak.
  
  ic_dongu:
   
   CMP DL,DH ;en kucuk deger bir sonraki degerden buyuk mu
   JGE J1    ;buyukse J1 kismina git.
   
   INC DI ;buyuk degilse bir sonraki indise devam etmek icin DI'yi arttirdim.
   MOV DH,[BX+DI] ;DH icerisine sonraki indisteki degeri atadim.
   LOOP ic_dongu ;ic dongude sonraki adima gectim.
  
  
  MOV DH,[BX+SI] ;elimizdeki degeri DH'a atadim. bunu eger degerler ayniysa yerini degistirmesin diye yaptim.
  CMP DH,DL
  JNZ J2 ;DH ve DL esitse degistirme yapma, esit degilse yap. bur kosulu ise bazi degerlerin ustune yazmasini engellemek icin yazdim.
    
  INC SI ;siralanan kisimdan sonraki indise gecmek icin SI'yi 1 arttirdim.
  MOV DI,SI ;DL'de alacagimiz degerin bir sonrasina erismek icin once DI'ya SI'i atadim.
  INC DI ;ardindan DI'in degerini 1 arttirdim.
  POP CX ;dis dongunun counterini stackten geri aldim.
  LOOP dis_dongu ;dis dongude sonraki adima gectim.

ret
  
  J1:
    MOV AX,BX ;Yer degistirilecek degerin konumunu tutmak icin
    ADD AX,DI ;offseti de ekleyip yer degistirilecek degerin adresine tam olarak ulastim.
    MOV DL,DH ;en kucuk deger DH'ta bulundugu icin buraya gelmistik, en kucuk degeri DL'de tutmamiz gerektiginden oraya moveluyoruz.
    INC DI ;ardindan DI'in degerini 1 arttirdim.
    MOV DH,[BX+DI] ;sonraki degeri DH'a moveladim.
    LOOP ic_dongu ;ic dongude sonraki adima gectim
  J2:
    
    MOV BX,AX ;elimizdeki degerin offsetini BX'e koydum. cunku adrese erismek icin BX kullaniyoruz.
    MOV BYTE PTR [BX], DH ; BX'in isaret ettigi konuma (en kucuk degerin konumu) DH'i (elimizdeki deger) moveladim.
    MOV BX,0100H ;BX'i normalde olmasi gereken yere geri gecirmek icin move yaptim.
    MOV BYTE PTR [BX+SI],DL ;o turdaki en kucuk degeri de siralanacak sekilde BX+SI. adresin gosterdigi konuma yerlestirdim.
    
    INC SI ;siralanan kisimdan sonraki indise gecmek icin SI'yi 1 arttirdim.
    MOV DI,SI ;DL'de alacagimiz degerin bir sonrasina erismek icin once DI'ya SI'i atadim.
    INC DI ;ardindan DI'in degerini 1 arttirdim.
    POP CX ;dis dongunun counterini stackten geri aldim.
    LOOP dis_dongu ;dis dongude sonraki adima gectim.  
  J3:
  
    ret