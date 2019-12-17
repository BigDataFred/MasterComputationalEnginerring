
########################################
#         P6_publica, Dec 2016
#                 F.Roux
########################################

# 2. Intercambio de claves de Ditte-Hellman
############################################
source("publica/clavesdh.R")
#EJERCICIO. Probar la funcion con:
p<-71
g<-21
xA<-46
xB<-57
k <- clavesdh(p,g,xA,xB)
print(k)

p<-107
g<-32
xA<-82
xB<-25
k <- clavesdh(p,g,xA,xB)
print(k)

# 3. Criptosistema ElGamal
############################################
#3.2. Cifrado y descifrado de numeros
source("publica/cifgamalnum.R")
source("publica/decgamalnum.R")
p<-2357
g<-2
yB<-902
M<-100
x<-1571

C<-cifgamalnum(p, g, yB, M)
print(sprintf("r:%d, s:%d",C[1],C[2]))

M2<- decgamalnum(p, x, C)
print(M2%%p)
print(M==M2)

#3.3. Cifrado y descifrado de texto
source("publica/cifgamal.R")
source("publica/decgamal.R")

C <- cifgamal(2357, 2, 902, LETTERS, "TELEFONO", 2, 3)
print(C)
D <- decgamal( 2357, 1571, LETTERS, C, 2 )
D <- paste(D,sep="",collapse="")
print(D)

C <- cifgamal(2357, 2, 902, LETTERS, "CRIPTOGRAFIA", 2, 3)
print(C)
D <- decgamal( 2357, 1571, LETTERS, C, 2 )
D <- paste(D,sep="",collapse="")
print(D)

C <- c("ADBWNADPPI","AAKRQACFWY","AAZDKABCLT", "ABYSSABVIN","ABNVDABHOE")
D <- decgamal( 65537, 13908, LETTERS, C, 3 )
D <- paste(D,sep="",collapse="")
print(D)

#4. Criptosistema RSA
############################################
#4.1. Generacion de claves
source("publica/clavesRSA.R")

#EJERCICIO. Generar una clave p¶ublica 
#y la correspondiente clave privada con p =281, q = 167.
out<-clavesRSA(281,167)
print(out)

#4.2. Cifrado y descifrado de numeros
source("publica/cifRSAnum.R")
source("publica/decRSAnum.R")
source("publica/decRSAnumch.R")

#ERCICIO. La clave publica de un usuario A es (n = 46927; e = 39423) y la
#privada (p = 281; q = 167; d = 26767). Cifrar el mensaje M = 196 utilizando la
#clave publica de A. Descifrar el mensaje cifrado utilizando la clave privada de A.

C <- cifRSAnum(46927, 39423, 196)
print(C)

M<- decRSAnum(281, 167, 26767, C)
print(M)
print(M==196)

# EJERCICIO. La clave privada RSA de un usuario es (p = 8191; q = 65537; d = 201934721). 
#Descifrar C = 487369684 utilizando y sin utilizar el teorema chino del resto. 
#Solucion: El mensaje en claro es M = 1000. Sin utilizar el teorema chino del resto
#puede que no lo obtengamos.

M1<-decRSAnum(8191, 65537, 201934721, 487369684)
print(sprintf("M:%d",M1))
M2<-decRSAnumch(8191, 65537, 201934721, 487369684)
print(sprintf("M:%d",M2))


# 4.3. Cifrado y descifrado de texto
############################################
source("publica/cifRSA.R")
source("publica/decRSA.R")
source("publica/decRSAch.R")

#EJERCICIO. La clave publica de un usuario A es (n = 46927; e = 39423) y la
#privada (p = 281; q = 167; d = 26767). El alfabeto es LETTERS.

# 1. Cifrar el mensaje "HOLA" utilizando la clave publica de A y partiendo el
#mensaje en claro en bigramas y el mensaje cifrado en 4-gramas. Descifrar el
#mensaje cifrado utilizando la clave privada de A.

C <- cifRSA(46927, 39423, LETTERS, "HOLA", 2, 4)
print(C)
D <- decRSA(281, 167, 26767, LETTERS, C, 2, 4)
D <- paste(D,sep="",collapse="")
print(D)

#2. Cifrar el mensaje "MAÑANA NO HAY CLASES" utilizando la clave publica 
#de A y partiendo el mensaje en claro en 3-gramas y el mensaje cifrado
#en 4-gramas. (Identificar "Ñ" y " " con "W"). Descifrar el mensaje cifrado
#utilizando la clave privada de A.

mensaje <- c("MAWANAWNOWHAYWCLASES")

C <- cifRSA(46927, 39423, LETTERS, mensaje , 3, 4)
print(C)
D <- decRSA(281, 167, 26767, LETTERS, C, 3, 4)
D <- paste(D,sep="",collapse="")
print(D)

C <- cifRSA(46927, 39423, LETTERS, mensaje , 3, 4)
print(C)
D <- decRSAch(281, 167, 26767, LETTERS, C, 3, 4)
D <- paste(D,sep="",collapse="")
print(D)

#5. Problemas
############################################

#1
n<-48959
e<-6529
C<-"CHUBBBVDCEMOBUFMBKYB"
ix <- 3
while(TRUE){
  p=n/ix
  if (p == as.integer(p)){
    q=n/p  
    eul<-n + 1 - (p + q)
    d<-invmod(e,eul)
    D=NULL
    try(D <- decRSAch(p, q, d, LETTERS, C, 3, 4))
    if (length(D)>0){
      break
    }
  }
  ix<-ix+2
}




