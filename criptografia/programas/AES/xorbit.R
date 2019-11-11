source("auxiliares/bin2dec.R")
source("auxiliares/dec2bin.R")
xorbit <- function(a,b)
  #Entrada: a, b vectores de bytes expresados en decimal.
  #Salida: vector de bytes expresados en decimal, calculados a partir
  #        de la suma XOR bit a bit de los bytes de a y b.
  #a, b deben tener la misma longitud.
  {
     #Chequeos
    if((any(a < 0))|(any(a > 255))){stop("a debe ser un vector de bytes expresado en decimal")}
    if((any(b < 0))|(any(b > 255))){stop("b debe ser un vector de bytes expresados en decimal")}
    if(length(a)!=length(b)){stop("a y b tienen que tener la misma longitud")}

    #Codigo
    sumaxor <- c()
    for(j in 1: length(a))
          {
            aux<- (dec2bin(a[j], 8)+ dec2bin(b[j], 8))%%2
            sumaxor[j] <- bin2dec(aux)
          }
    return(sumaxor)
  }
