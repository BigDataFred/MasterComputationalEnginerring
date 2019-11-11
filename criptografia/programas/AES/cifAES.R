source("AES/KeyExpansion.R")
source("AES/AddRoundKey.R")
source("AES/ByteSub.R")
source("AES/ShiftRow.R")
source("AES/MixColumn.R")
cifAES <- function(mensaje, claveinicial)
  #Cifrado AES
  #Entrada: mensaje (vector de 16 bytes expresados en hexadecimal
  #                  que representa el mensaje en claro).
  #         claveinicial (vector de 16 bytes)
  #Salida: vector de 16 bytes expresados en hexadecimal que representa 
  #        el mensaje cifrado).     
  {
    #Chequeos
    if(class(mensaje)!="hexmode"){stop("El parametro de entrada mensaje debe ser un vector de bytes expresados en hexadecimal")}

    if(class(claveinicial)!="hexmode"){stop("El parametro de entrada clave inicial debe ser un vector de bytes expresados en hexadecimal")}

    if(length(mensaje)!=16){stop("El parametro de entrada mensaje debe tener 16 bytes")}
    
    if(length(claveinicial)!=16){stop("El parametro de entrada clave inicial debe tener 16 bytes")}

    #Codigo


  }
