library(Cardinal)
library(ggplot2)

image(pseudo5[['ssc']], model=pseudo5[['sscParams']], xlim=c(75, 350),
      col=c('#FAE500', '#39908C', '#39909E', '#412D6D', '#77CD51',
            '#39678E', '#414B8B', '#B7DD00', '#433A84', '#6DB777',
            '#4055B5', '#4DB788'))

pseudo5Classes <- resultData(pseudo5[['ssc']], pseudo5[['sscParams']])$class
for (i in 1:length(levels(pseudo5Classes))) {
  print(i)
  print(length(pseudo5Classes[which(pseudo5Classes==i)]))
  print(' ')
}
