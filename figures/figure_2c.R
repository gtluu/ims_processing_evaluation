library(Cardinal)
library(stringr)
library(fuzzyjoin)
library(dplyr)
library(ggplot2)
library(reticulate)
kneed <- import('kneed')
numpy <- import('numpy')

# pseudo_list and lightdark should be loaded in already from previous analyses scripts

# Figure 2C
image(pseudo_list[['pseudo2']][['processed']], mz=210.9255, plusminus=0.2,
      normalize.image='linear', contrast.enhance='histogram', xlim=c(30,140))
image(pseudo_list[['pseudo2']][['processed']], mz=270.1304, plusminus=0.2,
      normalize.image='linear', contrast.enhance='histogram', xlim=c(30,140))
image(pseudo_list[['pseudo2']][['processed']], mz=609.1742, plusminus=0.2,
      normalize.image='linear', contrast.enhance='histogram', xlim=c(30,140))