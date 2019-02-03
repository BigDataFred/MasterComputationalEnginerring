library(datasets)
data(iris)
iris

#####################################################################################################################################################
# 1 
#¿Cuáles son los identificadores de las plantas que tienen estas dos características a la vez: 
# largura del pétalo entre 1.6 y 4.0, y anchura del pétalo entre 1.2 y 1.5? (sin incluir esos valores puntuales: (1.6, 4.0), (1.2, 1.5) ).

selIx <-which(iris$Petal.Length>1.6 & iris$Petal.Length<4.0 & iris$Petal.Width >1.2 & iris$Petal.Width <1.5)
selIx
# los identificadores de las plantas son 60 e 65

#####################################################################################################################################################
#2
#¿Cuántas son las plantas del punto anterior 1.?
nPlantas <- length(selIx)
nPlantas
# son 2

#####################################################################################################################################################
#3
#¿De qué especies son las plantas del punto anterior 1?
plantSpecies <- unique(iris$Species[selIx])  
plantSpecies
# son del especies versicolor

#####################################################################################################################################################
#4
#¿Cuáles son los valores correspondientes a las demás características (largura del sépalo, anchura del sépalo) de las plantas del punto anterior 1.?
largSep <- iris$Sepal.Length[selIx]
anchSep <- iris$Sepal.Width[selIx]
largSep
anchSep

#####################################################################################################################################################
#5
#Ordena el conjunto de todas las plantas según la anchura del pétalo, de mayor a menor: 
#la planta que tenga la anchura más grande será la primera, y la que tenga la más pequeña la última. 
irisSorted <- iris[sort.list(iris$Petal.Width,decreasing = TRUE),]
irisSorted

#####################################################################################################################################################
#6
#Asigna a cada planta el lugar o puesto que ocupa en el ordenamiento anterior, 
#es decir, establece un ranking (desde la 1ª a la 150ª, y ten en cuenta los empates). 
#Añade una columna al dataframe 'iris' en la que aparezca en cada planta el puesto asignado (se trata de una variable numérica).
ranking <- rank(irisSorted$Petal.Width,ties.method = "min")
irisNew <- cbind(irisSorted,ranking)
irisNew

#####################################################################################################################################################
#7
#Considera los puestos que han resultado para las plantas de la especie 'setosa' 
#(recuerda que las plantas están ordenadas según la anchura del pétalo), y calcula la suma de los mismos. 
#Haz lo mismo con las especies 'virginica' y 'versicolor'. Al ser  la cantidad de plantas igual para cada especie, 
#la suma ordena las especies según la anchura del pétalo. Si las cantidades no fueran las mismas (50 de cada especie), 
#el orden entre las especies se calcularía mediante la media aritmética de cada especie. En cualquier caso, 
#se podría luego decir qué especie tiene, en general (o en términos medios), la mayor anchura del pétalo. 
#A partir de aquí entramos en cuestiones de estadística.

rankSumSetosa <-sum(irisNew[which(irisNew$Species=="setosa"),]$ranking)
rankSumVirginica <-sum(irisNew[which(irisNew$Species=="virginica"),]$ranking)
rankSumVersicolor <-sum(irisNew[which(irisNew$Species=="versicolor"),]$ranking)
rankSumSetosa
rankSumVirginica
rankSumVersicolor

nSetosa <- length(which(iris$Species=="setosa"))
nVirginica <- length(which(iris$Species=="virginica"))
nVersicolor <- length(which(iris$Species=="versicolor"))
nSetosa
nVirginica
nVersicolor
