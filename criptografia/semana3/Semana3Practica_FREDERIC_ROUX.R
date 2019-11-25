
######################################
# Practica Semana 3 Frédéric Roux
######################################

# 2 Cifrado de Vernam
source("flujo/vernam.R")
m <- c(0, 1, 1, 0, 1, 0, 0, 1)
clave1 <- c(1, 1, 1, 1, 0)
#c1 <- vernam(m, clave1)

chck <- c(1, 0, 0, 1, 1, 0, 1, 1)
clave2 <- c(1, 1, 1, 1, 0, 0, 1, 0, 1, 1, 0)
c2 <- vernam(m, clave2)
print("Solucion Ejercicio 2.1:")
print( c2 )
print(all(c2==chck))

chck<- c(0, 1, 1, 0, 1, 0, 0, 1)
mdec<-vernam(c2, clave2)
print("Solucion Ejercicio 2.2:")
print(mdec)
print(all(mdec==chck))


# 3 Registros de desplazamiento (LSFRs)
LFSR <- function(cD,s0,n){
  s <- s0
  L <-length(s0)
  #out <- NULL
  #out <- rbind(out,s0)
  cIx <- which(cD==1)
  #k<-2
  j<-length(s)+1
  while (TRUE){
    #tmp<-vector(length=L)
    #tmp[1]<- sum(out[k-1,cIx])%%2
    #tmp[2:L]<-out[k-1,1:L-1]
    #out <- rbind(out,tmp)
    s <- c(s,sum(s[j-cIx])%%2)
    if (length(s) ==n){ # all(out[k,] ==s0)
      return(s[1:n])
    }
    #k<-k+1
    j<-j+1
  }
}

# EJERCICIOS
chck<-c(0,1,1,0,0,1,0,0,0,1,1,1,1,0,1)#Solucion 
c1 <- c(1,0,0,1)
s0<-c(0,1,1,0)
out<-LFSR( c1, s0, length(chck) )
print("Solucion Ej 3.1:")
print(out)
print(all(out==chck))

chck <- c(0,0,1,1,1,1,0,1,0,1,1,0,0,1,0)#Solucion 
c2 <- c(1,0,0,1)
s0<-c(0,0,1,1)
out<-LFSR( c2, s0, length(chck) )
print("Solucion Ej 3.2:")
print(out)
print(all(out==chck))

chck <- c(0,0,1,1,0,1,1,1,0,1,0,1,0,0,0,0,1,0,0,1,0,1,1,0,0,1,1,1,1,1,0)#Solucion 
c3 <- c(0,0,1,0,1)
s0<-c(0,0,1,1,0)
out<-LFSR( c3, s0, length(chck) )
print("Solucion Ej 3.3:")
print(out)
print(all(out==chck))

chck <- c(0,0,1,1,0,0,1)#Solucion 
c4 <- c(1,1,1)
s0<-c(0,0,1)
out<-LFSR( c4, s0, length(chck) )
print("Solucion Ej 3.4:")
print(out)
print(all(out==chck))


# 4 Cifrado de Vernam utilizando una secuencia generada por un LFSR
#EJERCICIO
source("auxiliares/men2bit.R")
source("auxiliares/bit2men.R")
source("flujo/vernam.R")

cifvernam <- function(alfabeto,mensaje,k,cD,s0){
  b <- men2bit(alfabeto,m,k)
  nb <- length(b)
  clave<-LFSR(cD,s0,nb)
  C <- vernam(b, clave)
  return(C)
}

m<-"PRUEBA"
alfabeto<-LETTERS
cD<-c(0,0,1,0,1)
s0<-c(0,0,1,1,0)
k<-1
chck <- c(0,1,0,0,1,0,1,1,0,0,1,1,1,0,0,0,1,1,0,1,0,1,1,0,1,1,1,1,1,1)#Solucion 
C<-cifvernam(alfabeto, m, k, cD, s0)
print("Solucion Ej 4.1:")
print(C)
print(all(C==chck))

#EJERCICIO
decvernam <- function(alfabeto, b, k, cD, s0){
  nb <- length(b)
  clave<-LFSR(cD,s0,nb)
  mdec <- vernam( b, clave)
  M <- bit2men(alfabeto, mdec,k)
  return(M)
}

cD <- c(0,0,1,0,1)
s0<-c(0,0,1,1,0)
cif1 <-c(0,1,0,0,1,0,1,1,0,0,1,1,1,0,0,0,1,1,0,1,0,1,1,0,1,1,1,1,1,1)
cif2 <-c(1,0,1,0,0,0,1,0,0,1,0,0,1,1,1,0,1,1,0,1,1,1,1,0,1,1,1,1,1,1,0,0,0,0,0,0,1,1,1,0)
alfabeto <- LETTERS
k<-1 

M1<-decvernam(alfabeto, cif1, k, cD, s0)
M2<-decvernam(alfabeto, cif2, k, cD, s0)

print("Solucion Ej 4.2:")
print(paste(M1,M2,sep=" "))

######################################
# Preguntas Quizz Semana 3
######################################
cD <- c(1,0,1,1)
s0 <- c(0,1,1,1)
s <- LFSR(cD,s0,15)


s0<-c(0, 1, 1, 1 )
cD1 <- c(0,0,1,1)
cD2 <- c(1,0,0,1)
cD3 <- c(0,1,0,1)

s1 <- LFSR(cD1,s0,8)
s2 <- LFSR(cD2,s0,8)
s3 <- LFSR(cD3,s0,8)

b <- c(1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0)
