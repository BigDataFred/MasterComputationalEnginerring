source("auxiliares/num2men.R")
source("auxiliares/men2num.R")
decRSA <- function(p, q, d, alfabeto, cifrado, k, l)
  # Descifrado RSA de un mensaje de texto sin utilizar el teorema chino del resto
  # Entrada: p, q, d: clave privada
  #          alfabeto 
  #          cifrado (mensaje cifrado)
  #          k: número de letras de los bloques de mensaje en claro
  #          l: número de letras de los bloques de mensaje cifrado
  # Salida:  mensaje en claro
  {
    N <- length( alfabeto)
    if (N^{k}>n){stop("n debe ser >=N^{k}")}
    if (N^{l}<n){stop("n debe ser <=N^{l}")}
    D <- {}
    for (ix in 1:length(cifrado)){
      l <- nchar(cifrado[ix])
      c<- men2num( alfabeto, cifrado[ix] ,l )
      tmp <- decRSAnum(p, q, d, c)
      m<-num2men(alfabeto, tmp, k)
      D <- c(D,m) 
    }
    return(D)
}
