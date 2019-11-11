
source("AES/xtime.R")
source("AES/xorbit.R")

bytesprod <- function(a, b)
  #Entrada: a, b (bytes expresado en decimal).
  #Salida : byte expresado en decimal, calculado a partir del  
  #         producto de los bytes a y b en el cuerpo GF(2^8)
  #         generado por el polinomio irreducible
  #         m(x)=x^8+x^4+x^3+x+1.
  
  {

  #Chequeo
    if((a<0)|(a > 255)){stop("a debe ser un  byte expresados en decimal")}
    if((b<0)|(b > 255)){stop("b debe ser un  byte expresados en decimal")}
    
  #Codigo
    a <- dec2bin(a,8)
    ab <-0
    if(a[8]==1){ab <- b}
    for(i in 7:1)
      if(a[i]==1)
        {
          x <- b
          for(j in 1:(7-i+1))
            {
            y <- xtime(x)
            x<- y
            }
          ab <- xorbit(ab, y)
        }
    return(ab)
  }
      
      
   
  
