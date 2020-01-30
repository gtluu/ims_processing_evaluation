library(Cardinal)
library(stringr)
library(fuzzyjoin)
library(dplyr)
library(ggplot2)
library(reticulate)
kneed <- import('kneed')
numpy <- import('numpy')

# pseudo_list and lightdark should be loaded in already from previous analyses scripts

# Figure S5C
image(pseudo_list[['pseudo3']][['ssc']], model=pseudo_list[['pseudo3']][['optimal_ssc_params']], xlim=c(50,140))
pseudo3_classes <- resultData(pseudo_list[['pseudo3']][['ssc']], pseudo_list[['pseudo3']][['optimal_ssc_params']])$class
for (i in 1:max(levels(pseudo3_classes))) {
  print(i)
  print(length(pseudo3_classes[which(pseudo3_classes==i)]))
  print(' ')
}