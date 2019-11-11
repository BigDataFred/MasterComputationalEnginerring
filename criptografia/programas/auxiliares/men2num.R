source("auxiliares/evalpol.R")

men2num <- function(alfabeto, mensaje, k)
# Entrada: alfabeto 
#          mensaje 
#          k (entero, k>0)    
# Salida:  vector con los equivalente numéricos de los k-gramas
#          en que queda partido el mensaje (si el número de
#          caracteres del mensaje no es múltiplo de k, se añade
#          la última letra del alfabeto tantas veces como sea necesario)
  {
    #Código
    
    #Dividimos el mensaje en bloques
    N <- length(alfabeto)
    n <- nchar(mensaje)
    if(n%%k!=0)
      {
        for(i in 1:(k-(n%%k))){mensaje <- paste(mensaje, alfabeto[N], sep="")}
      }
    n <- nchar(mensaje)
    numerobloques <- n/k
    bloques <- rep(NA, numerobloques)
    for(i in 1: numerobloques)
      {
        bloques[i] <- substr(mensaje, 1+(i-1)*k, i*k)
      }
    #Calculamos el equivalente numérico de cada bloque
     numbloques <- rep(NA, numerobloques)
     for(i in 1: numerobloques)
       {
         #Para cada bloque, transformamos cada letra en su número correspondiente en el alfabeto
         numeros <- rep(0, k)
         for (j in 1:k)
           {
             numeros[j] <- grep(substr(bloques[i],j,j), alfabeto)-1
           }
             numbloques[i] <- evalpol(numeros, N)
        }
       return(numbloques)

    }
