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
    Nb <- length( cifrado )*8/32
    Nk <- length( claveinicial )*8/32
    n<-10
    
    W <- KeyExpansion( claveinicial )
    
    estado <-matrix(nrow=4,ncol=Nb) 
    selIx <-seq(1,Nb,1)
    for (ix in 1:Nb){
      estado[,ix] <- cifrado[selIx]
      selIx<-selIx+Nb
    }
    
    clave.ronda<-W[,seq(n*Nb+1,(n+1)*Nb,1)] 
    
    estado<-AddRoundKey(estado,clave.ronda)
    
    for (i in 1:n){
      clave.ronda<-W[,seq(n*Nb+1,(n+1)*Nb,1)-((i+1-1)*Nb)]
      estado <- ByteSub(estado,1)
      estado <- ShiftRow(estado,1)
      if (i != n){
        estado <- MixColumn(estado,1)
        clave.ronda <- MixColumn(clave.ronda,1)
      }
      estado <- AddRoundKey(estado,clave.ronda)
    }
    mensaje <- as.hexmode(estado)
    return(mensaje)
}





