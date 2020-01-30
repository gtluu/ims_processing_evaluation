library(Cardinal)
library(stringr)
library(fuzzyjoin)
library(dplyr)
library(ggplot2)
library(reticulate)
kneed <- import('kneed')
numpy <- import('numpy')

# pseudo_list and lightdark should be loaded in already from previous analyses scripts

# Figure 1C
image(pseudo_list[['pseudo2']][['ssc']], model=pseudo_list[['pseudo2']][['optimal_ssc_params']], xlim=c(30,150),
      col=c('#39678E', '#B7DD00', '#FAE500', '#39908C', '#4DB777', '#414B8B', '#77CD51', '#433A84', '#400054'))
pseudo2_classes <- resultData(pseudo_list[['pseudo2']][['ssc']], pseudo_list[['pseudo2']][['optimal_ssc_params']])$class
for (i in 1:max(levels(pseudo2_classes))) {
  print(i)
  print(length(pseudo2_classes[which(pseudo2_classes==i)]))
  print(' ')
}