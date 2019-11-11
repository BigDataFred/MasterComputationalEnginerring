
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
# b)  Resolver la ecuación: 357x=2  mod 1210.
# c) Calcular 357^{10} mod 1210 y 357^{-10} mod 1210$.
#Solución



print("Problema 3")
#a) Demostrar que p=1925, q=1728 son primos relativos.
#b) Resolver:
#x = 48  mod 1925 
#x = 148  mod 1728
#Solución:
