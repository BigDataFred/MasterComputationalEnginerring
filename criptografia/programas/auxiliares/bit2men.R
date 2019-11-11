source("auxiliares/bin2dec.R")
source("auxiliares/num2men.R")

bit2men <- function(alfabeto, menbit, k)
  # Función inversa de men2bit()
  # Cada bloque de bits se decodifica en un k-grama
  # Entrada: alfabeto
  #          menbit (vector de bits)
  #          k (entero k>0)
  # Salida: mensaje
  {
    # Código  
    N=length(alfabeto)
    longbits=floor(log(N^k-1,base=2))+1
    l=length(menbit)
    r=l%%longbits
    if(r!=0)
    {
      menbit = c(menbit, rep(0, r))
    }
    numbloque=(l+r)/longbits
    mensaje=""
    for(i in 1:numbloque)
      {
      auxdec=bin2dec(menbit[((i-1)*longbits+1):(i*longbits)])
      auxmen=num2men(alfabeto, auxdec, k) 
      mensaje=paste(mensaje,auxmen, sep="")
    }
    return(mensaje)
  }
