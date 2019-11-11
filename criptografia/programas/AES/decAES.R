source("AES/KeyExpansion.R")
source("AES/AddRoundKey.R")
source("AES/ByteSub.R")
source("AES/ShiftRow.R")
source("AES/MixColumn.R")
decAES <- function(cifrado, claveinicial)
  #Descifrado AES
  #Entrada: cifrado (vector de 16 bytes expresados en hexadecimal
  #                  que representa el mensaje cifrado).
  #         claveinicial (vector de 16 bytes)
  #Salida: vector de 16 bytes expresados en hexadecimal que representa 
  #        el mensaje en claro).     
  {
    #Chequeos
    if(class(cifrado)!="hexmode"){stop("El parametro de entrada cifrado debe ser un vector de bytes expresados en hexadecimal")}

    if(class(claveinicial)!="hexmode"){stop("El parametro de entrada clave inicial debe ser un vector de bytes expresados en hexadecimal")}

    if(length(cifrado)!=16){stop("El parametro de entrada cifrado debe tener 16 bytes")}
    
    if(length(claveinicial)!=16){stop("El parametro de entrada clave inicial debe tener 16 bytes")}

    #Codigo

  }
