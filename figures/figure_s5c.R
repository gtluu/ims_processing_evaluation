library(Cardinal)
library(ggplot2)

image(pseudo3[['ssc']], model=pseudo3[['sscParams']], xlim=c(55, 175),
      col=c('#433A84', '#FAE500', '#39908C', '#412D6D', '#B7DD00',
            '#414B8B', '#39678E', '#4DB777', '#77CD51'))

pseudo3Classes <- resultData(pseudo3[['ssc']], pseudo3[['sscParams']])$class
for (i in 1:length(levels(pseudo3Classes))) {
  print(i)
  print(length(pseudo3Classes[which(pseudo3Classes==i)]))
  print(' ')
}
