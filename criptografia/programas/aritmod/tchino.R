
source("aritmod/invmod.R")
tchino <- function(a,p)
   # Entrada: a (vector de enteros)
   #          p (vector de enteros primos dos a dos)
   # Salida: (x,n)
   #          x es congruente con a[i] módulo p[i]
   #          n=prod(p)
  {
    #Chequeos
    n <- prod(p)
    l <- length(p)
    #Comprobamos que los elementos de p son primos dos a dos
    for(i in 1: (l-1))
      {
        for(j in (i+1):l)
          {
            d <- euclidesext(p[i], p[j])[1]
            if(d!=1){stop("los elementos de p no son primos relativos")}
          }
      }
    
    #Código
    x<-0
    for (ix in 1:l){
      
      y<-invmod(n/p[ix],p[ix]) # calculamos a^{-1} (mod n) 
      x <- ( x + (n/p[ix]) * y*a[ix] )%%n # sumando x
    }
    out<-c(x,n)
    return(out)
  }

  
