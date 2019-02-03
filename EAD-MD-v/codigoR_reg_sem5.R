# En este documento tienes el codigo de R para que puedas reproducir
# los ejemplos comentados durante la semana 5 - MODELOS DE REGRESION

# Lectura de datos ventahelados.dat-------------------------
helados <- read.table("ventahelados.dat", header=TRUE)
# Comprueba que el conjunto de datos esta en tu carpeta de trabajo

# Comprobamos que lo hemos leido bien
head(helados)
dim(helados) # Consta de 60 casos y 3 variables
names(helados)

# REGRESION SIMPLE------------------------------------------
# Diagrama de dispersion
plot(helados$temp, helados$ventas, xlab="Temperatura", ylab="Venta helados")

# Ajustamos el modelo de regresion lineal simple
rl <- lm(ventas ~ temp, data=helados)
rl
summary(rl)
anova(rl)
# Detalles
rl$coeff # coeficientes de la recta
rl$fitted.values # valores ajustados, y con gorro
rl$residuals # residuos, e_i



# REGRESION LINEAL MULTIPLE----------------------------------

# Introduccion de los datos
Coste <- c(22.6,15.0,78.1,28.0,80.5,24.5,20.5,147.6,4.2,48.2,20.5)
Ficheros <- c(4,2,20,6,6,3,4,16,4,6,5)
Flujos <- c(44,33,80,24,227,20,41,187,19,50,48)
Procesos <- c(18,15,80,21,50,18,13,137,15,21,17)
datos <- data.frame(Coste,Ficheros,Flujos,Procesos)

# Diagramas de dispersion
plot(datos)

# Ajustamos el modelo de regresion lineal multiple
regCoste <- lm(Coste~Ficheros+Flujos+Procesos, data=datos)

summary(regCoste)
anova(regCoste)

# Detalles
regCoste$coeff # coeficientes del modelo lineal
regCoste$fitted.values # valores ajustados, y con gorro
regCoste$residuals # residuos, e_i

# MODELO LINEAL GENERAL (GLM)-------------------------------
# Retomamos el conjunto de datos ventahelados.dat

# Diagrama de dispersion
plot(helados$temp, helados$ventas, xlab="Temperatura", ylab="Venta helados")
points(helados$temp, helados$ventas, pch=21, bg=helados$tipodia) #Coloreamos los puntos segun el tipo de dia
legend("bottomright", legend=c("laboral", "vispera", "festivo"), pch=21, col=1:3, bty="n") # A??adimos la leyenda con los tipos de colores

# Miramos que clase tiene asociada la variable "tipodia"
class(helados$tipodia)
# Como no es un "factor", hay que convertirlo a factor. Asi R entendera que necesita generar
# las correspondientes variables indicadoras Z1 y Z2
helados$tipodia <- as.factor(helados$tipodia)

# Modelo Lineal General
ml <- glm(ventas ~ temp + tipodia, data=helados)
summary(ml)

# Algunos detalles
ml$coeff
ml$residuals
ml$fitted.values

# DIAGNOSTICO DEL MODELO----------------------------
# Consideraremos el modelo ml
ml <- glm(ventas ~ temp + tipodia, data=helados)

# Miraremos los residuos frente a los valores predichos
ei <- ml$residuals
ri <- rstandard(ml)
ygorro <- ml$fitted.values
plot(ygorro, ei, xlab=expression(hat(y)), ylab="residuos")
abline(h=0, col="grey")

plot(ygorro, ri, xlab=expression(hat(y)), ylab="residuos estandarizados")
abline(h=0, col="grey")
# No parece que haya un patron determinado. 
# No hay ningun residuo con valor extremadamente grande

# Calculamos los leverage
hii <- hatvalues(ml)
plot(hii, type="h", ylab=expression(H[ii]), xlab="individuos", lwd=1.5)

# Calculamos la distancia de Cook
Di <- cooks.distance(ml)
plot(Di, type="h", ylab=expression(D[i]), xlab="individuos",  lwd=1.5)
# No hay ningun individuo extremadamente influyente

