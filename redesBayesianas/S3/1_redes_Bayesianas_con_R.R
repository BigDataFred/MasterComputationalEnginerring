## ----instalacion,eval=FALSE,prompt=TRUE----------------------------------
## source("http://bioconductor.org/biocLite.R")
## biocLite("graph")
## biocLite("RBGL")
## biocLite("Rgraphviz")
## install.packages("bnlearn")
## install.packages("gRain")
## install.packages("ggplot2")
## install.packages("gridExtra")


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


## ----plot_DAG,prompt=TRUE,fig.show='hide',fig.path="./figures/"----------
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


## ----ancestors, prompt=TRUE,fig.keep='none',fig.show='hide'--------------
ancestors(set="A",object=dag.study)
ancestralSet(set="C",object=dag.study)
plot(ancestralGraph(set="C",object=dag.study))


## ----moral_graph, prompt=TRUE,fig.path='./figures/',fig.show='hide'------
moral.graph<-moralize(dag.study)
plot(moral.graph)
maxClique(moral.graph)


## ----useparation, prompt=TRUE--------------------------------------------
separates("A","J","C",moral.graph)
separates("A","J",c("C","S"),moral.graph)


