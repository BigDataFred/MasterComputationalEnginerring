
## ----echo=FALSE,warning=FALSE,message=FALSE,error=FALSE------------------
knit_theme$set("edit-kwrite")
set.seed(666)


## ----loading_1,prompt=TRUE,message=FALSE---------------------------------
library(bnlearn)
library(gRain)
library(Rgraphviz)
library(ggplot2)
library(foreign)


## ----loading_data,prompt=TRUE--------------------------------------------
car<-read.arff("car.arff")
#Eliminamos las variables que solo tiene un estado
mushroom<-read.arff("mushroom.arff")
constantes<-which(lapply(mushroom,FUN=function(x){length(levels(x))})<2)
mushroom<-mushroom[,-constantes]


## ----nb_y_tan, prompt=TRUE,fig.path="./figures/",fig.show='hide',results='hide'----
nb_mush<-naive.bayes(training=names(mushroom)[dim(mushroom)[2]],
                     explanatory=names(mushroom)[-dim(mushroom)[2]],x=mushroom)
nb_mush_fitted<-bn.fit(x=nb_mush,data=mushroom,method="mle")
nb_mush
tan_car<-tree.bayes(x=car,training=names(car)[dim(car)[2]],explanatory=names(car)[-dim(car)[2]])
tan_car_fitted<-bn.fit(x=tan_car,data=car,method="mle")
tan_car
graphviz.plot(tan_car)


## ----resubstitution,prompt=TRUE------------------------------------------
estimacion_error<- function(clasificador, indice_clase, test){
  clase_predicha<-predict(clasificador, test)
  clase_real<-test[,indice_clase]
  sum(clase_predicha!=clase_real) / length(clase_predicha)
}

estimacion_error(clasificador= nb_mush_fitted, indice_clase=dim(mushroom)[2],
                 test=mushroom)
estimacion_error(clasificador= tan_car_fitted, indice_clase=dim(car)[2], 
                 test=car)


## ----holdout,prompt=TRUE,tidy=FALSE,warning=FALSE------------------------
training<-0.66 #2/3 de base de datos para aprender, 1/3 para evaluar
num_instancias<-dim(mushroom)[1]
##Barajeamos las instancias para quedarnos con los dos primeros tercios para prender
permutation<-order(runif(num_instancias)) 
id.train<-permutation[1:(training*num_instancias)]
id.test<-permutation[(training*num_instancias+1):num_instancias]

nb_mush_2<-naive.bayes(training=names(mushroom)[dim(mushroom)[2]],
                       explanatory=names(mushroom)[-dim(mushroom)[2]],
                       x=mushroom[id.train,])
nb_mush_2_fitted<-bn.fit(nb_mush_2,mushroom[id.train,],"mle")

estimacion_error(clasificador = nb_mush_2_fitted, indice_clase = dim(mushroom)[2], 
                 test = mushroom[id.test,])

num_instancias<-dim(car)[1]
permutation<-order(runif(num_instancias))
id.train<-permutation[1:(training*num_instancias)]
id.test<-permutation[(training*num_instancias+1):num_instancias]

tan_car_2<-tree.bayes(x=car[id.train,],
                      training=names(car)[dim(car)[2]],
                      explanatory=names(car)[-dim(car)[2]])
tan_car_2_fitted<-bn.fit(x=tan_car_2,data=car[id.train,],method="mle")
estimacion_error(clasificador = tan_car_2_fitted,indice_clase = dim(car)[2], 
                 test = car[id.test,])


## ----kcv,prompt=TRUE,warning=FALSE---------------------------------------
bn.cv(data=car,bn=tan_car,loss="pred",k=5)


## ----estructuras_sesgadas,prompt=TRUE,warning=FALSE,fig.show='hide',fig.path="./figures/",fig.keep='all',cache=TRUE,fig.width=15,fig.height=5----
data<- learning.test
vars<-names(data)
N<- dim(data)[1]
N_test<- dim(data)[1]/2
N_train<-round(exp(seq(1,log(N-N_test),
                          (log(N_test)-1)/50)))

