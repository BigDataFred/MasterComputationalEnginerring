
print("Problema 1")
# a) Demostrar que existe 207^{-1} mod 1000.
# b)  Resolver la ecuación: 207x= 10  mod 1000.
#Solución
#a)
source("aritmod/euclides.R")
euclides(207, 1000)
#1
print("mcd(207, 1000)=1. Por tanto, existe 207^{-1} mod 1000.")
#b)
#207x=10  mod 1000 si y sólo si x=207^{-1}*10 mod 1000.
source("aritmod/invmod.R")
x <- (invmod(207, 1000)*10)%%1000
print(x)
#430

print("Problema 2")
# a) Demostrar que existe 357^{-1} mod 1210.
if (euclides(357,1210)==1){
  print("mcd(357, 1210)=1. Por tanto, existe 357^{-1} mod 1210.")
}

# b)  Resolver la ecuación: 357x=2  mod 1210.
x <- (invmod(357, 1210)*2)%%1210
print(x)
# 766
# c) Calcular 357^{10} mod 1210 y 357^{-10} mod 1210$.
#Solución
print( potmod(357,10,1210) )
#419
print( "357^{-10} no es un numero entero positivo, por lo tanto no se puede calcular a^{x} mod n" )

print("Problema 3")
#a) Demostrar que p=1925, q=1728 son primos relativos.
p=1925
q=1728

# sean a, b numeros enteros.
a<-3
b<-5

# calculamos los inversos de q y p
q1 = invmod(q,p)
p1 = invmod(p,q)

# calculamos x 
x<-(q*q1*a+p*p1*b) %%n #x ≡ (qq1a + pp1b) mod n,

print("Si p y q son primos relativos, existe un unico (mod n) entero x tal que x ≡ a mod p, x ≡ b mod q")
print( paste("x ≡ a mod p", x == a+x%/%p*p)  )
print( paste( "x ≡ b mod q",x == b+x%/%q*q)  )
print("Como  x ≡ a mod p y x ≡ b mod q, podemos decir que p y q son primos relativos")

#b) Resolver:
#x = 48  mod 1925 
#x = 148  mod 1728
#Solución:
source("aritmod/tchino.R")
print( tchino(c(48,148),c(1925,1728)))
