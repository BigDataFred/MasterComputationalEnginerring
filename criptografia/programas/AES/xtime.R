source("auxiliares/dec2bin.R")
source("auxiliares/bin2dec.R")

xtime <- function(a)
  #Entrada: a (byte expresado en decimal).
  #Salida : byte expresado en decimal, calculado a partir del 
  #         producto del byte a por x ("02") en el cuerpo GF(2^8) 
  #         generado por el polinomio irreducible
  #         m(x)=x^8+x^4+x^3+x+1.
  {

  #Chequeo
   if((a<0)|(a > 255)){stop("a debe ser un  byte expresados en decimal")}
    
  #Codigo
    m <- c(1,0,0,0,1,1,0,1,1)
    abin <- dec2bin(a, 8)
    prodbin <- c(abin, 0)
    if(prodbin[1]==1){prodbin <- (prodbin+m)%%2}
    prod <- bin2dec(prodbin)
    return(prod)
  }
