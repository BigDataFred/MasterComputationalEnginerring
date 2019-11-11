
source("AES/SubByte.R")
ByteSub <- function(estado, inverse)
   #Proporciona la salida de las cajas ByteSub e InvByteSub del AES que realizan 
   #una substitucion no lineal usando una tabla de substitucion.
   #La tabla de substitucion depende del valor de inverse.
   #Esta funcion implementa:
   #ByteSub cuando inverse=0
   #InvByteSub cuando inverse=1
   #Entrada: estado (matriz 4x4  de bytes expresados en decimal)
   #          inverse: 0 o 1.
   #Salida: matriz 4x4 de bytes  expresados en hexadecimal
   #        despues de aplicarles la substitucion.
   #        si inverse=0, se aplica S-Box
   #        si inverse=1, se aplica Inv_S-Box
  {
    #Chequeos
    if(is.matrix(estado)==FALSE|any(dim(estado)!=4)){stop("El parametro de entrada estado debe ser una matriz 4x4")}



    #Codigo
    estado.out <- matrix(SubByte(estado, inverse), nrow=4)
    return(estado.out)
  }
