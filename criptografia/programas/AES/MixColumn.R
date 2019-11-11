source("AES/bytesprod.R")
#bytesprod llama a xorbit.R
MixColumn <- function(estado, inverse)
  #Esta funcion implementa:
  #MixColumn cuando inverse=0
  #InvMixColumn cuando inverse=1
  #Transforma cada columna de la matriz de estado.
  #Efectua el producto modulo M(x) = x^4 + 1 de cada palabra por el polinomio
  #c(x) = 03x^3 + 01x^2 + 01x + 02 (si inverse=0)
  #d(x) = 0Bx^33 + 0Dx^2 + 09x + 0E (si inverse=1)
  #Entrada: estado (matriz 4x4 de bytes expresados en decimal)
  #Salida:  matriz 4x4 de bytes expresados en decimal que representa
  #         el estado despues de la transformacion.
  {
    #Chequeos
    if((any(estado < 0))|(any(estado > 255))){stop("El parametro de entrada estado debe ser una matriz de bytes expresados en decimal")}
    if(is.matrix(estado)==FALSE|any(dim(estado)!=4)){stop("El parametro de entrada estado debe ser una matriz 4x4")}
    if((inverse !=0)&(inverse !=1)){stop("El parametro de entrada inverse debe ser 0 o 1")}

    #Codigo
    if(inverse==0)
      {
        mat=matrix(c(2,1,1,3,3,2,1,1,1,3,2,1,1,1,3,2), ncol=4)
      }
     if(inverse==1)
      {
        mat=matrix(c(14,9,13,11,11,14,9,13,13,11,14,9,9,13,11,14), ncol=4)
      }
    estado.out <- matrix(nrow=4,ncol=4)
    for(j in 1:4)
      {
        for(i in 1:4)
          {
            estado.out[i,j] <- 0
            k <- 1
            while(k <5)
              {
                estado.out[i,j] <-xorbit( estado.out[i,j], bytesprod(mat[i, k], estado[k,j]))
                k <- k+1
               }
            
          }
      }
    return(estado.out)
  }
  
 
