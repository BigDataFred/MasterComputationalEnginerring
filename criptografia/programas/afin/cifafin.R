source("aritmod/euclides.R")
source("auxiliares/men2num.R")
source("auxiliares/num2men.R")

cifafin <- function(alfabeto, mensaje, k,  a, b)
# Entrada: alfabeto 
#          mensaje 
#          k, a, b (enteros, k>0, a primo relativo con N=length(alfabeto))
# Salida:  mensaje cifrado partiendo el mensaje en k-gramas y
#            con una transformación afín de clave (a, b).
  {
    #Chequeo
    N <- length(alfabeto)
    if(k<=0){stop("k debe ser positivo")}
    if(euclides(a, N)!=1){stop("(a, N) deben ser  primos relativos")}

    #Código
  
  }
