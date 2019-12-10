#Load required libraries
library(readxl)      #for excel, csv sheets manipulation
library(sdcMicro)    #sdcMicro package with functions for the SDC process 
library(tidyverse)   #optional #for data cleaning

#Import data
#https://data.humdata.org/dataset/caracterizacion-rapida-de-necesidades-humanitarias-de-migrantes-en-transito-peatonal-ocha
setwd("C:/Users/LENOVO T46OS/Desktop/sdc-iMMap-microdata2")
data <-read_excel("data.xlsx", sheet = "Datos_OCHA")
#Select key variables                   
selectedKeyVars <- c('lugar_digitacion', 'genero', 'edad',
                     'num_personas_viaja', 'edo_procedencia_venezuela',
                     'muni_procedencia_venezuela', 'lugar_ult_ingreso_colombia',
                     'lugar_inicio_caminata', 'dias_caminando',
                     'dias_restantes_camina', 'percepcion_salud_propia',
                     'destino_1', 'destino_2', 'destino_3', 'destino_4',
                     'ruta_destinos',	'destino_final', 'num_hijos',
                     'periodo_volveria_vzla', 'riesgo_viol_sex', 'etnia')

#select weights
#weightVars <- c('weights')

#Convert variables to factors
cols = c('lugar_digitacion', 'genero', 'edad',
           'num_personas_viaja', 'edo_procedencia_venezuela',
           'muni_procedencia_venezuela', 'lugar_ult_ingreso_colombia',
          'lugar_inicio_caminata', 'dias_caminando',
           'dias_restantes_camina', 'percepcion_salud_propia',
          'destino_1', 'destino_2', 'destino_3', 'destino_4',
          'ruta_destinos',	'destino_final', 'num_hijos',
              'periodo_volveria_vzla', 'etnia')

data[,cols] <- lapply(data[,cols], factor)

#Convert sub file to a dataframe
subVars <- c(selectedKeyVars)
fileRes<-data[,subVars]
fileRes <- as.data.frame(fileRes)
objSDC <- createSdcObj(dat = fileRes, 
                       keyVars = selectedKeyVars
                       )

#print the risk
print(objSDC, "risk")

#Generate an internal (extensive) report
report(objSDC, filename = "index",internal = T, verbose = TRUE) 

