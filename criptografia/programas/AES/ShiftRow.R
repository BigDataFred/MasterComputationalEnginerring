ShiftRow <- function(estado, inverse)
  #Desplaza ciclicamente las filas de la matriz de estado.
  #La direccion viene marcada por el valor de inverse.
  #Esta funcion implementa:
  #ShiftRow cuando inverse=0 (desplazamiento a izquierda)
  #InvMixColumn cuando inverse=1 (desplazamiento a derecha)
  #Entrada: estado (matriz 4x4 de bytes expresados en decimal)
  #Salida: matriz 4x4 de bytes expresados en decimal que representa
  #         el estado despues de la transformacion.
  {
    #Chequeos
    if((any(estado < 0))|(any(estado > 255))){stop("El parametro de entrada estado debe ser una  matriz de bytes expresados en decimal")}
    if(is.matrix(estado)==FALSE|any(dim(estado)!=4)){stop("El parametro de entrada estado debe ser una  matriz 4x4")}
    if((inverse !=0)&(inverse !=1)){stop("El parametro de entrada inverse debe ser 0 o 1")}

    #Codigo
    estado.out <- estado
    if(inverse==0)
      {
        estado.out[2, ] <- estado.out[2, c(2, 3, 4, 1)]
        estado.out[3, ] <- estado.out[3, c(3, 4, 1, 2)]
        estado.out[4, ] <- estado.out[4, c(4, 1, 2, 3)]
      }
    if(inverse==1)
      {
        estado.out[2, ] <- estado.out[2, c(4, 1, 2, 3)]
        estado.out[3, ] <- estado.out[3, c(3, 4, 1, 2)]
        estado.out[4, ] <- estado.out[4, c(2, 3, 4, 1)]
      }
    return(estado.out)
  }
