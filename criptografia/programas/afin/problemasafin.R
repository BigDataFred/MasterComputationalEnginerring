print("Problema 1")
#En un texto largo, que ha sido cifrado con una transformación afín
#usando el alfabeto de 26 letras y partiendo los mensajes en bloques de una letra,
#observamos que las letras más frecuentes son ``D'' y ``L'', en ese orden.
#Suponiendo que estas dos letras corresponden al cifrado de ``E'' y ``A'',
#respectivamente, descifrar el mensaje ``CJKDHJYBDZXVSJ''.
#Solución:
#Obtenemos los equivalentes numéricos de "E" "A" "D" "L".
source("auxiliares/men2num.R")
men2num(LETTERS, "EADL", 1)
# 4  0  3 11
#Planteamos un sistema
#4.a+b=3 mod 26
#0.a+b=11 mod 26
#Resolvemos
#b=11 
#4.a=-8=18 mod 26
#Como mcd(4, 26) es diferente de 1, dividimos entre 2
#2a=9 mod 13. Por tanto a=2^{-1}\cdot 9 mod 13.
source("aritmod/invmod.R")
a <- (invmod(2, 13)*9)%%13
a
#11
#a=11 mod 13. Módulo 26 las posibilidades son 11, 24.
#Como mcd(a, 26)=1, debe ser a=11.
#Desciframos
source("afin/decafin.R")
mensaje <- decafin(LETTERS, "CJKDHJYBDZXVSJ", 1, 11, 11)
print(mensaje)
#"LOHECONSEGUIDO"

print("Problema 2")
#Interceptamos el mensaje ``ELIX'', que sabemos que ha sido cifrado con
#una transformación translación (transformación afín con clave a=1, b)
#usando el alfabeto de 26 letras y partiendo el mensaje en bloques de una letra.
#Obtener la clave y descifrar el mensaje probando todas las claves posibles.
#Solución: 



print("Problema 3")
# Estamos intentando criptoanalizar una transformación afín sobre un 
# alfabeto de 37 caracteres. El alfabeto comprende los dígitos 0 a 9,
# las 26 letras ``A''-``Z'' y el espacio `` ''. Los números están
# etiquetados con ellos mismos (es decir, con los enteros 0 a 9),
# las letras con los enteros 10 a 35 y el espacio con 36.
# Los mensajes se dividen en bloques de una letra.
# Interceptamos el mensaje ``D0PV4DS1DP22CPIVP DOVJVADMW 5P22Q'' y sabemos
# que termina con la firma ``007''. Descifrar el mensaje.
#Solución:



print("Problema 4")
#En un texto largo, que ha sido cifrado con una transformación afín
#sobre digramas (k=2) usando el alfabeto de 26 letras, observamos que
#los digramas más frecuentes son ``AL'' y ``BQ'', en ese orden.
#Supongamos que estos dos digramas corresponden al cifrado de ``EN'' y ``DE'',
#respectivamente,
#a) obtener las claves de cifrado y descifrado,
#b) descifrar: ``ALIWVZHYTWRPKQWDAZHN'',
#c) cifrar: ``BUENTRABAJO''.

