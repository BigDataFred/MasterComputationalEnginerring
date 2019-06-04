#########################################################################################################################
# 
rm(list=ls())
conjunto <- c("A", "B", "C", "D", "E")
#valores  <- c( 1 ,  1 ,  2 ,  1 ,  2 )
valores  <- c( 1 , 1 ,  2 ,  1 ,  2 )

preferencia <- c("B", "A", "E", "D", "C")

#########################################################################################################################
# 
# 1. Se trata de dar el primero del ranking de los elementos del conjunto según los valores, de mayor a menor. 
#Si existe algún empate o igualdad, un elemento precede a otro según el orden de preferencia.
# Da el código {...} de una función que determina el primero del ranking, dados, de forma general, un conjunto finito, 
#los valores de sus elementos, y un orden de preferencia entre ellos. 
#En el ejemplo:

ranking1 <- function(conjunto, valores, preferencia){
  sortDat <- sort(valores,decreasing=TRUE)
  maxVal <- max(sortDat)
  tmp <- valores < maxVal
  idx <-which(valores %in% tmp==FALSE)
  
  selDat <-conjunto[idx]
  
  posIx <- seq(0,0,length.out = length(idx))
  for (curIter in 1:length(idx)){
    posIx[curIter]<-which(preferencia %in% selDat[curIter])
  }
  outDat <- preferencia[min(posIx)]
  return(outDat)
}

ranking1(conjunto, valores, preferencia)

#########################################################################################################################
#
# 2. Se trata de dar el ranking de los elementos del conjunto según los valores, de mayor a menor. 
#Si existe algún empate o igualdad, un elemento precede a otro según el orden de preferencia.
#Da el código {...} de una función que determina el ranking, dados, de forma general, un conjunto finito, los valores 
#de sus elementos, y un orden de preferencia entre ellos. En el ejemplo:

ranking <- function(conjunto, valores, preferencia){
  outDat <-vector(length=length(conjunto))
  cnt <-0
  while (length(valores)>0){
    cnt <- cnt+1
    sortDat <- sort(valores,decreasing=TRUE)
    maxVal <- max(sortDat)
    tmp <- valores < maxVal
    idx <-which(valores %in% tmp==FALSE)
    
    if ( length(idx)>1 ){
      selDat <-conjunto[idx]
      posIx <- seq(0,0,length.out = length(idx))
      for (curIter2 in 1:length(idx)){
        posIx[curIter2]<-which(preferencia %in% selDat[curIter2])
      }
      outDat[cnt] <- preferencia[min(posIx)]
      valores <- valores[-which(conjunto %in% outDat[cnt])]
      conjunto <- conjunto[-which(conjunto %in% outDat[cnt])]
      #preferencia <- preferencia[-min(posIx)]
    }
    else {
      outDat[cnt] <- conjunto[idx]
      conjunto <- conjunto[-idx]
      valores <- valores[-idx]
      #preferencia <- preferencia[-idx]
    }
    
  }
  
  return(outDat)
}

ranking(conjunto, valores, preferencia)
  