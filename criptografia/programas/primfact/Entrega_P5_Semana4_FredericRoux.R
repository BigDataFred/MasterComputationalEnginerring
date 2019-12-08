# 2. Primalidad
#################################
# 2. Test de primalidad de Miller-Rabin
source("primfact/milrab.R")
print("Miller-Rabin")

res<-milrab(13,1)
print(res)
res<-milrab(25,1)
print(res)

res<-milrab(41353,1)
print(res)
res<-milrab(38737,1)
print(res)

#3. Algoritmos de factorizacion
#################################
#3.1. Metodo rho de Pollard
source("primfact/pollard.R")
print("Pollard")

#EJERCICIOS:
#1. Probar la funcion con ejemplos sencillos: 21, 35, . . . .
n<-21
pol <- c(1,0,5) # x^2+5 
x0<-2
N<- 1000000
f<-pollard(n,pol,x0,N)  
out<-sprintf("%d -> f1: %d, f2:%d",n,f[1],f[2])
print(out)

n<-35
pol <- c(0,1,2) # x^2+2 
x0<-1
N<- 1000000
f<-pollard(n,pol,x0,N)
out<-sprintf("%d -> f1: %d, f2:%d",n,f[1],f[2])
print(out)

#2. Factorizar n1 = 455459, n2 = 4087.
n<-455459
pol <- c(1,0,2) # x^2+2 
x0<-1
N<- 1000000
f<-pollard(n,pol,x0,N)
out<-sprintf("%d -> f1: %d, f2:%d",n,f[1],f[2])
print(out)

n<-4087
pol <- c(1,0,5) # x^2+2 
x0<-1
N<- 1000000
f<-pollard(n,pol,x0,N)
out<-sprintf("%d -> f1: %d, f2:%d",n,f[1],f[2])
print(out)

# 3.2. Metodo de factorizacion de Fermat
source("primfact/fermat.R")
print("Fermat")

#EJERCICIOS
#1. Probar la funcion con ejemplos sencillos: 21, 35, . . . .
n<-21
N<- 1000000
f<-fermat(n,N)
out<-sprintf("%d -> f1: %d, f2:%d",n,f[1],f[2])
print(out)

n<-35
N<- 1000000
f<-fermat(n,N)
out<-sprintf("%d -> f1: %d, f2:%d",n,f[1],f[2])
print(out)


# 2. Factorizar n1 = 455459, n2 = 200819, n3 = 141467.
n1<-455459
N<- 1000000
f<-fermat(n1,N)
out<-sprintf("%d -> f1: %d, f2:%d",n1,f[1],f[2])
print(out)

n2<-200819
N<- 1000000
f<-fermat(n2,N)
out<-sprintf("%d -> f1: %d, f2:%d",n2,f[1],f[2])
print(out)

n3<-141467
N<- 1000000
f<-fermat(n3,N)
out<-sprintf("%d -> f1: %d, f2:%d",n3,f[1],f[2])
print(out)