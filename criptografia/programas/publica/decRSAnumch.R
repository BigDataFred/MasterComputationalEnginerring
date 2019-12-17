source("aritmod/invmod.R")
source("aritmod/potmod.R")
source("aritmod/tchino.R")
decRSAnumch <- function(p, q, d, C)
  # Descifrado RSA utilizando el Teorema chino del resto
  # Entrada: p, q, d (clave privada RSA)
  #          C (equivalente numérico del mensaje cifrado)
  # Salida: M (equivalente numérico del mensaje en claro)         
  {
    
    dp<-d%%(p-1)
    dq<-d%%(q-1)
    p1<- invmod(p,q)
    q1<-invmod(q,p)
    c1<-q*q1
    c2<-p*p1
    
    Cp <- C%%p
    Cq <- C%%q
    M1 <- potmod(Cp,d*p,p)
    M2 <- potmod(Cq,d*q,q)
    M<-(c1*M1+c2*M2)%%(p*q)
    return(M)
  }



  
