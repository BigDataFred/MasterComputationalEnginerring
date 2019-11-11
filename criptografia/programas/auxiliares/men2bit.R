source("auxiliares/men2num.R")
source("auxiliares/dec2bin.R")

men2bit <- function(alfabeto, mensaje, k)
  # Entrada: alfabeto
  #          mensaje 
  #          k (entero k>0)
  # Salida: vector con el equivalente binario de los k-gramas
  #         en que queda partido el mensaje (si el número de
 #          caracteres del mensaje no es múltiplo de k, se añade
 #          la última letra del alfabeto tantas veces como sea necesario)
  {
    # Código  
    N=length(alfabeto)
    equivnum = men2num(alfabeto, mensaje, k)
    m=length(equivnum)
    longbits=floor(log(N^k-1,base=2))+1
    menbits=c()
    for(i in 1:m)
      {
        auxbin = dec2bin(equivnum[i],longbits)
        menbits=c(menbits, auxbin)
      }
    return(menbits)
  }
