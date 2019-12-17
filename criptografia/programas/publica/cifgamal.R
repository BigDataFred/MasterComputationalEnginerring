source("auxiliares/men2num.R")
source("auxiliares/num2men.R")
cifgamal <- function(p, g, y, alfabeto, mensaje, k, l)
#Cifrado ElGamal de un mensaje de texto
# Entrada: p (primo)
#          g (generador de ZZ_p^*)
#          y (clave pública del receptor)          
#          alfabeto 
#          mensaje 
#          k, l (enteros positivos)  
# Salida:  mensaje cifrado 
  {
    N <-length(alfabeto)
    if (N^{k}>p){stop("p debe ser >=N^{k}")}
    if (N^{l}<p){stop("p debe ser <=N^{l}")}
    M <- men2num(alfabeto, mensaje, k)
    C <-{}
    for (ix in 1:length(M)){
      while (TRUE){
        tmp<- cifgamalnum(p, g, y, M[ix])
        if (all(tmp<=N^{l})){
          break
        }
      }
      C <- c(C,num2men(alfabeto, tmp, l))
    }
    return(C)
  }

