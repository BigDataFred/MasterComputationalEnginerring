#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#+ Este documento contiene las funciones que hay que implementar   ++
#+ como parte del trabajo de la asignatura de Redes Bayesianas del ++
#+ Master Universitario en Ingenieria Computacional y Sistemas.    ++
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#+ INSTRUCCIONES                                                   ++
#+ Lo primero es modificar la variable 'nombre', indicando el nom- ++
#+ bre y apellidos de el/la alumno/a.                              ++
#+ En la segunda parte hay una serie de funciones que hay que      ++
#+ completar siguiendo las indicaciones de la documentacion.       ++
#+ El codigo de las funciones debera estar adecuadamente documen-  ++
#+ tado a fin de que cualquiera que lo lea pueda entender su fun-  ++
#+ cionamiento.                                                    ++
#+ EN NINGUN CASO HABRA QUE MODIFICAR EL NOMBRE DE LAS VARIABLES O ++
#+ DE LAS FUNCIONES.                                               ++
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

## Modificar indicando los dos apellidos y nombre del alumno/a
nombre<-c("Roux","Frédéric")#"Apellido1 Apellido2, Nombre"


#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Estimacion de parametros ------------------------------------------------
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#' Funcion para estimar los parametros de una distribucion multinomial
#' 
#' @param sample Muestra de la que estimar los parametros. Debe ser un vector de factores
#' @return Para cada posible valor de los factores (\code{levels(sample)}), 
#' la probabilidad estimada para dicho valor
#' @examples
#' sample<-factor(c("A","A","B","C","A","C"),levels=c("A","B","C"))
#' mle_multinomial(sample)
mle_multinomial<-function (sample){
  ## Implementar el codigo necesario para devolver la probabilidad asociada a cada 
  ## valor definido en el vector 'sample'.
  ## Nota: Puede haber valores que no aparezcan en la muestra. En ese caso la probabilidad
  ## debera ser cero; la lista de posible valores que puede tomar un 'factor' se obtiene con 
  ## la funcion 'levels'.
  ## La funcion da como resultado  un vector de probabilidades, correspondiendose el primer 
  ## valor con la probabilidad asociada al primer 'nivel', la segunda al segundo etc.
  
  probabilities<-rep(0,length(levels(sample)))
  r <- length(levels(sample))
  n = length( sample)
  for (ix in 1:length(probabilities)){
    nx = length(which(sample == levels(sample)[ix]))
    probabilities[ix] <- ( nx + 1 )/( n + r )
  }
  return(probabilities)
}


#' Funcion para estimar los parametros de una distribucion Beta usando 
#' el motodo de los momentos
#' 
#' @param sample Muestra de la que estimar los parámetros
#' @return Vector de dos posiciones, conteniendo respectivamente los parametros alfa y beta estimados (en ese orden)
#' @examples
#' sample<-rbeta(1000,2,3)
#' momest_beta(sample)
momest_beta<-function(sample){
  
  f<-Vectorize(function(a,b,sample)
  {
   sum(log(dbeta(sample,a,b)))
  },vectorize.args=c("a","b"))
  
  a <- seq(1,100,1)
  b <- seq(1,100,1)
  logveros <- outer(a,b,f,sample=sample)

  ix <- which(logveros==max(max(logveros)),TRUE)
  
  ## Implementar la funcion
  parameters<-c(0,0)
  parameters[1] <- a[ix[1]]
  parameters[2] <- b[ix[2]]
  return(parameters)
}


#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Teoria de la informacion ------------------------------------------------
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


#' Funcion para computar la entropia asociada a una variable discreta (multinomial)
#' 
#' @param probs Vector de probabilidades asociadas a cada valor de la variable
#' @return Enropia calculada utilizando el logaritmo en base 2
#' @examples
#' sample<-factor(c("A","A","B","C","A","C"),levels=c("A","B","C"))
#' probs<-mle_multinomial(sample)
#' entropy(probs)
entropy<-function(probs){
  h<--sum(probs*log(probs))
  return (h)
}


