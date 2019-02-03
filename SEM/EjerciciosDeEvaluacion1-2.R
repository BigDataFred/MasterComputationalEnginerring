####################################################################################################################################################
#  Define la baraja de naipes o cartas.
x <- c(1:7,10:12)
x
baraja <-vector(length=40)
baraja[1:40] <- c(c(x,x),c(x,x))
baraja
names(baraja) <-c( c( paste("Oros", x, sep="."), paste("Copas", x, sep=".") )  , c( paste("Espadas", x, sep="."), paste("Bastos", x, sep=".") ) )

names(baraja[7])
names(baraja[33])

####################################################################################################################################################
# Reparte 16 de las 40 cartas entre los 4 jugadores, y determina las cartas que ha recibido cada jugador. 
tmp2 = c("A1","B1","A2","B2")
jugadores <-vector(length=4)
for (iter in 1:4 ){
  jugadores[iter]<-paste("juego",tmp2[iter],sep=".")
}

repartos <- function(seedValue,baraja,jugadores){
  set.seed(seedValue)
  d <- sample(length(baraja))
  tmp <-baraja[d]
  d2 = 1:4
  for (iter in 1:length(jugadores) ){
    if (jugadores[iter]=="juego.A1") {
      juego <- tmp[d2]    
    }
    if (jugadores[iter]=="juego.B1") {
      juego <- c(juego,tmp[d2])    
    }
    if (jugadores[iter]=="juego.A2") {
      juego <- c(juego,tmp[d2])    
    }
    if (jugadores[iter]=="juego.B2") {
      juego <- c(juego,tmp[d2])    
    }
    d2 = d2+4
  }
  return(juego)
}

puntos <- repartos(2012,baraja,jugadores)
A1 <-puntos[1:4]
B1 <-puntos[5:8]
A2 <-puntos[9:12]
B2 <-puntos[13:16]

names(A1)
names(B1)
names(A2)
names(B2)

####################################################################################################################################################
# 3  Construye un dataframe que dé los puntos de cada jugador.
A1[A1>=10]=10
B1[B1>=10]=10
A2[A2>=10]=10
B2[B2>=10]=10

juego.df <- data.frame(sum(A1),sum(B1),sum(A2),sum(B2))
names(juego.df)<-jugadores
juego.df

####################################################################################################################################################
# 4 Añade una nueva columna o variable al dataframe anterior, de modo que se refleje si al menos uno de los jugadores consigue sumar 31 puntos o más.
juego.df <- data.frame(juego.df,any(juego.df>=31))
names(juego.df)<-c(jugadores,"J")
juego.df

####################################################################################################################################################
#5 rocede a los repartos correspondientes con las semillas '2013', '2014', '2015', y añade nuevas filas al dataframe 'juego.df'.
sumaPuntos <- function(seedValue,baraja,jugadores){
  puntos <- repartos(seedValue,baraja,jugadores)
  A1 <-puntos[1:4]
  B1 <-puntos[5:8]
  A2 <-puntos[9:12]
  B2 <-puntos[13:16]
  
  names(A1)
  names(B1)
  names(A2)
  names(B2)
  
  A1[A1>=10]=10
  B1[B1>=10]=10
  A2[A2>=10]=10
  B2[B2>=10]=10
  
  juego.df <- data.frame(sum(A1),sum(B1),sum(A2),sum(B2))
  names(juego.df)<-jugadores
  
  juego.df <- data.frame(juego.df,any(juego.df>=31))
  names(juego.df)<-c(jugadores,"J")
  
  return(juego.df)
  
}

 seedValues <- 2013:2015
 for (curIter in 1:length(seedValues) ){
   tmp = sumaPuntos(seedValues[curIter],baraja,jugadores)
   juego.df <- rbind(juego.df,tmp)
   juego.df
 }
 juego.df
 