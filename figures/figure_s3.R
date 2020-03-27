library(Cardinal)
library(ggplot2)

image(pseudo5[['ssc']], model=pseudo5[['sscParams']], xlim=c(75, 350),
      col=c('#FAE500', '#39908C', '#39909E', '#412D6D', '#77CD51',
            '#39678E', '#414B8B', '#B7DD00', '#433A84', '#6DB777',
            '#4055B5', '#4DB788'))

image(pseudo5[['ssc']], model=list(r=3, k=12, s=9), xlim=c(75, 350),
      col=c('#39678E', '#6DB777', '#39908C', '#39909E', '#77CD51',
            '#FAE500', '#414B8B', '#433A84', '#B7DD00', '#4055B5',
            '#412D6D'))
