source("AES/xorbit.R")
AddRoundKey <- function(estado, clave)
  #Entrada: estado (matriz 4x4 de bytes expresados en decimal)
  #         clave (matriz 4x4 de bytes expresados en decimal)
  #Salida: matriz 4x4 de bytes expresados en decimal calculados a partir de
  #         la suma XOR bit a bit de estado y clave
  {
    #Chequeos
    if((any(estado < 0))|(any(estado > 255))){stop("estado debe ser un vector de bytes expresado en decimal")}
    if((any(clave < 0))|(any(clave > 255))){stop("clave debe ser un vector de bytes expresados en decimal")}
    if(is.matrix(estado)==FALSE|any(dim(estado)!=4)){stop("estado debe ser una matriz 4x4")}
    if(is.matrix(clave)==FALSE|any(dim(clave)!=4)){stop("clave debe ser una matriz 4x4")}

    #Codigo
    estado.out <- xorbit(estado, clave)
    estado.out <- matrix(estado.out, nrow=4)
    return(estado.out)
  }
