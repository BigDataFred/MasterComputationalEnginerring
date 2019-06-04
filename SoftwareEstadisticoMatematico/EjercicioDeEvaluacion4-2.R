library(MASS)
library(lattice) 
data(biopsy)
biopsy

# 1. Preprocesamiento.
# i. ¿Cuáles son los objetos a los que les faltan datos?
# ii. Define otro data.frame con los objetos que tienen los datos completos. A partir de ahora trabaja con  este data.frame.

d = dim(biopsy)
cnt = 0
delIx <-vector()
for ( ix in 1:d[1] ){
  if ( any(is.na(biopsy[ix,])) ){
    cnt = cnt+1
    delIx = append(delIx,ix)
  }
}
print(delIx)# objetos a los que les faltan datos

selIx = setdiff(1:d[1],delIx)
dfNew = data.frame(biopsy[selIx,])# data.frame con los objetos que tienen los datos completos
is.data.frame(dfNew)


# 2. Análisis descriptivo univariante.
# i.¿Cuántas modalidades tiene cada una de las variables?
# ii. ¿Cuál es el tipo de gráfico más apropiado para representar la variabilidad de las 9 variables V1 a V9?
# iii. Todas las variables, salvo una, son cuantitativas de carácter ordinal. Calcula los estadísticos que creas oportuno para describir su tendencia central y su dispersión.
# iv. Describe la variable cualitativa.
# v. Haz comentarios sobre el grado de variabilidad de las variables.
d = dim(dfNew)
n <- vector(length=d[2])
for (ix in 1:d[2]){
  n[ix] <- length(unique(dfNew[,ix]))
}
names(n) <- colnames(dfNew) 

print(n)#numero de modalidades de cada una de las variables (i)

saveName <-'FredericRouxEj4_2a.pdf'
pdf(saveName,width=8,height=5)
boxplot(dfNew[,2:10])#gráfico más apropiado para representar la variabilidad de las 9 variables V1 a V9 (ii)
dev.off()

#Calcula los estadísticos que creas oportuno para describir su tendencia central y su dispersión (iii)
m1 <- vector(length=d[2]-2)
m2 <- vector(length=d[2]-2)
for (iter in 2:(d[2]-1)){
  m1[iter-1] <- median(dfNew[,iter])
  w <- table(dfNew[,2])
  tmp <- w[max(w)==w]
  m2[iter-1] <- strtoi(names(tmp))
}

tc <- data.frame(m1,m2)
colnames(tc)<-c('Median','Mode')
print(tc)

# Describe la variable cualitativa (iv)
tt <- dfNew[d[2]]
bc <- vector(length=length(tt))
bc[tt=='benign'] <-0
bc[tt=='malignant'] <-1
w <-table(bc)
names(w) <- c('benign','malignant')
print('numero de casos')
print(w)

# Haz comentarios sobre el grado de variabilidad de las variables (v)
# La variabilidad de las variables es bastante heterogena, es decir se puede observar que 
# la distribucion de los valores dentro de la escala de 1-10 es diferente entre las variables.
# Aun que la distribucion de los valores difere entre variables, todas tienen en comun que el 
# valor o rango "1", es el valor el mas frecuente en cada variable (es decir el modo).


#3. Análisis descriptivo bivariante. Asociaciones entre las variables cuantitativas.
# i.Representa gráficamente las relaciones entre las variables cuantitativas ordinales.
# ii. Calcula las correlaciones entre las variables cuantitativas ordinales.
# iii. ¿Cuáles son las dos variables cuantitativas más correladas? Muestra gráficamente esta relación.

p <- data.frame()
cnt <-0
for (ix in 2:(d[2]-2)){
  for (ix2 in (ix+1):(d[2]-1)){
    cnt <- cnt+1
    p[cnt,1] <- ix 
    p[cnt,2] <- ix2
  }
}

#Representa gráficamente las relaciones entre las variables cuantitativas ordinales (i).
saveName <-'FredericRouxEj4_2b.pdf'
pdf(saveName,width=12,height=9)
par(mfrow=c(6,6))
for (ix in 1:max(dim(p))){
  tmp <- table(dfNew[,p[ix,1]],dfNew[,p[ix,2]])
  d3 <- dim(tmp)
  for (ix2 in 1:d3[2]){
    tmp[,ix2] = tmp[,ix2]/sum(tmp[,ix2])
  }
  image(tmp,xlab=colnames(dfNew)[p[ix,1]],ylab=colnames(dfNew)[p[ix,2]])
  title(paste('rxy:',round(cor(dfNew[,c(p[ix,1],p[ix,2])])[1,2]*10)/10))
}
dev.off()

#Calcula las correlaciones entre las variables cuantitativas ordinales (ii)
cnt <- 0
d2 <- dim(p)
rxy <- vector(length=d2[1])
for (ix in 1:d2[1]){
  tmp <- cor(dfNew[,c(p$V1[ix],p$V2[ix])],method='spearman')
  cnt <- cnt+1
  rxy[cnt] <- tmp[1,2]
}

maxIx <- c(p$V1[which.max(rxy)],p$V2[which.max(rxy)]) 
# las dos variables cuantitativas más correladas son (iii):
print('las dos variables cuantitativas más correladas son:')
print(colnames(dfNew[maxIx]))

#Muestra gráficamente esta relación (iii):
saveName <-'FredericRouxEj4_2c.pdf'
pdf(saveName,width=8,height=5)
tmp = table(dfNew[,maxIx[1]],dfNew[,maxIx[2]])
for (ix in 1:max(dim(tmp)) ){
  tmp[,ix] <- tmp[,ix]/sum(tmp[,ix])
}
image(tmp,xlab=colnames(dfNew)[maxIx[1]],ylab=colnames(dfNew)[maxIx[2]])
dev.off()

# 4. Análisis descriptivo bivariante. Asociaciones entre las variables cuantitativas y la variable cualitativa 'class'.
# i.Representa gráficamente las relaciones entre las variables cuantitativas y la variable cualitativa.
# ii. Calcula las correlaciones entre las variables cuantitativas y las variable cualitativa.
# iii. ¿Con qué variable cuantitativa está más correlacionada la variable cualitativa?

#Representacion gráfica de las relaciones entre las variables cuantitativas y la variable cualitativa (i).
saveName <-'FredericRouxEj4_2d.pdf'
pdf(saveName,width=8,height=5)
par(mfrow=c(3,3))
tmp <- dfNew[,11]
c <-vector(length=length(tmp))
c[tmp=='benign']=0
c[tmp=='malignant']=1
for (ix in 2:10){
  
  dat <- dfNew[,ix]
  m1 = median(dat[c==0])
  m2 = median(dat[c==1])
  barplot(c(m1,m2),col=c('blue','red'))
  axis(1,at=c(1,2),labels=c('benign','malignant'))
  title(colnames(dfNew)[ix])
}
dev.off()

#correlaciones entre las variables cuantitativas y las variable cualitativa
etaSq <- vector(length=length(colnames(dfNew))-2)
cnt <- 0
for (ix in 2:10){
  res.aov <- aov(dfNew[,ix] ~ class, data = dfNew)
  SS <- anova(res.aov)$'Sum Sq'
  cnt <- cnt+1
  etaSq[cnt] <- SS[1]/sum(SS)
}
names(etaSq) <- colnames(dfNew)[2:10]
print('correlaciones entre las variables cuantitativas y las variable cualitativa:')
print(etaSq)

#¿Con qué variable cuantitativa está más correlacionada la variable cualitativa?
print('La variable cuantitativa está más correlacionada con:')
print(names(which.max(etaSq)))
