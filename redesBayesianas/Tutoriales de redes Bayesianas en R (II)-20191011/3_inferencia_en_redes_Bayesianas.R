
## ----echo=FALSE----------------------------------------------------------
#knit_theme$set("edit-kwrite")


## ----loading_1,prompt=TRUE,message=FALSE,cache=FALSE---------------------
library(bnlearn)
library(gRain)
library(Rgraphviz)
library(ggplot2)
library(foreign)


## ----object_conversion,prompt=TRUE,message=FALSE,cache=FALSE-------------

#mushroom<-read.arff("mushroom.arff")
#car<-read.arff("car.arff")
load("UCI_car.Rdata")
load("UCI_mushroom.Rdata")

summary(car)
summary(mushroom)


## ----data_loading,prompt=TRUE,message=FALSE,cache=FALSE------------------
net_bn<-hc(car)
net_graphnel<-as(amat(net_bn),"graphNEL")
net_grain<-grain(net_graphnel,data=car)
summary(net_grain)


## ----manual_cration,prompt=TRUE,message=FALSE----------------------------
yn<-c("NO","SI")
s <- cptable(~S, values=c(50,50),levels=yn)
j <- cptable(~J, values=c(25,75),levels=yn)
c.sj <- cptable(~C+S+J, values=c(80,20,50,50,50,50,10,90),levels=yn)
a.sc <- cptable(~A|S:C, values=c(95,5,50,50,25,75,5,95),levels=yn)
plist<-compileCPT(list(s,j,c.sj,a.sc))
net.study<-grain(plist)


## ----marginal_A,prompt=TRUE,message=FALSE--------------------------------
querygrain(net.study,nodes="A",type="marginal")


## ----example_mush,prompt=TRUE,message=FALSE,fig.path="./figures/",fig.keep='all',fig.show='hide',tidy=FALSE----
bn_mush<-hc(mushroom[,1:10])
net_mush<-grain(as(amat(bn_mush),"graphNEL"),
                data=mushroom[,1:10],smooth=1/dim(mushroom)[1])
plot(net_mush)


## ----example_mush_2,prompt=TRUE,message=FALSE,fig.path="./figures/",fig.keep='all',fig.show='hide'----
net_mush_moral<-moralize(net_mush$dag)
net_mush_triang<-triangulate(net_mush_moral)
plot(net_mush_moral)
plot(net_mush_triang)


## ----rip_ordering,prompt=TRUE,message=FALSE,eval=FALSE-------------------
rip(net_mush_triang)
plot(rip(net_mush_triang))


## ----compilation,prompt=TRUE,message=FALSE-------------------------------
net_mush_compiled<-compile(net_mush)
net_mush$isCompiled
net_mush_compiled$isCompiled
summary(net_mush_compiled)


## ----propagation,prompt=TRUE,message=FALSE-------------------------------
net_mush_propagated<-propagate(net_mush_compiled)
net_mush$isPropagated
net_mush_propagated$isPropagated
summary(net_mush_propagated)


## ----Using evidence,prompt=TRUE,message=FALSE----------------------------
net_mush_propagated_ev<-setFinding(net_mush_propagated,nodes="BRUISES",states="t", propagate=F)
net_mush_propagated_ev<-setEvidence(net_mush_propagated_ev,nodes="GILL_COL",states="n", propagate=F)
net_mush_propagated_ev<-propagate(net_mush_propagated_ev)
querygrain(net_mush_propagated,nodes="EDIBILITY",type="marginal")
querygrain(net_mush_propagated_ev,nodes="EDIBILITY",type="marginal")


## ----Using evidence 2,prompt=TRUE,message=FALSE--------------------------
net_mush_propagated_ev2<-retractEvidence(net_mush_propagated_ev,nodes=c("BRUISES","GILL_COL"), propagate=F)
net_mush_propagated_ev2<-setEvidence(net_mush_propagated_ev2,nodes=c("CAP_COL","CAP_SHAPE"),states=c("w","b"), propagate=T)
querygrain(net_mush_propagated_ev,nodes="EDIBILITY",type="marginal")
querygrain(net_mush_propagated_ev2,nodes="EDIBILITY",type="marginal")


## ----marginal_A_exact,prompt=TRUE,message=FALSE--------------------------
querygrain(net.study,nodes="A",type="marginal")


## ----echo=FALSE----------------------------------------------------------
set.seed(666)


## ----marginal_A_aprox,prompt=TRUE,message=FALSE--------------------------
samp<-simulate(net.study,nsim=10)
summary(samp$A)/10
querygrain(net.study,nodes="A",type="marginal")


## ----marginal_A_aprox_2,prompt=TRUE,message=FALSE,cache=TRUE-------------
aprox_marginal<-function(net,node,nsamples){
  samp<-simulate(net,nsim=nsamples)
  summary(samp[,node])/nsamples
}
querygrain(net_mush_propagated,nodes="CAP_SURF",type="marginal")
aprox_marginal(net_mush,"CAP_SURF",10)
aprox_marginal(net_mush,"CAP_SURF",10)
aprox_marginal(net_mush,"CAP_SURF",10)
aprox_marginal(net_mush,"CAP_SURF",1000)


