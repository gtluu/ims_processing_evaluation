library(Cardinal)
library(stringr)
library(fuzzyjoin)
library(dplyr)
library(ggplot2)
library(reticulate)
kneed <- import('kneed')
numpy <- import('numpy')

# pseudo_list and lightdark should be loaded in already from previous analyses scripts

# Figure S3A
image(pseudo_list[['pseudo3']][['ssc']], model=list(r=1, k=8, s=12), xlim=c(30,150))

# Figure S3B
image(pseudo_list[['pseudo3']][['ssc']], model=list(r=2, k=8, s=12), xlim=c(30,150))