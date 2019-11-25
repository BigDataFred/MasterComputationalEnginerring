print("Problema 1")
# Si p(x)=1+5x^2+x^5, calcular p(2).
# Solución
source("auxiliares/evalpol.R")
pol <- c(1, 0, 0, 5, 0, 1)
sol <- evalpol(pol,2)
print(sol) 
#53

print("Problema 2")
#Si p(x)=5x^4+2x^3+x^2, calcular p(3).
# Solución
pol <- c(5, 2, 1, 0, 0)
sol <- evalpol(pol,2)
print(sol) 

print("Problema 3")
source("auxiliares/cambiobase.R")
#Calcular la representación en base 8 de 2001.
# Solución
# 2001 = 3*8^3+7*8^2+2*8^1+1
res <- c(3, 7, 2, 1)

y<- cambiobase(2001,8)
if (all(res==y)){
  print(y)
} else{
  print("error")
}

print("Problema 4")
source("auxiliares/dec2bin.R")
#Calcular la representación binaria (con 16 bits) y hexadecimal de 2001.
# Solución

x<- c(0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1)
v<-0
for (ix in 1:length(x)){
  v<-v+x[ix]*2^(length(x)-ix)
}

y<- dec2bin(2001,16)

if (all(x==y) && (v==2001) ){
  print(x)
} else {
  print("error")  
}

print(as.hexmode(2001))

print("Problema 5")
source("auxiliares/bin2dec.R")
#La representación binaria  de n es 1 1 0 1 1. Calcular su representación
#decimal y hexadecimal.
# Solución
x <- c(1, 1, 0, 1, 1)
v<-0
for (ix in 1:length(x)){
  v<-v+x[ix]*2^(length(x)-ix)
}
y<- bin2dec(x)
if (v==y){
  print(v)  
}

print(as.hexmode(v))

print("Problema 6")
#La representación hexadecimal de n es ``e1''. Calcular su representación 
#decimal y binaria (10 bits).
# Solución
print(as.integer(as.hexmode("e1")))

# 225 = 0*2^9+0*2^8+1*2^7+1*2^6+1*2^5+0*2^4+0*2^3+0*2^2+0*2^1+1*2^0
x<- c(0,0,1,1,1,0,0,0,0,1)

y<-dec2bin(as.integer(as.hexmode("e1")),10)

if (all(x==y)){
  print(x)
} else {
  print("error")
}

print("Problema 7")
source("auxiliares/men2num.R")
source("auxiliares/num2men.R")
source("auxiliares/men2bit.R")
source("auxiliares/bit2men.R")
#Utilizando el alfabeto inglés de 26 letras y el espacio:
#A, B, ..., Z,`` ''
#y suponiendo que los mensajes se parten en bigramas:
#a) Calcular el equivalente numérico del mensaje ``EJERCICIOS DE FUNCIONES''.
#b) Calcular el equivalente binario del mensaje  ``SON FACILES''.
#c) Obtener el mensaje cuyo equivalente numérico es
#   121 74 121 530 404 297 720 389 542 230 377
#d) Obtener el mensaje cuyo equivalente binario es
#   0 0 1 1 0 0 0 0 0 1 1 0 1 0 1 1 1 1 1 0 0 0 0 0 1 1 0 1 1 0 0 0 0 0 0 1 1 0
#    1 1 0 0 0 1 0 1 1 1 1 1
#Solución

alfabeto <- c(LETTERS," ")
m1 <- men2num(alfabeto, "EJERCICIOS DE FUNCIONES", 2)
print(m1)
m2 <- men2bit(alfabeto, "SON FACILES", 2)
print(m2)
m3<-num2men(alfabeto, c(121, 74, 121, 530, 404, 297, 720, 389, 542, 230, 377), 2)
print(m3)
m4<-bit2men(alfabeto, c(0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1), 2)
print(m4)