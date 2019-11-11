
source("AES/SubByte.R")
source("AES/RotByte.R")
source("AES/xorbit.R")
KeyExpansion <- function(claveinicial)
  #Implementa el bloque de KeyExpansion del AES.
  #Expande la clave de cifrado inicial de 16 bytes
  #Devuelve la clave expandida de 44*4 bytes en formato decimal.
  #Utiliza las  funciones SubByte(), RotByte(), xorbit() y las constantes Rcon 
  #La clave inicial esta formada por 16 bytes expresados en hexadecimal.
  #Entrada: Claveinicial (vector de 16 bytes expresados en hexadecimal)
  #Salida:  Claveexpandida (matriz 4x44 de bytes expresados en decimal.
  #Cada columna de la matrz es una palabra (4 bytes))
{
   #Chequeos
   if(class(claveinicial)!="hexmode"){stop("El parametro de entrada clave inicial debe ser un vector de bytes expresados en hexadecimal")}

  if(length(claveinicial)!=16){stop("El parametro de entrada clave inicial debe tener 16 bytes")}

  #Codigo
   
  #Inicializamos Rcon
  Rcon <- c(1, 2, 4, 8, 16, 32, 64, 128, 27, 54)
  Rcon <- matrix(c(Rcon, rep(0, 30)), nrow=4, byrow=4)

  #Inicializamos W
  W <- matrix(nrow=4, ncol=44)
   
  
  }