#Estructuras FIJAS:
#Cadena
chain.struc<-empty.graph(c("A","B","C","D","E","F"))
arcs(chain.struc) <-  matrix(c("A","B","B", "C", "C","D","D", "E",
                  "E", "F"), ncol = 2, byrow = TRUE,
                dimnames = list(NULL, c("from", "to")))

#naive Bayes
naive.struc<-empty.graph(c("A","B","C","D","E","F"))
arcs(naive.struc) <-  matrix(c("A", "B", "A", "C", "A", "D","A", "E",
                  "A", "F"), ncol = 2, byrow = TRUE,
                dimnames = list(NULL, c("from", "to")))

#sabiondo Bayes
sabiondo.struc<- empty.graph(vars)
arcs(sabiondo.struc) <-  matrix(c("B", "A", "C", "A", "D", "A","E", "A",
                  "F", "A"), ncol = 2, byrow = TRUE, dimnames = 
                    list(NULL, c("from", "to")))

  
#tree augmented naive Bayes
tree.struc<-empty.graph(vars)
arcs(tree.struc) <-  matrix(c("A", "B", "A", "C", "A", "D","A", "E",
                  "A", "F","B", "C","C","D","D", "E",
                  "E", "F"), ncol = 2, byrow = TRUE, dimnames = 
                    list(NULL, c("from", "to")))
#Regla de Bayes (implementada con la verosimilitud por eficiencia)
Bayes_rule<- function(x,model,id_clase=1){
  options(warn=-1)
  omega_C<-levels(x[[id_clase]])
  log_p= matrix(rep(0,dim(x)[1]*length(omega_C)),ncol=length(omega_C))
  for(i in 1:length(omega_C)){
    cl<-omega_C[i]
    x[[id_clase]]<-factor(rep(cl,dim(x)[1]),levels=omega_C)
    log_p[,i]= logLik(object = model, data= x, by.sample = T)
  }
  options(warn=0)
  apply(log_p,MARGIN=1,FUN=function(x){id<-which(x==max(x));omega_C[id]}) 
}

error<-function(data, model, id_clase=1){
  sum(Bayes_rule(data,model)!=data[,id_clase])/dim(data)[1]
}

res<-data.frame()
num_rep<-20
for(r in 1:num_rep){

  for(s in unique(N_train)){
      #Generar train y test
      permutation<-order(runif(N)) 
      id.train<-permutation[1:s]
      id.test<-permutation[(N-N_test+1):N]
      train<-data[id.train,]
      test<-data[id.test,]
      
      chain.model<- bn.fit(x= chain.struc, data= train, method = "bayes")
      res<- rbind(res,data.frame("size_train"=s,
                                 "error"=error(data= test,model = chain.model,id_clase = 1), 
                                 "data"="test","rep"=r, "estructura"="chain"))
      res<- rbind(res,data.frame("size_train"=s,
                                 "error"=error(data= train,model = chain.model,id_clase = 1), 
                                 "data"="train","rep"=r, "estructura"="chain"))
      
      naive.model<- bn.fit(x= naive.struc, data= train, method = "bayes")
      res<- rbind(res,data.frame("size_train"=s,
                                 "error"=error(data= test,model = naive.model,id_clase = 1), 
                                 "data"="test","rep"=r, "estructura"="naive"))
      res<- rbind(res,data.frame("size_train"=s,
                                 "error"=error(data= train,model = naive.model,id_clase = 1), 
                                 "data"="train","rep"=r, "estructura"="naive"))
      
      tree.model<- bn.fit(x= tree.struc, data= train, method = "bayes")
      res<- rbind(res,data.frame("size_train"=s,
                                 "error"=error(data= test,model = tree.model,id_clase = 1), 
                                 "data"="test","rep"=r, "estructura"="tree"))
      res<- rbind(res,data.frame("size_train"=s,
                                 "error"=error(data= train,model = tree.model,id_clase = 1), 
                                 "data"="train","rep"=r, "estructura"="tree"))
      
      sabiondo.model<- bn.fit(x= sabiondo.struc, data= train, method = "bayes")
      res<- rbind(res,data.frame("size_train"=s,
                                 "error"=error(data= test,model = sabiondo.model,id_clase = 1), 
                                 "data"="test","rep"=r, "estructura"="sabiondo"))
      res<- rbind(res,data.frame("size_train"=s,
                                 "error"=error(data= train,model = sabiondo.model,id_clase = 1), 
                                 "data"="train","rep"=r, "estructura"="sabiondo"))
  }
}

