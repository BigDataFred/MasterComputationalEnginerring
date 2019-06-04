#### Si teneis problemas en la instalacion del paquete "seewave"...
#### por favor, seguid las indicaciones que se muestran 
#### en esta pagina:
#### http://rug.mnhn.fr/seewave/inst.html
#### Ya que hay problemas de instalacion para Linux y Mac OS

## Instalacion de los paquetes R necesarios
paquetes <- c("fftw", "rgl", "rpanel", "tcltk2")
if (length(setdiff(paquetes, rownames(installed.packages()))) > 0) {
  install.packages(paquetes, repos="http://cran.at.r-project.org/")
}

## Paquetes necesarios
paquetes <- c("ggplot2", "gridExtra", "tuneR", "signal", 
              "seewave", "reshape", "reshape2", "pracma", 
              "GeneCycle", "waved", "RColorBrewer", "phonTools", 
              "monitoR", "soundgen", 
              "shiny", "kableExtra", "rmarkdown", "knitr", 
              "knitcitations", "caTools", "bitops", "rprojroot", 
              "dplyr", "pastecs")

## Si no han sido instalados, los instala
if (length(setdiff(paquetes, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(paquetes, rownames(installed.packages())), dependencies=TRUE, 			
                   repos="http://cran.at.r-project.org/")  
}

options(defaultPackages=c(getOption("defaultPackages"), paquetes))