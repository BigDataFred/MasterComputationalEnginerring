source("auxiliares/num2men.R")
source("auxiliares/men2num.R")
cifRSA <- function(n, e, alfabeto, mensaje, k, l)
  #Cifrado RSA de un mensaje de texto
  # Entrada: n, e: clave pública
  #          alfabeto 
  #          mensaje en claro
  #          k: número de letras de los bloques de mensaje en claro
  #          l: número de letras de los bloques de mensaje cifrado
  # Salida:  mensaje cifrado
  {
    N <-length(alfabeto)
    if (N^{k}>n){stop("n debe ser >=N^{k}")}
    if (N^{l}<n){stop("n debe ser <=N^{l}")}
    M<-men2num(alfabeto,mensaje,k)
    C <-{}
    for (ix in 1:length(M)){
      tmp<- cifRSAnum(n,e, M[ix])
      C <- c(C,num2men(alfabeto, tmp, l))
    }
    return(C)
  }

