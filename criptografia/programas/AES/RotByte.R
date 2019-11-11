RotByte <- function(palabra)
  #Dada una palabra (vector de 4 bytes), realiza una permutación cíclica a la
  #izquierda de los bytes.
  #Entrada: palabra (vector de 4 bytes).
  #Salida: vector de 4 bytes obtenido realizando una permutación cíclica a la
  #        izquierda de los bytes de palabra.
  {
    #Chequeo
    if(length(palabra)!=4){stop("El parametro de entrada palabra  debe tener 4 bytes")}
    #Codigo
    palabra.out <- palabra[c(2, 3, 4, 1)]
    return(palabra.out)
  }
