library(Cardinal)
library(stringr)
library(fuzzyjoin)
library(dplyr)
library(ggplot2)
library(reticulate)
kneed <- import('kneed')
numpy <- import('numpy')

# pseudo_list and lightdark should be loaded in already from previous analyses scripts

# Figure 3C
image(ssc, model=ssc_params, xlim=c(75,100), ylim=c(50,130),
      col=c('#FAE500', '#77CD51', '#39908C', '#414B8B'))
lightdark_classes <- resultData(ssc, ssc_params)$class
for (i in 1:max(levels(lightdark_classes))) {
  print(i)
  print(length(lightdark_classes[which(lightdark_classes==i)]))
  print(' ')
}