#++++++++++++++++++++++++++++++
# EJERCICIO OPCIONAL ++++++++++
#++++++++++++++++++++++++++++++

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Modelado del tiempo de trayecto: Modelo paramétrico ---------------------
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

## Cargamos los datos para probar. Esta funcion crea una variable 'sample' con dichos datos
p2d = "~/MasterIngeneriaComputacional2018/redesBayesianas/S2/"
load(file = paste(p2d,"RRBB_travel_duration.Rdata",sep="") )

ixS = which( sample$Weather=='S')
ixR = which( sample$Weather=='R')

n = length( sample$Weather )
nS = length( ixS )
nR = length( ixR )

pS = nS/n
pR = nR/n

bins = seq(min(round(sample$Time)),max(round(sample$Time)),1)
p1 = vector(length=length(bins)-1)
p2 = vector(length=length(bins)-1)
p3 = vector(length=length(bins)-1)
for (ix in 1:length(bins)-1){
    
    #p(T=t | W=S)
    p2[ix] = length(which(sample$Time[ixS]>=bins[ix] & sample$Time[ixS]<bins[ix+1]))/nS # p(T=t | W=S)
    #p(T=t | W=R)
    p3[ix] = length(which(sample$Time[ixR]>=bins[ix] & sample$Time[ixR]<bins[ix+1]))/nR # p(T=t | W=R)
    #p(T=t | W=w)
    p1[ix] = p2[ix]*pS+p3[ix]*pR                                                         #p(T,W)
}


momest_gamma<-function(sample){
  
  f<-Vectorize(function(a,b,sample)
  {
    sum(log(dgamma(sample,shape=a,scale=b)))
  },vectorize.args=c("a","b"))
  
  a <- seq(1,100,1)
  b <- seq(1,100,1)
  logveros <- outer(a,b,f,sample=sample)
  
  
  ix <- which(logveros==max(max(logveros)),TRUE)
  
  ## Implementar la funcion
  parameters<-c(0,0)
  parameters[1] <- a[ix[1]]
  parameters[2] <- b[ix[2]]
  return(parameters)
}
par(mfrow=c(2,2))

# visualize the fit of the empirically estimated discrete probabilties
hist(sample$Time,freq=FALSE,main="P(T=t | W=w)",xlab="Time [min]")
lines(bins[1:length(bins)-1],p1,col=2)

hist(sample$Time[ixS],freq=FALSE,main="P(T=t | W=S)",xlab="Time [min]",ylim=c(0,.2))
lines(bins[1:length(bins)-1],p2,col=3)
# Metodo de los momentos
d1 <- dnorm(sort(sample$Time[ixS]),mean=mean(sample$Time[ixS]),sd=sd(sample$Time[ixS])) # fit gaussian distribution to data
lines(sort(sample$Time[ixS]),d1,col=4)
# Metodo verosimilitud
mg = momest_gamma(sample$Time[ixS])
d2 <- dgamma(sort(sample$Time[ixS]),shape=mg[1],scale=mg[2])    # fit gamma distribution to data
lines(sort(sample$Time[ixS]),d2,col=5)

hist(sample$Time[ixR],freq=FALSE,main="P(T=t | W=R)",xlab="Time [min]",ylim=c(0,.1))
lines(bins[1:length(bins)-1],p3,col=3)
# Metodo de los momentos
d1 <- dnorm(sort(sample$Time[ixR]),mean=mean(sample$Time[ixR]),sd=sd(sample$Time[ixR])) # fit gaussian distribution to data
lines(sort(sample$Time[ixR]),d1,col=4)
# Metodo verosimilitud
mg = momest_gamma(sample$Time[ixR])
d2 <- dgamma(sort(sample$Time[ixR]),shape=mg[1],scale=mg[2])    # fit gamma distribution to data
lines(sort(sample$Time[ixR]),d2,col=5)

######################################################
## EL MODELO GAUSINO ESTA MEJOR QUE EL MODELO GAMMA ##
######################################################

