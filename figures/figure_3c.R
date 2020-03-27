library(Cardinal)
library(ggplot2)

image(lightdark[['ssc']], model=lightdark[['sscParams']], xlim=c(75, 275),
      col=c('#39908C', '#B7DD00', '#77CD51', '#39678E', '#412D6D',
            '#FAE500'))

lightdarkClasses <- resultData(lightdark[['ssc']], lightdark[['sscParams']])$class
for (i in 1:length(levels(lightdarkClasses))) {
  print(i)
  print(length(lightdarkClasses[which(lightdarkClasses==i)]))
  print(' ')
}

lightdarkClasses <- resultData(sscPartial, lightdark[['sscParams']])$class
for (i in 1:length(levels(lightdarkClasses))) {
  print(i)
  print(length(lightdarkClasses[which(lightdarkClasses==i)]))
  print(' ')
}
