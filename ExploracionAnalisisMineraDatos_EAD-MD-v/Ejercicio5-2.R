#El objetivo es estudiar las relaciones entre el sexo, la edad de aparici??n de la enfermedad y el EDSS.
rm(list=ls())
graphics.off()

# nombre del archivo PDF donde se guardaran los resultados
pdf(file='FREDERIC_ROUX_Ejercicio5-2_ead_md-v.pdf',width=5, heigh=10, paper='a4r')
plot.new()
par( mfrow=c(2,2) )

datos0  <- read.table('edss.dat',  fill = TRUE,header=TRUE, sep="\t", dec=",")# cargar datos en local

#############################
#??Qu?? tipo de an??lisis deber??amos hacer para estudiar la relaci??n entre EDSS y la edad de aparici??n de la enfermedad?

# El tipo de an??lisis que podria plantearse seria por ejemplo una regresion lineal donde la edad de aparicion de la enfermedad
# seria la variable independiente, y el EDSS seria la variable dependiente.
rl <- lm(EDSS..5.yr.a.o.. ~ Age.at.onset, data=datos0)
res<-summary(rl)
res# resultados del analisis de regresion lineal

yh <- rl$coefficients[1]+rl$coefficients[2]*datos0$Age.at.onset# valores predecidos por el modelo y^=b0+b1*x, 
                                                               #donde b0 es el intercepto, y b1 la pendiente de la funcion

yL1 <- c(min(datos0$EDSS..5.yr.a.o..),max(datos0$EDSS..5.yr.a.o..))
yL2 <- c(-max(datos0$EDSS..5.yr.a.o..),max(datos0$EDSS..5.yr.a.o..))

plot(datos0$Age.at.onset,datos0$EDSS..5.yr.a.o..,xlab='Age at onset [yrs]',ylab = 'EDSS [a.u.]',main='Linear model',pch=4,col='red',ylim=yL1)
lines(datos0$Age.at.onset,yh)
rs<-round(res$r.squared*100)/100
text(22,6.5,bquote(paste(R^2,paste(':',.(rs)))),col = 'red')

#############################
#  ??Qu?? tipo de an??lisis deber??amos hacer para estudiar la relaci??n entre EDSS y el sexo?  

# El tipo de an??lisis que podria plantearse seria por ejemplo aplicar un modelo lineal general donde el sexo
# seria la variable independiente, y el EDSS seria la variable dependiente.
ml <- glm(EDSS..5.yr.a.o.. ~ SEX, data=datos0)
summary(ml)

glmCoefs<-ml$coefficients

dum <- rep(0,nrow(datos0))
dum[datos0$SEX=='M']<-1

yh<-glmCoefs[1]+glmCoefs[2]*dum
y <- datos0$EDSS..5.yr.a.o..
res <- y-yh
plot(res,pch=21,bg='black',xlab='Index',ylab = 'Residuals [a.u.]',main='General linear model: Sex vs EDSS',ylim=yL2)
SSt <- sum((y-mean(y))^2)
SSreg <- sum((yh-mean(y))^2)
rs2 <- round(SSreg/SSt*100)/100
text(25,6.5,bquote(paste(R^2,paste(':',.(rs2)))),col='red')

#############################
#  ??Qu?? tipo de an??lisis deber??amos hacer para estudiar la relaci??n entre EDSS, la edad de aparici??n de la enfermedad y el sexo?

# El tipo de an??lisis que podria plantearse seria por ejemplo aplicar una regresion lineal multiple donde la edad de aparici??n de la enfermeda 
# y el sexo serian las variable independientes, y el EDSS seria la variable dependiente.
rl <- lm(EDSS..5.yr.a.o.. ~ Age.at.onset+SEX, data=datos0)
res<-summary(rl)# resultados del analisis de regresion lineal
res

#############################
#  Realiza un gr??fico adecuado con el que puedas valorar si EDSS est?? relacionado con la edad de aparici??n de la enfermedad y el sexo.
library(scatterplot3d)
s3d<-scatterplot3d(datos0$Age.at.onset,dum,datos0$EDSS..5.yr.a.o..,xlab = 'Age at onset [yrs]',ylab = 'Gender',zlab = 'EDSS [a.u.]',pch=16, highlight.3d=TRUE,
              type="h",main='Multiple linear regression') # grafico 3D con las 3 variables
s3d$plane3d(rl)# calculemos y representamos la funcion en 3D
rs3<-round(res$r.squared*100)/100
text(25,6.5,bquote(paste(R^2,paste(':',.(rs3)))),col='red')

#############################
#Ajusta un modelo para relacionar EDSS seg??n la edad de aparici??n de la enfermedad y el sexo. 
X1 <- datos0$Age.at.onset
X2 <- dum

(yh<-0.3127423 + 0.0930648*X1 + 1.832708*X2) # X1 = edad de aparici??n de la enfermedad
                                             # X2 = sexo

#############################
#Estudia si el modelo que has ajustado cumple las hip??tesis del modelo. ??Hay individuos influyentes?
Di <- cooks.distance(rl)
zDi <- (Di-mean(Di))/sd(Di)
(delIx<- which(t(t(zDi))>3.5))

plot(Di,type='h',main='Cooks distance')
# El individuo n.17 parece tener influencia. Tiene el indice de Cook muy elevado relativo con los otros individuos.

#############################
#  Seg??n el modelo que hayas ajustado, el retraso de 10 a??os en la aparici??n de la enfermedad, en media cu??nto aumenta la puntuaci??n EDSS? 

# El retraso de 10 a??os en la aparici??n de la enfermedad, aumenta en media la puntuaci??n EDSS de
0.0930648*10 # a??os

#############################
#??Cu??l es la media estimada de EDSS para una mujer que empez?? con la enfermedad a los 29 a??os? 

# La media estimada de EDSS para una mujer que empez?? con la enfermedad a los 29 a??os es de
0.3127423 +0.0930648*29 + 1.832708*0 #EDSS

#############################
#??Y para un hombre para el que la enfermedad tambi??n surgi?? a los 29 a??os?

# La media estimada de EDSS para un hombre que empez?? con la enfermedad a los 29 a??os es de
0.3127423 +0.0930648*29 + 1.832708*1 #EDSS

dev.off()   