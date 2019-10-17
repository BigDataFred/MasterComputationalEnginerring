## ----instalacion,eval=FALSE,prompt=TRUE----------------------------------
##install.packages("pkgconfig")
##install.packages("rtools")
##BiocManager::install(c("graph","RBGL","Rgraphviz"))
##install.packages("BiocManager")
#BiocManager::install()
##install.packages("bnlearn")
##install.packages("gRain")
##install.packages("gridExtra")
##install.packages("ggplot2")


## ----loading_1,prompt=TRUE,message=FALSE---------------------------------
library(bnlearn)
library(gRbase)
library(RBGL)


## ----create_DAG, prompt=TRUE---------------------------------------------
dag.study<-dag(~S,~J,~C*S*J,~A*S*C)
dag.study<-dag(~S + J + C*S*J + A*S*C)
dag.study<-dag(~S + J + C|S*J + A|S*C)
dag.study<-dag("S","J",c("C","S","J"),c("A","S","C"))
dag.study


## ----plot_DAG,prompt=TRUE,fig.show='asis',fig.path="./figures/"----------
plot(dag.study)


## ----create_adj_matrix, prompt=TRUE--------------------------------------
adjmat.study<-dag(~S + J + C|S*J + A|S*C,result="matrix")
adjmat.study


## ----matrix_to_graph, prompt=TRUE----------------------------------------
dag.study<-as(adjmat.study,"graphNEL")
dag.study


## ----graph_info, prompt=TRUE---------------------------------------------
nodes(dag.study)
graph::nodes(dag.study)
edges(dag.study)


## ----graph_info_2, prompt=TRUE-------------------------------------------
edgeList(dag.study)


## ----parents_children, prompt=TRUE---------------------------------------
gRbase::parents(set="C",object=dag.study)
gRbase::children(set="C",object=dag.study)


## ----ancestors, prompt=TRUE,fig.path="./figures/",fig.show='asis'--------------
ancestors(set="A",object=dag.study)
ancestralSet(set="C",object=dag.study)
plot(ancestralGraph(set="C",object=dag.study))


## ----moral_graph, prompt=TRUE,fig.path='./figures/',fig.show='asis'------
moral.graph<-moralize(dag.study)
plot(moral.graph)
maxClique(moral.graph)


## ----useparation, prompt=TRUE--------------------------------------------
separates("A","J","C",moral.graph)
separates("A","J",c("C","S"),moral.graph)


## ----EJERCICIO 3.1, prompt=TRUE,fig.show='asis'--------------------------------------------
#EJERCICIO 3.1
#Empleando las funciones que se han presentado en el tutorial, implementar una funcion que
#implemente el metodo de la d-separacion para leer independencias condicionadas a partir del grafo
dag.study<-dag(~S + J + C|S*J + A|S*C)
plot(dag.study)

# cual es el subgrafo inducido por los nodos del conjunto ancetral Xa,Xb,Xc?
# moralizar dicho subgrafo
moral.graph<-moralize(dag.study)
plot(moral.graph)

# indep de un grafo
checkIndep  <- function(Xa,Xb,Xc,g){
  chck<-separates(Xa,Xb,Xc,g)## comprueba si las variables que condicionen Xc, bloquean todos los caminos que van de las variables Xa a Xb

  return(chck)
}

# comprobar si las variables que condicionen Xc, bloquean todos los caminos que van de las variables Xa a Xb
checkIndep("A","J",c("C","S"),moral.graph)

## ----EJERCICIO 3.2, prompt=TRUE,fig.show='asis'--------------------------------------------
#EJERCICIO 3.2
#Dado el DAG de la Figura 2:

#  Comprobar si se verifican las independencias (1; 4|5), (1; 5|3; 4), (6; 7|3), (1; 7|5), (1; 4|6) y (1; 4|2; 3)

# creamos el dag segun la figura 2
dag.study<-dag(~1 + 2 + 7 + 3|1*2 + 4|2*7 + 6|3 + 5|3*4)
plot(dag.study)#visualizamos el dag

#moralizamos el dag
moral.graph<-moralize(dag.study)
plot(moral.graph)#visualizamos el dag

# lista para definir los conjuntos Xa,Xb,Xc
Xa<-c("1","1","6","1","1","1")
Xb<-c("4","5","7","7","4","4")
Xc<-list(a="5",b=c("3","4"),c="3",d="5",e="6",f=c("2","3"))

# Comprobamos si se verifican las independencias
for (ix in 1:length(Xa)){
  if (length(Xc[[ix]])>1){
    print( paste("i(",Xa[ix],",",Xb[ix],"|",Xc[[ix]][1],",",Xc[[ix]][2],")") )
  }
  else {
    print( paste("i(",Xa[ix],";",Xb[ix],"|",Xc[[ix]],")") )
  }
  print( checkIndep(Xa[ix],Xb[ix],Xc[[ix]],moral.graph) )
}

#  Que conjunto(s) de variables C verifican (1; 7|C) y (1; 5|C)

# Ejemplos de conjuntos C que verifican (1;7|C)
checkIndep("1","7",c("2","4"),moral.graph)
checkIndep("1","7",c("2","3"),moral.graph)
checkIndep("1","7",c("2","4","5"),moral.graph)
checkIndep("1","7",c("2","3","4","5"),moral.graph)

# Ejemplos de conjuntos C que verifican (1;5|C)
checkIndep("1","5",c("2","3"),moral.graph)
checkIndep("1","5",c("3","4"),moral.graph)

