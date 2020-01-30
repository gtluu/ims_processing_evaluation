library(Cardinal)
library(stringr)
library(fuzzyjoin)
library(dplyr)
library(ggplot2)
library(reticulate)
kneed <- import('kneed')
numpy <- import('numpy')

# pseudo_list and lightdark should be loaded in already from previous analyses scripts

# Figure S4C
image(pseudo_list[['pseudo1']][['ssc']], model=pseudo_list[['pseudo1']][['optimal_ssc_params']], xlim=c(10,90))
pseudo1_classes <- resultData(pseudo_list[['pseudo1']][['ssc']], pseudo_list[['pseudo1']][['optimal_ssc_params']])$class
for (i in 1:max(levels(pseudo1_classes))) {
  print(i)
  print(length(pseudo1_classes[which(pseudo1_classes==i)]))
  print(' ')
}