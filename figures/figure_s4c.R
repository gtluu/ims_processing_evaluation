library(Cardinal)
library(ggplot2)

image(pseudo1[['ssc']], model=pseudo1[['sscParams']], xlim=c(10, 130),
      col=c('#4DB777', '#39908C', '#FAE500', '#412D6D', '#77CD51',
            '#39678E', '#B7DD00', '#433A84', '#414B8B', '#4000D2',
            '#4DB788', '#39904E', '#FAE555', '#412D8B', '#77CD00',
            '#39676B', '#B7DD50', '#433A77'))

pseudo1Classes <- resultData(pseudo1[['ssc']], pseudo1[['sscParams']])$class
for (i in 1:length(levels(pseudo1Classes))) {
  print(i)
  print(length(pseudo1Classes[which(pseudo1Classes==i)]))
  print(' ')
}
