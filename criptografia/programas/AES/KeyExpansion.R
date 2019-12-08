
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
   Nk <- length(claveinicial)*8/32
   Nb <- length(claveinicial)*8/32
   n<-10
   for (i in 1:Nk){ #Paso 1. Para i = 1; : : : ;Nk
     #Paso 1.1. Hacer W[ ; i] = claveinicial[(4(i - 1) + 1) : (4i)].
     W[,i] <- strtoi(claveinicial[(4*(i-1)+1):(4*i)],base=16L)
   }
   for (i in seq(Nk+1,Nb*(n+1),1) ){#{Paso 2. Para i = Nk + 1; : : : ;Nb(n + 1)
    tmp<-W[,i-1] #Paso 2.1. Hacer tmp = W[ ; i - 1]
    if ( (i%%Nk == 1%%Nk) & (((i-1)%%Nk)==0) ){#Paso 2.2. Si i= 1 mod Nk
      #Paso 2.2.1. Hacer tmp = SubByte(RotByte(tmp)) XOR+ Rcon[ ; (i - 1)/Nk].
      tmp<-xorbit( SubByte(RotByte(tmp),0), Rcon[,(i-1)/Nk]) 
    }
    W[,i]<-xorbit(W[,i-Nk],tmp) #Paso 2.3. Hacer W[ ,i] = W[ ,i-Nk] XOR+ tmp
   }  
   return(W) #Paso 3. Salida W.
  }
