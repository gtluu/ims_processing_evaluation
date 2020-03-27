library(Cardinal)
library(ggplot2)
library(reticulate)
kneed <- import('kneed')
numpy <- import('numpy')

ssc <- as.data.frame(summary(pseudo5[['ssc']]))
colnames(ssc) <- c('r', 'k', 's', 'classes', 'features_per_class')

uniqueClasses <- c()
for (s in sparam) {
  uniqueFreq <- as.data.frame(table(sort(ssc[,c('s', 'classes')][which(ssc$s==s),]$classes)))
  colnames(uniqueFreq) <- c('classes', 'freq')
  uniqueFreq$weight <- (as.numeric(uniqueFreq$freq) / as.numeric(sum(uniqueFreq$freq)))
  uniqueClass <- as.numeric(length(uniqueFreq$classes) / max(uniqueFreq$weight))
  uniqueClasses <- c(uniqueClasses, uniqueClass)
}
# Find the knee of the curve of uniqueClasses vs sparam.
kneeParam <- 5
while(TRUE) {
  knee <- kneed$KneeLocator(x=sparam, y=uniqueClasses, S=kneeParam, curve='convex', direction='decreasing')$knee
  if (!is.null(knee)) {
    optimalS <- knee
    break
  }
  kneeParam <- kneeParam - 0.1
  if (kneeParam <= 0) {
    # Error if no optimal s parameter is found.
    stop('No s parameter identified.')
  }
}

figureS2b1 <- ggplot() +
  xlab('sparsity (s)') +
  ylab('weighted cardinality score') +
  geom_point(aes(x=sparam, y=uniqueClasses)) +
  geom_line(aes(x=sparam, y=uniqueClasses)) +
  geom_vline(xintercept=optimalS)
svg("figures2b1.svg")
print(figureS2b1)
dev.off()

uniqueClasses <- c()
for (s in sparam) {
  uniqueFreq <- as.data.frame(table(sort(ssc[,c('s', 'classes')][which(ssc$s==s),]$classes)))
  colnames(uniqueFreq) <- c('classes', 'freq')
  uniqueFreq$weight <- (as.numeric(uniqueFreq$freq) / as.numeric(sum(uniqueFreq$freq)))
  uniqueClass <- as.numeric(length(uniqueFreq$classes) / max(uniqueFreq$weight))
  uniqueClasses <- c(uniqueClasses, uniqueClass)
}
# Remove plateau resulting from k == classes.
for (i in 2:length(sparam)) {
  if (length(sparam) == length(uniqueClasses)) {
    if (uniqueClasses[1] == uniqueClasses[2]) {
      uniqueClasses <- uniqueClasses[2:length(uniqueClasses)]
      sparam <- sparam[2:length(sparam)]
    }
  }
}
# Find the knee of the curve of uniqueClasses vs sparam.
kneeParam <- 5
while(TRUE) {
  knee <- kneed$KneeLocator(x=sparam, y=uniqueClasses, S=kneeParam, curve='convex', direction='decreasing')$knee
  if (!is.null(knee)) {
    optimalS <- knee
    break
  }
  kneeParam <- kneeParam - 0.1
  if (kneeParam <= 0) {
    # Error if no optimal s parameter is found.
    stop('No s parameter identified.')
  }
}

figureS2b2 <- ggplot() +
  xlab('sparsity (s)') +
  ylab('weighted cardinality score') +
  geom_point(aes(x=sparam, y=uniqueClasses)) +
  geom_line(aes(x=sparam, y=uniqueClasses)) +
  geom_vline(xintercept=optimalS)
svg("figures2b2.svg")
print(figureS2b2)
dev.off()