## ----bias_var_marginal_aprox,prompt=TRUE,message=FALSE,fig.path="./figures/",fig.keep='all',fig.show='hide',cache=TRUE,tidy=FALSE----
df<-data.frame()
node<-"GILL_SIZE"
marg_exacta<-querygrain(net_mush,nodes=node,type="marginal")[[1]][1]

for (i in seq(10,210,20)){
  aux<-vector()
  for (rep in 1:10){
    aux<-c(aux,aprox_marginal(net_mush,node,i)[1])
  }
  df<-rbind(df,data.frame(size=i,min=min(aux),max=max(aux)))
}

ggplot(df,aes(x=size,ymin=min,ymax=max)) + 
  geom_ribbon(fill="slategray1") + 
  geom_line(aes(y=min),col="darkgray",size=1.5) + 
  geom_line(aes(y=max),col="darkgray",col="darkgray",size=1.5) + 
  geom_abline(intercept=marg_exacta,slope=0) + 
  labs(x="No. de muestras",y="Envolvente de las estimaciones") + 
  annotate("text", x=25,y=marg_exacta+0.01,label="Valor exacto")

## ---- Ejercicios,prompt=TRUE,message=TRUE,fig.keep='all',fig.show='true',cache=TRUE,tidy=FALSE----

yn<-c("NO","SI")
s <- cptable(~S, values=c(50,50),levels=yn)
j <- cptable(~J, values=c(25,75),levels=yn)
c.sj <- cptable(~C+S+J, values=c(80,20,50,50,50,50,10,90),levels=yn)
a.sc <- cptable(~A|S:C, values=c(95,5,50,50,25,75,5,95),levels=yn)
plist<-compileCPT(list(s,j,c.sj,a.sc))
net.study<-grain(plist)

# RETO 2
#net - Un objeto de tipo grain en el que no se haya introducido ninguna evidencia
#node - Un string o indice indicando de que varaible hay que estimar la probabilidad marginal
#evidence nodes - Un vector de strings o indices indicando a que variables se debe condicionar la marginal
#evidences - Un vector de igual tama~no al anterior que incluya los valores que deben tomar los nodos condicionantes
#numSamples - El numero de muestras a utilizar en la estimacion (m en el pseudocodigo de arriba)

get_conditional_marginal <- function(net, node, evidence_nodes, evidences, numSamples){
  cnt <-0
  S <- vector(length=numSamples)
  for ( ix in 1:length(S) ){
    
    net_ev<-setFinding(net,nodes=evidence_nodes[ix],states=evidences[ix], propagate=F)
    net_ev<-propagate(net_ev)
    s <- simulate(net_ev)
    chck <- as.logical( simulate(net_ev)[evidence_nodes]==evidences )
    if (chck==TRUE){
      S[ix] <-summary(s[,node])[2]
    }
  }
  Px<-sum(S)/numSamples
  return(Px)
}

# Un ejemplo seria el calculo de la probabilidad de aprobar (en nuestro modelo de ejemplo) sabiendo que hemos comprendido la asignatura.
get_conditional_marginal(net.study,"A","C","SI",10)



# Ejercicio 5.1
#5.1 Problema. En la linea de la grfica mostrada en la Figura 2, crear una graficca en la que se muestre
#para nuestro ejemplo de red Bayeiana el error medio (de 5 repeticiones) al estimar de forma aproximada la
#probabilidad de aprobar frente al numero de muestras utilizadas (entre 10 y 5000).

# inferencia exacta de las probabilidades marginales
pST <- as.numeric(querygrain(net.study,nodes="A",type="marginal")$A)[2] # inferencia exacta probabilidad de aprobar "SI"

# estimacion de forma aproximada
reps<-5 # numero de repeticiones
n <- seq(10,5250,300) # numero de muestras utilizadas
pS <-matrix(nrow=reps,ncol=length(n)) # intializacion de una matriz
for (r in 1:reps){
  for (ix in 1:length(n)){
    pS[r,ix] <- as.numeric( aprox_marginal(net.study,"A",n[ix]) )[2] # inferencia aproximada probabilidad de aprobar "SI"
  }
}

err <- abs(pST-pS) # el error es la diferencia entre el valor de la inferencia aproximada y  y el valor de la inferencia exacta

# representamos la evolucion del error en funcion del numero de muestras 
plot(n,colMeans(err),type='both',col=2,xlab="No. de muestras",ylab="Error medio")

#5.2 Problema. A la hora de estimar probabilidades marginales disponiendo de evidencia, en algunos casos es
#evidencia puede ser usada directamente (por ejemplo, cuando sabemos el valor de una variable que no tiene padres). 
#Sin embargo, en el caso general no es posible hacer esto. En nuestro ejemplo de red, si sabemos que
#C = y no podemos simplemente muestrear S, fijar la probabilidad condicionada P(AjS;C = y) y muestrear A.
#Comprobar que esta manera de calcular P(AjC = y) no es correcta.
net.study_ev<-setFinding(net.study,nodes="C",states="SI", propagate=F)
net.study_ev<-propagate(net.study_ev)
querygrain(net.study_ev,nodes="A",type="marginal")

# No entiendo lo que hay que hacer aqui. Me parece bastante mal explicado el enunciado,y tambien con los comentarios del foro 
# no me parece claro lo que hay que hacer. Creo que tambien, en la teoria no se ha explicado este aparto.