#' Esta funcion toma como entrada muestras de pares (climatologia, tiempo) y genera un
#' modelo que posteriormente se utilizara para responder preguntas. 
#' 
#' @param data Matriz con dos variables, 'Weather' y 'Time'
#' @return Parametros del modelo utilizado para representar el problema
#' @examples
#' sample<-data.frame(Weather=c("R","S","R","R","R","S"), Time=c(48.2,43.1,49.4,52.8,48.1,44.4))
#' model<-build_model_parametric(sample)
#' estimate_probability_time_interval_parametric(model, 45,50)
build_model_parametric<-function (data){
  ## El modelo asume que f(Time | Weather="S") y f(Time | Weather="R") son DISTINTAS
  ## y siguen una cierta distribucion parametrica.
  ## El formato del modelo generado por la funcion es libre, pero tiene que funcionar
  ## con el resto de funciones implementadas
  f1 <- function(x){
    dnorm( x, mean= mean(data$Time), sd=sd(data$Time) )  # en el caso que no importa el tiempo
  }
  
  ixS = which( data$Weather == "S")
  f2 <- function(x){
    dnorm( x, mean= mean(data$Time[ixS]), sd=sd(data$Time[ixS]) )  #solo usamos datos cuando hay sol
  }
  
  ixR = which( data$Weather == "R")
  f3 <- function(x){
    dnorm( x, mean= mean(data$Time[ixR]), sd=sd(data$Time[ixR]) )  # solo usamos datos cuando hay lluvia
  }
  
  model<-list("f1"=f1,"f2"=f2,"f3"=f3) # preparamos los datos para el output
  return (model)
}


#' Dado un modelo construido con la funcion build_model_parametric, determinar la probabilidad
#' de que el tiempo de trayecto este en un cierto intervalo
#' 
#' @param model Modelo a utilizar
#' @param a Limite de tiempo inferior
#' @param b Limite superior
#' @param weather Parametro opcional. Si toma uno de los dos posibles valores, la funcion devolvera la 
#' probabilidad condicionada P(a<Time<b | Weather=weather); en caso de ser NA, la funcion devolvera
#' la probabilidad marginal P(a<Time<b).
#' @return Probabilidad de que el tiempo de trayecto este en el intervalo indicado
#' @examples
#' sample<-data.frame(Weather=c("R","S","R","R","R","S"), Time=c(48.2,43.1,49.4,52.8,48.1,44.4))
#' model<-build_model_parametric(sample)
#' estimate_probability_time_interval_parametric(model, 45,50)
estimate_probability_time_interval_parametric <- function (model, a, b, weather=NA){
  ## La implementacion de este metodo depende de la forma del modelo devuelto por la funcion anterior
  
  # selecionamos el modelo en funcion de la variable "weather"
  if (is.na(weather)==FALSE){
    if (weather =="S"){
      f = model$f2 # si hay sol
    }
    if (weather =="R"){
      f = model$f3 # si hay lluvia
    }
  }
  else{
    f = model$f1 # si no importa el sol
  }

  # Dada una funcion de densidad, podemos querer computar la probabilidad de que la variable tome un valor
  # dentro de un intervalo.
  p = integrate(f = f,lower = a, upper = b)
  
  return(p)
}

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Modelado del tiempo de trayecto: Modelo no paramétrico ---------------------
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


# Las siguientes dos funciones son iguales a las anteriores, salvo que en este caso las probabilidades
# condicionales deben ser modeladas utilizando un metodo no parametrico

