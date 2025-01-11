# 8086-asm-examples
Mikroişlemciler dersi için yazmış olduğum 8086 Assembly örnekleri

## Example 1
Bellekte kendi belirlediğiniz bir alana 10 tane birer byte’lık rastgele işaretsiz sayı
yerleştirip bunları küçükten büyüye sıralayıp yine aynı bellek bölgesinde
saklayan programı Assembly dilinde yazınız. Selection Sort algoritması önerilir.

## Example 2
32 bitlik iki sayıyı (MUL emiri kullanmadan)  çarpan programın yazınız.	64 bitlik çarpım sonucunun 16’şar bitlik kısımlarını, Emu8086 programındaki sanal giriş portu (Simple) ve çıkış portu (LED_Display) kullanarak kullanıcıya yansıtın. Giriş portundan “1” girildiğinde sonucun en alt 16 biti, “4” girildiğinde en üst 16 biti ve “2” veya “3” girildiğinde de sonucun ilgili kısımları displaye yansıtılmalıdır.

## Example 3
8086 CPU’sunun BX registerinde bulunan 16 bitlik (0-65535 arasındaki) işaretsiz sayının
karekökünün yaklaşık olarak, (yani karekök sonucunun sadece tamsayı kısmının) hesaplanması
istenmektedir. Örneğin; 0 sayısının karekökü için 0, 1 desimal sayısı için 1, 2 desimal sayısı için yine
1, 9 desimal sayısı için 3, 15 desimal sayısı için yine 3, 16 desimal sayısı için 4,……, 65534 desimal
sayısı için 255, 65535 desimal sayısı için yine 255 sayısı üretilmelidir. İstenen şekilde çalışan
karekök bulma algoritmanızı yazınız. Bu işi yapan algoritmayı alt program haline getiriniz.
Daha sonra yazdığınız alt programı kullanarak 0 ile 100 arasındaki sayıların karekökünü hesaplayıp
bellekte 0900:0200 adresinden itibaren yerleştiriniz.

## Example 4
Ana bellekte bir bölgeye 10 tane (keyfi) DoubleWord (32 bitlik sayı) peş peşe yerleştirip daha sonra
bellekte 0700:0300’den başlayarak bu 10 tane 32 bitlik sayıların her biri için tek eşlik olanlara karşılık
(bir bayt) 01h, çift eşlik olanlara karşılık (bir bayt) 00h yerleştirmeniz istenmektedir. Daha sonra
Emu8086 programındaki sanal giriş portu (Simple) dan yapılacak 1-10 arasındaki girişler için çıkış
portu (LED_Display) kullanarak ilgili DoubleWord sayının parity bilgisi kullanıcıya yansıtılmak
isteniyor. Örn. bellekte ilk DoubleWord olarak 33310013H olduğu durumda ekran görüntüsü yukarıdaki gibi
olmalıdır.