ggplot(data = res,aes(x=size_train,y = error,
                      col=data))+geom_line(stat="summary",
                                           fun.y = "mean",size=1.1
                                           )+scale_x_log10()+facet_wrap(~estructura)


ggplot(data = res,aes(x=size_train,y = error,
                      col=estructura))+geom_line(stat="summary",
                                                 fun.y = "mean",size=1.1
                                                 )+scale_x_log10()+facet_wrap(~data)

layout(matrix(1:4,ncol=4,byrow=TRUE))
plot(chain.struc)
plot(naive.struc)
plot(tree.struc)
plot(sabiondo.struc)



## ----selective_mv,prompt=TRUE,tidy=FALSE,cache=TRUE,tidy=FALSE,warning=FALSE----
selective_mb<-function (data,training){
  net<-hc(data)
  selected<-mb(net,training)
  data_filtered<-data[,c(training,selected)]
  model<-naive.bayes(training=training,explanatory=selected,x=data_filtered)
  model_fitted<-bn.fit(model,data_filtered,"mle")
  list(model=model_fitted,
       features=selected,
       training=training)
}

predict_selective_mb<-function (model,data)
{
  data_filtered<-data[,c(model$training,model$features)]
  predict(model$model,data_filtered)
}

selective_nb<-selective_mb(data=mushroom,training="class")
selective_nb$features
#Holdout
ratio<-0.66
num_instancias<-dim(mushroom)[1]
permutation<-order(runif(num_instancias))
id.train<-permutation[1:(training*num_instancias)]
id.test<-permutation[(training*num_instancias+1):num_instancias]
snb<-selective_mb(data=mushroom[id.train,],training="class")
sum(predict_selective_mb(snb,data=mushroom[id.test,])!=
      mushroom[id.test,dim(mushroom)[2]])/length(mushroom[id.test,1])


## ----general_classifier,prompt=TRUE,tidy=FALSE,cache=TRUE,eval=TRUE------
general_bn<-function (data,training,explanatory,net=NULL){
  if(is.null(net)) net<-hc(data)
  graph<-as(amat(net),"graphNEL")
  model<-grain(graph,data=data,smooth=1/dim(data)[1])
  list(model=model,explanatory=explanatory,training=training)
}

predict_general_instance<-function (x,model){
  setEvidence(model$model,nodes=model$explanatory,states=x[model$explanatory])
  prob<-querygrain(model$model,nodes=model$training,type="marginal")
  m<-max(prob[[1]])
  id<-prob[[1]]==m
  names(prob[[1]])[id]
}

predict_general<-function (model,data){
  apply(data,MARGIN=1,FUN=predict_general_instance,model=model)
}

ratio<-0.66
num_instancias<-dim(mushroom)[1]
permutation<-order(runif(num_instancias))
id.train<-permutation[1:(ratio*num_instancias)]
id.test<-permutation[(ratio*num_instancias+1):num_instancias]
gbn<-general_bn(data=mushroom[id.train,],
                training=names(mushroom)[dim(mushroom)[2]],
                explanatory=names(mushroom)[-dim(mushroom)[2]])

sum(predict_general(gbn,data=mushroom[id.test,])!=
      mushroom[id.test,dim(mushroom)[2]])/length(mushroom[id.test,1])

sum(predict_selective_mb(snb,data=mushroom[id.test,])!=
      mushroom[id.test,dim(mushroom)[2]])/length(mushroom[id.test,1])


## ----test_indep,prompt=TRUE----------------------------------------------
test<-ci.test(x=names(car)[1],y=names(car)[2],data=car)
test
test$p.value


