library(Cardinal)
library(ggplot2)

image(pseudo4[['ssc']], model=pseudo4[['sscParams']], xlim=c(50, 170),
      col=c('#412D6D', '#4DB777', '#FAE500', '#77CD51', '#39678E',
            '#B7DD00', '#39908C'))

pseudo4Classes <- resultData(pseudo4[['ssc']], pseudo4[['sscParams']])$class
for (i in 1:length(levels(pseudo4Classes))) {
  print(i)
  print(length(pseudo4Classes[which(pseudo4Classes==i)]))
  print(' ')
}
