## ----echo=FALSE----------------------------------------------------------
knit_theme$set("edit-kwrite")

## ----loading_1,prompt=TRUE,message=FALSE---------------------------------
library(bnlearn)
library(Rgraphviz)
library(ggplot2)
data(learning.test)

## ----constraint based learning, eval=FALSE,prompt=TRUE-------------------
## net<-gs(learning.test) #Equivalente a ejecutar gs(data,optimized=T)
## net<-gs(learning.test,optimized=F)
## #cl debe ser un objeto de tipo cluster creado e inicializado usando snow
## net<-gs(learning.test,cluster=cl)

## ----score + search, eval=FALSE,prompt=TRUE------------------------------
## net<-hc(learning.test,restart=10,perturb=5)

## ----prompt=TRUE---------------------------------------------------------
net<-hc(learning.test)
score(x=net,data=learning.test,type="loglik")
score(x=net,data=learning.test,type="bic")
score(x=net,data=learning.test,type="k2")
score(x=net,data=learning.test,type="bde")

## ----eval=FALSE,prompt=TRUE----------------------------------------------
## graphviz.plot(x=net,layout="dot",shape="ellipse")
## dev.print(device=pdf,file="grafo.pdf")
## #En el caso de imagenes png, hay que determinar la dimensión en pixeles
## dev.print(device=png,width=1000,height=1000,file="grafo.png")
## dev.off()

## ----eval=FALSE,prompt=TRUE----------------------------------------------
## net.fitted<-bn.fit(net,data=learning.test)
## net.fitted[2]

## ----eval=FALSE,prompt=TRUE----------------------------------------------
## graphviz.plot(bn.net(net.fitted))

## ----loglik_vs_bic,prompt=TRUE,fig.path="./figures/",fig.show='hide',fig.keep='all'----
net_loglik<-hc(learning.test,score="loglik")
net_bic<-hc(learning.test,score="bic")
graphviz.plot(net_loglik,layout="neato")
graphviz.plot(net_bic)

## ----Comparación con diferentes penalizaciones,prompt=TRUE---------------
net<-hc(learning.test,score="bic",k=1)
dim(arcs(net))[1]
net<-hc(learning.test,score="bic",k=100)
dim(arcs(net))[1]
net<-hc(learning.test,score="bic",k=200)
dim(arcs(net))[1]
net<-hc(learning.test,score="bic",k=1000)
dim(arcs(net))[1]

## ----parameters_VS_overfitting,prompt=TRUE,fig.path="./figures/",fig.show='hide',fig.keep='last',fig.height=5,fig.width=15,warning=FALSE----
N<-dim(learning.test)[1]
n<-dim(learning.test)[2]
sizes<-round(exp(seq(1,log(2560),(log(2560)-1)/50)))
train<- learning.test[1:2560,]
test<- learning.test[2561:N,]

# Definimos un modelo con el grafo vacio, con una cadena y con el grafo completo
MEmpty<-empty.graph(c("A","B","C","D","E","F"))
MChain<-empty.graph(c("A","B","C","D","E","F"))
chain <- matrix(c("A", "B", "B", "C", "C", "D","D", "E", "E", "F"), 
              ncol = 2, byrow = TRUE, dimnames = list(NULL, c("from", "to")))
arcs(MChain) <- chain
MComplete<-hc(train,score="loglik")

# Funcion que evalua el ajuste y la generalización (normalizado) de una estructura
# Los parametros se aprenden empleando los primeros "size" casos de "train"
eval_struct<-function(size, BN, train, test){
  D<-train[1:size,]
  BN<- bn.fit(x= BN, data= D,method = "bayes")
  gener=stats::logLik(BN,test)/(n*dim(test)[1])
  fit=stats::logLik(BN,D)/(n*dim(D)[1])
  c(gener,fit)
}

# Para cada tamanio, obtenemos los valores
resultados_Empty<-sapply(sizes, FUN=eval_struct, BN=MEmpty, train=train, test=test)
resultados_Chain<-sapply(sizes, FUN=eval_struct, BN=MChain, train=train, test=test)
resultados_Complete<-sapply(sizes, FUN=eval_struct, BN=MComplete, train=train, test=test)

# Representacion grafica del resultado
lims<- c(min(resultados_Empty,resultados_Chain),max(resultados_Empty,resultados_Chain))
layout(matrix(c(1,2,3),ncol=3))
plot(log10(sizes), resultados_Empty[1,], main="Empty graph", 
     ylab= "LL/nN",xlab="log(Size)",type="l",ylim= lims, col= "blue")
lines(log10(sizes),  resultados_Empty[2,],col="red")

plot(log10(sizes),  resultados_Chain[1,], main="Chain graph", 
     ylab= "LL/nN",xlab="log(Size)",type="l",ylim= lims, col= "blue")
