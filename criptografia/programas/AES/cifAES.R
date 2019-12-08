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
    Nk <- length( claveinicial )*8/32
    Nb <- length( mensaje )*8/32
    n<-10
    # Paso 1. Calcular las clave expandida W a partir de claveinicial.
    W<-KeyExpansion(claveinicial) 
    
    # Paso 2. Copiar en sentido columnas mensaje en la matriz estado (matriz 4 x Nb) (las 4 primeras 
    # componentes de mensaje formaran la primera columna de estado, las 4 siguientes, la segunda, etc).
    estado <-matrix(nrow=4,ncol=Nb) 
    selIx <-seq(1,Nb,1)
    for (ix in 1:Nb){
      estado[,ix] <- mensaje[selIx]
      selIx<-selIx+Nb
    }
    
    # Paso 3. Hacer clave:ronda = W[ ; 1 : Nb].
    clave.ronda<-W[,1:Nb] 
    # Paso 4. Hacer estado = AddRoundKey(estado; clave:ronda).
    estado<-AddRoundKey(estado,clave.ronda)
    
    for (i in 1:n){ #Paso 5. Para i = 1,...,n
      clave.ronda<-W[,seq(Nb*((i+1)-1)+1,(i+1)*Nb,1)] #Paso 5.1. Extraer de W la clave de ronda actual (clave:ronda).
      estado<-ByteSub(estado,0) # Paso 5.2. Hacer estado = ByteSub(estado).
      estado<-ShiftRow(estado,0) # Paso 5.3. Hacer estado = ShiftRow(estado).
      if(i!=n){ # Paso 5.4. Si i != n
        estado <- MixColumn(estado,0) #Paso 5.4.1. Hacer estado = Mixcolumn(estado).
      }
      # Paso 5.5. Hacer estado = AddRoundKey(estado; clave:ronda).
      estado<-AddRoundKey(estado,clave.ronda)
    }
    #Paso 6. Hacer cifrado = as:hexmode(estado).
    cifrado <- as.hexmode( estado )
    #Paso 7. Salida cifrado.
    return(cifrado)
  }
