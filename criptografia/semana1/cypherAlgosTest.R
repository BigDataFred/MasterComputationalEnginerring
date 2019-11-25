
## Cesar Cypher
al <- c("A","B","C","D","E","F","G","H","I","J","K","L","M","N","Ñ","O","P","Q","R","S","T","U","V","W","X","Y","Z")

men1 <- c("P","R","I","M","E","R","A")
men2 <- c("P","R","U","E","B","A")

cesaCypher <- function(al,me,key){
  out <- {}
  for (ix in 1:length(me)){
    selIx <- which(al == me[ix])
    if (selIx+key <=length(al)){
      selIx2 = selIx+key
    } else{
      selIx2 = (selIx+key) - length(al)
    }
    out[ix]<- al[selIx2]
  }
  return( out )
}

cesaCypher(al,men1,3)
cesaCypher(al,men2,3)

## Vignere Cypher
al <- LETTERS #c("A","B","C","D","E","F","G","H","I","J","K","L","M","N","Ñ","O","P","Q","R","S","T","U","V","W","X","Y","Z") #

convertKey <- function (al,key){
  cK <- vector( length=length(key) )
  for ( ix in 1:length(key) ){
    cK[ix] <- which(al == key[ix])-1
  }
  return(cK)
}

vignereCypher<-function( al, me, key){
  
  cK <- convertKey(al,key)
  cnt<-0
  out <- {}
  for ( ix in 1:length(me) ){
    cnt <- cnt+1
    selIx <- which(al == me[ix])-1
    selIx <- selIx + cK[cnt]
    if (selIx>length(al)){
      selIx <- selIx-length(al)
    }
    out[ix]<-al[selIx+1]
    key[cnt] <- al[selIx+1]
    if(cnt==length(key)){
      cnt<-0
      cK <- convertKey(al,key)
    }
  }
  return(out)
  
}

#vignereCypher(al,c("E","S","T","A","E","S","L"), c("S","O","L") )
y<-vignereCypher(al,c("V","I","G","E","N","E","R","E"), c("D","O","S") )
print(y)

## Decypher Vigenere
al <- LETTERS

decypherVigenere<- function(al,me,key){
  out <- {}
  cK<- convertKey(al,key)
  cnt <- 0
  print(key)
  for ( ix in 1:length(me) ){
    cnt <- cnt+1
    selIx <- which( al == me[ix] )-1-cK[cnt]
    if (selIx<0){
      selIx <-selIx+length(al)
    }
    out[ix]<-al[selIx+1]
    key[cnt] <- al[which( al == me[ix] )]
    if(cnt==length(key)){
      cnt<-0
      cK <- convertKey(al,key)
      print(key)
    }
  }
  return(out)
}

y<-decypherVigenere(al,c("Y","W","W","L","P","K"),c("D","O","S"))
print(y)

##
me <- c("C","O","S","A")

me2big <- function(me){
  out ={}
  cnt <-0
  for ( ix in seq(1,length(me),2) ){
    cnt<-cnt+1
    if (ix+1<=length(me)){
      x<-paste( me[ix],me[ix+1] )
    }else{
      x<-paste( me[ix]," " )
    }
    out[cnt]<-x
  }
  return(out)
}

y <- me2big(me)

par2num <- function(al,let){
  k <- vector(length=length(let))
  for (ix in 1:length(let)){
    k[ix]<- which(al==let[ix])-1
  }
  N<-length(al)
  x <- k[1]
  y <- k[2]
  out <- N*x+y
  return(out)
}

n1<-par2num(al,me[c(1,2)])
n2<-par2num(al,me[c(3,4)])
print(n1)
print(n2)

##
source("auxiliares/men2num.R")
source("auxiliares/num2men.R")
num2men(al,170,2)
num2men(al,494,2)

##
source("auxiliares/bit2men.R")
bit2men(al, c(0, 1, 0, 0, 1, 1, 1, 1, 0, 0), 2)

##
4^14%%7

# 14 = 2^3+2^2+2 <=> 1110
# 4^14 = 4^(2^3+2^2+2) 
#(((4^2x4)^2)^2x4)^2

##
al <- LETTERS
#m<-c("H","O","L","A")
#k<-c(5,2)

m <- c("C","A","S","A")
k<-c(3,5)
selIx<-vector(length=length(m))
for (ix in 1:length(m) ){
  selIx[ix]<- which(al==m[ix])-1 
}
print(selIx)


selIx2 <- vector(length=length(selIx))
for (ix in 1:length(selIx) ){
  selIx2[ix]<-(k[1]*selIx[ix]+k[2])%%length(al)
}
print(al[selIx2+1])

##
mcd<-function(a,b){
  a<-abs(a)
  b<-abs(b)
  flag<-1
  while (flag>=1){
    q <- as.integer(a/b)
    r<- a-(b*q)
    print(c(a,b,r,q))
    if(r<1){
      break
    }
    a<-b
    b<-r

  }
  return(b)
}

#mcd(560,427)
mcd(57,23)
mcd(-64,-12)