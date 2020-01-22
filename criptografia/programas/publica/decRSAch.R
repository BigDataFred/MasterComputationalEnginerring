
decRSAch <- function(p, q, d, alfabeto, cifrado, k, l)
  #Descifrado RSA de un mensaje de texto utilizando el teorema chino del resto
  # Entrada: p, q, d: clave privada
  #          alfabeto 
  #          cifrado (mensaje cifrado)
  #          k: número de letras de los bloques de mensaje en claro
  #          l: número de letras de los bloques de mensaje cifrado
  # Salida:  mensaje en claro
  {
  #N <- length( alfabeto)
  #if (N^{k}>p){stop("p debe ser >=N^{k}")}
  #if (N^{l}<p){stop("p debe ser <=N^{l}")}
  D <- {}
  for (ix in 1:length(cifrado)){
    c<- men2num( alfabeto, cifrado[ix],l )
    v <- decRSAnumch(p, q, d, c)
    m<-num2men(alfabeto, v, k)
    D <- c(D,m)
  }
  return(D)
}