lines(log10(sizes),  resultados_Chain[2,],col="red")
plot(log10(sizes),  resultados_Complete[1,], main="Complete graph", 
     ylab= "LL/nN",xlab="log(Size)",type="l",ylim= lims, col= "blue")
lines(log10(sizes),  resultados_Complete[2,],col="red")

## ----gener_vs_fit,prompt=TRUE,fig.path="./figures/",fig.show='hide',fig.keep='last',fig.height=5,fig.width=10,warning=FALSE----

# Funcion para, dado un tamanio de entrenamiento, obtener la verosimilitud en el train 
# y el test
eval_net<-function(size, test=test,score="loglik"){
  train<-learning.test[1:size,]
  BN<- hc(train,score=score)
  BN<- bn.fit(x= BN, data= train,method = "bayes")
  gener=stats::logLik(BN,test)/(n*dim(test)[1])
  fit=stats::logLik(BN,train)/(n*dim(train)[1])
  c(gener,fit)
}
# Para cada tamanio, obtenemos los valores
resultados_loglik<-sapply(sizes, FUN=eval_net, test=test, score="loglik")
resultados_bic<-sapply(sizes, FUN=eval_net, test=test, score="bic")

# Representacion grafica del resultado
lims<- c(min(resultados_bic,resultados_loglik),max(resultados_bic,resultados_loglik))
layout(matrix(c(1,2),ncol=2))
plot(log10(sizes), resultados_loglik[1,], main="Log. Likelihood", 
     ylab= "LL/nN",xlab="log(Size)",type="l",ylim= lims, col= "blue")
lines(log10(sizes),  resultados_loglik[2,],col="red")

plot(log10(sizes),  resultados_bic[1,], main="BIC", ylab= "LL/nN",xlab="log(Size)",
     type="l",ylim= lims, col= "blue")
lines(log10(sizes),  resultados_bic[2,],col="red")


## ----cost_vs_numVar,prompt=TRUE,eval=TRUE,fig.path="./figures/",cache=TRUE,fig.show='hide',message=FALSE----
numInst=100
varSizeVector=seq(10,100,10)
times<-vector()
evaluations<-vector()
for (numVar in varSizeVector){
  random_matrix<-data.frame(matrix(runif(numVar*numInst),ncol=numVar))
  data<-discretize(random_matrix,method="interval",breaks=4)
  t0<-proc.time()
  net<-hc(data,score="bde",optimized=T)
  t1<-proc.time()
  times<-c(times,(t1-t0)[3])
  evaluations<-c(evaluations,net$learning$ntests)
}

df<-data.frame(vars=varSizeVector,time=times,eval=evaluations)
ggplot(df,aes(x=vars,y=times)) + geom_smooth() + 
  labs(x="Numero de variables",y="Tiempo de ejecución")
ggplot(df,aes(x=vars,y=eval)) + geom_smooth() + 
  labs(x="Numero de variables",y="Numero de evaluaciones")
ggplot(df,aes(x=eval,y=times)) + geom_smooth() + 
  labs(x="Numero de evaluaciones",y="Tiempo de ejecución")

## ----alg_cost,prompt=TRUE,eval=TRUE,fig.path="./figures/",cache=TRUE,fig.show='hide',message=FALSE,warning=FALSE,tidy=FALSE----
numInst=100
numVar=30
random_matrix<-data.frame(matrix(runif(numVar*numInst),ncol=numVar))
data<-discretize(random_matrix,method="interval",breaks=4)

get.cost<-function(data,alg,label){
  t0<-proc.time()
  net<-alg(data)
  t1<-proc.time()
  data.frame(alg=label,time=(t1-t0)[3],eval=net$learning$ntests)
}

df<-rbind(get.cost(data,hc,"HC"),
          get.cost(data,tabu,"Tabu"),
          get.cost(data,gs,"GS"),
          get.cost(data,iamb,"IAMB"),
          get.cost(data,fast.iamb,"f-IAMB"),
          get.cost(data,mmpc,"MMPC"))

ggplot(df,aes(x=alg,y=time)) + geom_bar(stat="identity") + 
  labs(x="Algoritmo",y="Tiempo computacional")
ggplot(df,aes(x=alg,y=eval)) + geom_bar(stat="identity") + 
  labs(x="Algoritmo",y="Número de evaluaciones")

## ----eval=FALSE----------------------------------------------------------
## remuestreo<-function(mat){
##   num_samples<-dim(mat)[1]
##   id<-sample(num_samples,replace=TRUE)
##   mat[id,]
## }

## ----eval=FALSE,prompt=TRUE,tidy=FALSE-----------------------------------
## names<-c("A","B","C","D")
## adj_mat<-matrix(c(0,1,1,0,0,0,0,0,0,0,0,1,0,0,0,0),byrow=T,ncol=4)
## colnames(adj_mat)<-names
## rownames(adj_mat)<-names
## graph<-empty.graph(names)
## amat(graph)<-adj_mat
## graphviz.plot(graph)

