library(Cardinal)
library(stringr)
library(fuzzyjoin)
library(dplyr)
library(ggplot2)
library(reticulate)
kneed <- import('kneed')
numpy <- import('numpy')

# pseudo_list and lightdark should be loaded in already from previous analyses scripts

# Figure S2
unique_classes <- c()
for (s in sparam) {
  unique_freq <- as.data.frame(table(sort(ssc[,c('s', 'classes')][which(ssc$s==s),]$classes)))
  colnames(unique_freq) <- c('classes', 'freq')
  unique_freq$weight <- (as.numeric(unique_freq$freq) / as.numeric(sum(unique_freq$freq)))
  unique_classes <- c(unique_classes, as.numeric(length(unique_freq$classes) / max(unique_freq$weight)))
}

skneeparam <- 1
while(TRUE) {
  knee <- kneed$KneeLocator(x=sparam, y=unique_classes, S=skneeparam, curve='convex', direction='decreasing')$knee
  if (!is.null(knee)) {
    optimal_s <- knee
    break
  }
  skneeparam <- skneeparam - 0.1
  if (skneeparam <= 0) {
    return('No s parameter identified')
  }
}

figure_s2 <- ggplot() +
  xlab('sparsity (s)') +
  ylab('weighted cardinality score') +
  geom_point(aes(x=sparam, y=unique_classes)) +
  geom_line(aes(x=sparam, y=unique_classes)) +
  geom_vline(xintercept=optimal_s)
svg("Figure S2.svg")
print(figure_s2)
dev.off()