#' Esta funcion toma como entrada muestras de pares (climatologia, tiempo) y genera un
#' modelo que posteriormente se utilizara para responder preguntas. 
#' 
#' @param data Matriz con dos variables, 'Weather' y 'Time'
#' @return Modelo utilizado para representar el problema
#' @examples
#' sample<-data.frame(Weather=c("R","S","R","R","R","S"), Time=c(48.2,43.1,49.4,52.8,48.1,44.4))
#' model<-build_model_non_parametric(sample)
#' estimate_probability_time_interval_non_parametric(model, 45,50,weather='R')
build_model_non_parametric<-function (data){
  ## El modelo asume que f(Time | Weather="R") y f(Time | Weather="R") son DISTINTAS
  ## El formato del modelo generado por la funcion es libre, pero tiene que funcionar
  ## con el resto de funciones implementadas
  f<-0
  rIx <- sample( length( sample$Time ) )
  ixS <-rIx[ seq(1,round(length(rIx)/2))]
  ixR <-rIx[ seq(round(length(rIx)/2)+1,length(rIx),1) ]
  while (f<1){
    
    f1 <- function(x){ dnorm( x ,mean=mean(data$Time[ixS]),sd=sd(data$Time[ixS]) ) }
    f2 <- function(x){ dnorm( x, mean=mean(data$Time[ixR]),sd=sd(data$Time[ixR]) ) }
    
    p1 <- vector(length=length(data$Time))
    p2 <- vector(length=length(data$Time))
    cnt<-0
    chIx1<-vector()
    chIx2<-vector()
    for ( ix in 1:length(data$Time) ){
      p1 <- integrate(f1,lower=data$Time[ix]-.1,upper=data$Time[ix]+.1)$value
      p2 <- integrate(f2,lower=data$Time[ix]-.1,upper=data$Time[ix]+.1)$value
      if (p2 > p1 & length(which(ixS==ix))>0){
        cnt<-cnt+1
        chIx1[cnt]<-ix
      }
      if(p1 > p2 & length(which(ixR==ix))>0){
        cnt<-cnt+1
        chIx2[cnt]<-ix
      }
    }
    
    if (length(chIx1)==0 & length(chIx2)==0){
      f<-1
    }
    else{
      ixS <- sort( c(setdiff(ixS,chIx1),chIx2) )
      ixR <- sort( c(setdiff(ixR,chIx2),chIx1) )
      
      f2 <-function(x){ dnorm( sort(data$Time), mean = mean(data$Time[ixS],sd=sd(data$Time[ixS]))) } 
      f3 <- function(x){ dnorm( sort(data$Time), mean = mean(data$Time[ixR],sd=sd(data$Time[ixR]))) } 
      
      w1<- length(ixS)
      w2<- length(ixR)
      f1 <-function(x){ (w1* dnorm( x, mean = mean(data$Time[ixS],sd=sd(data$Time[ixS]))) + 
                        w2* dnorm( x, mean = mean(data$Time[ixR],sd=sd(data$Time[ixR]))))/(w1+w2) } 
      
    }
  }
  
  model<-list("f1"=f1,"f2"=f2,"f3"=f3) # preparamos los datos para el output
  return(model)
}

#' Dado un modelo construido con la funcion build_model_non_parametric, determinar la probabilidad
#' de que el tiempo de trayecto este en un cierto intervalo
#' 
#' @param model Modelo a utilizar
#' @param a Limite de tiempo inferior
#' @param b Limite superior
#' @param weather Parametro opcional. Si toma uno de los dos posibles valores, la funcion devolvera la 
#' probabilidad condicionada P(a<Time<b | Weather=weather); en caso de ser NA, la funcion devolvera
#' la probabilidad marginal P(a<Time<b).
#' @return Probabilidad asociada al intervalo indicado
#' @examples
#' sample<-data.frame(Weather=c("R","S","R","R","R","S"), Time=c(48.2,43.1,49.4,52.8,48.1,44.4))
#' model<-build_model_non_parametric(sample)
#' estimate_probability_time_interval_non_parametric(model, 45,50)
estimate_probability_time_interval_non_parametric <- function (model, a, b, weather=NA){
  ## La implementacion de este metodo depende de la forma del modelo devuelto por la funcion anterior
  
  # selecionamos el modelo en funcion de la variable "weather"
  if (is.na(weather)==FALSE){
    if (weather =="S"){
      f = model$f2 # si hay sol
    }
    if (weather =="R"){
      f = model$f3 # si hay lluvia
    }
  }
  else{
    f = model$f1 # si no importa el sol
  }
  
  # Dada una funcion de densidad, podemos querer computar la probabilidad de que la variable tome un valor
  # dentro de un intervalo.
  p = integrate(f = f,lower = a, upper = b)
  
  return(p)
}

estimate_probability_time_interval_non_parametric(model, 45,50,weather="S")
