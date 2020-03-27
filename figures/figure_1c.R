library(Cardinal)
library(ggplot2)

image(pseudo2[['ssc']], model=pseudo2[['sscParams']], xlim=c(30, 150),
      col=c('#4DB777', '#39908C', '#FAE500', '#412D6D', '#77CD51',
            '#39678E', '#B7DD00', '#433A84', '#414B8B', '#400054'))

pseudo2Classes <- resultData(pseudo2[['ssc']], pseudo2[['sscParams']])$class
for (i in 1:length(levels(pseudo2Classes))) {
  print(i)
  print(length(pseudo2Classes[which(pseudo2Classes==i)]))
  print(' ')
}
