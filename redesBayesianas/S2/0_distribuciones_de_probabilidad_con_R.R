## ----plot_normal_density,prompt=TRUE,message=FALSE,fig.path="./figures/",fig.keep='last',fig.show='hide',tidy=FALSE----
#Generamos los puntos en los que evaluar (entre -5 y 5)
x<-seq(-5,5,0.01)
#Obtenemos los valores de las 3 densidades
densidad1<-dnorm(x,mean=0, sd=0.5)
densidad2<-dnorm(x,mean=0,sd=1)
densidad3<-dnorm(x,mean=2,sd=1)
#Las representamos gráficamente
plot(x,densidad1,type="l",main="Ejemplo de tres densidades Gausianas",
     xlab="X", ylab="Densidad")
lines(x,densidad2,col=2)
lines(x,densidad3,col=3)


## ----plot_lognormal_cummulative,prompt=TRUE,message=FALSE,fig.path="./figures/",fig.keep='last',fig.show='hide',tidy=FALSE----
#Obtenemos los valores de las 3 densidades
#Generamos los puntos en los que evaluar (entre -5 y 5)
x<-seq(0,100,0.1)
cdf1<-plnorm(x,meanlog=0, sdlog=1)
cdf2<-plnorm(x,meanlog=0,sdlog=2)
cdf3<-plnorm(x,meanlog=3,sdlog=1)
#Las representamos gráficamente
library(ggplot2)
df<-rbind(data.frame(X=x,Y=cdf1,Distribucion="CDF #1"),
          data.frame(X=x,Y=cdf2,Distribucion="CDF #2"),
          data.frame(X=x,Y=cdf3,Distribucion="CDF #3"))

ggplot(df,aes(x=X, y=Y, col=Distribucion)) + geom_line(size=1.1) +
  labs(x="X", y="CDF")


## ----integral,prompt=TRUE,message=FALSE,tidy=FALSE-----------------------
#Para poder hacer la integral hay que definir la función a integrar
f<-function (x){
  dchisq(x,df=5)
}

#Hecho esto la integral será ...
integrate(f = f,lower = 4, upper = 6)


## ----sampling,prompt=TRUE,message=FALSE,tidy=FALSE-----------------------
muestra<-rbeta(250,1,10)


## ----qteorico,prompt=TRUE,message=FALSE,tidy=FALSE-----------------------
#Definimos los cuantiles a usar
p<-seq(0.1,0.9,0.1)
#Obtenemos los valores teóricos
cuantiles_teoricos<-qbeta(p,1,10)


## ----qmuestral,prompt=TRUE,message=FALSE,tidy=FALSE----------------------
#Creamos una función para obtener los cuantiles muestrales
qmuestral<-function(p, muestra){
  muestra_ordenada<-sort(muestra)
  posiciones<-p*length(muestra)
  muestra_ordenada[posiciones]
}
cuantiles_muestrales<-qmuestral(p,muestra)


## ----qqplot,prompt=TRUE,message=FALSE,fig.path="./figures/",fig.keep='last',fig.show='hide',tidy=FALSE----
plot(cuantiles_muestrales, cuantiles_teoricos, 
     main="Gráfico cuantil-cuantil", xlab="Cuantil muestral", ylab="Cuantil del modelo",
     pch=19, col=3)
lines(c(0,1),c(0,1))


## ----qqplot_normal,prompt=TRUE,message=FALSE,fig.path="./figures/",fig.keep='last',fig.show='hide',tidy=FALSE----
cuantiles_normal<-qnorm(p,mean(muestra),sd(muestra))
plot(cuantiles_muestrales, cuantiles_normal, 
     main="Gráfico cuantil-cuantil", xlab="Cuantil muestral", ylab="Cuantil del modelo",
     pch=19, col=3)
lines(c(0,1),c(0,1))


## ----verosimilitud,prompt=TRUE,message=FALSE,tidy=FALSE------------------
#Creamos la muestra
sample<-rpois(1000,5)

#Determinamos la probabilidad asociada a cada valor muestreado
probabilidades<-dpois(sample,5)

#La probabilidad la computamos como el producto
prod(probabilidades)


## ----loglikelihood,prompt=TRUE,message=FALSE,tidy=FALSE------------------
#El logaritmo del producto de probabilidades es la suma de los logaritmos
sum(log(probabilidades))


## ----logveros_plot,prompt=TRUE,message=FALSE,fig.path="./figures/",fig.keep='last',fig.show='hide',tidy=FALSE----
f<-function(lambda){
  sum(log(dpois(sample,lambda)))
}
lambdas<-seq(1,10,0.1)
logveros<-sapply(lambdas, FUN = f)
df<-data.frame(Lambda=lambdas, Logverosimilitud=logveros)
ggplot(df,aes(x=Lambda, y=Logverosimilitud)) + geom_line(size=1.1) + 
  labs(x=expression(lambda))


