source("auxiliares/cambiobase.R")

num2men <- function(alfabeto, v, k) 
# Entrada: alfabeto 
#          v (vector de números enteros)
#          k (entero, k>0)    
# Salida:  mensaje tal que al dividirlo en k-gramas, cada k-grama
#           corresponde a la respectiva componente del vector v 
  {  
    #Chequeo
     N <- length(alfabeto)
    if(any(v>=N^k)){stop("alguna componente de v es demasiado grande")}  

    #Código
    N <- length(alfabeto)
    l <- length(v)
    mensaje <- ""
    for(i in 1:l)
      {
        bloque <- ""
        aux <- cambiobase(v[i],N)
        if(length(aux)<k){aux <- c(rep(0, k-length(aux)), aux)}
        for(j in 1:k)
          {
            bloque <-paste(bloque, alfabeto[aux[j]+1], sep="")
          }
       mensaje <- paste(mensaje, bloque, sep="")
      }
    return(mensaje)
   
  }
