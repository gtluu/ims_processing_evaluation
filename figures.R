library(Cardinal)
library(stringr)
library(fuzzyjoin)
library(dplyr)
library(ggplot2)
library(reticulate)
kneed <- import('kneed')
numpy <- import('numpy')

# pseudo_list and lightdark should be loaded in already from previous analyses scripts

# Figure 1C
image(pseudo_list[['pseudo3']][['ssc']], model=list(r=pseudo_list[['pseudo3']][['optimal_ssc_params']]$r,
                                                    k=pseudo_list[['pseudo3']][['optimal_ssc_params']]$k,
                                                    s=pseudo_list[['pseudo3']][['optimal_ssc_params']]$s))

# Figure 2C
image(pseudo_list[['pseudo3']][['processed']], mz=210.9677,
      normalize.image='linear', contrast.enhance='histogram', smooth.image='gaussian')
image(pseudo_list[['pseudo3']][['processed']], mz=269.0520,
      normalize.image='linear', contrast.enhance='histogram', smooth.image='gaussian')
image(pseudo_list[['pseudo3']][['processed']], mz=609.1745,
      normalize.image='linear', contrast.enhance='histogram', smooth.image='gaussian')

# Figure 3C
image(lightdark[['ssc']], model=list(r=2, k=18, s=3))

# Figure S1
ssc <- as.data.frame(summary(ssc))
colnames(ssc) <- c('r', 'k', 's', 'classes', 'features_per_class', 'BIC')

figure_s1 <- ggplot() +
  xlab('sparsity (s)') +
  ylab('predicted # of segments') +
  geom_point(aes(x=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==2),]$s,
                 y=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==2),]$classes,colour='r=1, k=2'), shape=1) +
  geom_line(aes(x=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==2),]$s,
                y=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==2),]$classes,colour='r=1, k=2')) +
  geom_point(aes(x=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==4),]$s,
                 y=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==4),]$classes,colour='r=1, k=4'), shape=2) +
  geom_line(aes(x=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==4),]$s,
                y=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==4),]$classes,colour='r=1, k=4')) +
  geom_point(aes(x=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==6),]$s,
                 y=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==6),]$classes,colour='r=1, k=6'), shape=3) +
  geom_line(aes(x=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==6),]$s,
                y=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==6),]$classes,colour='r=1, k=6')) +
  geom_point(aes(x=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==8),]$s,
                 y=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==8),]$classes,colour='r=1, k=8'), shape=4) +
  geom_line(aes(x=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==8),]$s,
                y=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==8),]$classes,colour='r=1, k=8')) +
  geom_point(aes(x=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==10),]$s,
                 y=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==10),]$classes,colour='r=1, k=10'), shape=5) +
  geom_line(aes(x=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==10),]$s,
                y=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==10),]$classes,colour='r=1, k=10')) +
  geom_point(aes(x=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==12),]$s,
                 y=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==12),]$classes,colour='r=1, k=12'), shape=6) +
  geom_line(aes(x=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==12),]$s,
                y=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==12),]$classes,colour='r=1, k=12')) +
  geom_point(aes(x=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==14),]$s,
                 y=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==14),]$classes,colour='r=1, k=14'), shape=7) +
  geom_line(aes(x=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==14),]$s,
                y=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==14),]$classes,colour='r=1, k=14')) +
  geom_point(aes(x=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==16),]$s,
                 y=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==16),]$classes,colour='r=1, k=16'), shape=8) +
  geom_line(aes(x=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==16),]$s,
                y=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==16),]$classes,colour='r=1, k=16')) +
  geom_point(aes(x=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==18),]$s,
                 y=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==18),]$classes,colour='r=1, k=18'), shape=9) +
  geom_line(aes(x=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==18),]$s,
                y=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==18),]$classes,colour='r=1, k=18')) +
  geom_point(aes(x=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==20),]$s,
                 y=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==20),]$classes,colour='r=1, k=20'), shape=10) +
  geom_line(aes(x=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==20),]$s,
                y=ssc[,c('s', 'classes')][which(ssc$r==1 & ssc$k==20),]$classes,colour='r=1, k=20')) +
  geom_point(aes(x=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==2),]$s,
                 y=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==2),]$classes,colour='r=2, k=2'), shape=11) +
  geom_line(aes(x=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==2),]$s,
                y=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==2),]$classes,colour='r=2, k=2')) +
  geom_point(aes(x=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==4),]$s,
                 y=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==4),]$classes,colour='r=2, k=4'), shape=12) +
  geom_line(aes(x=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==4),]$s,
                y=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==4),]$classes,colour='r=2, k=4')) +
  geom_point(aes(x=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==6),]$s,
                 y=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==6),]$classes,colour='r=2, k=6'), shape=13) +
  geom_line(aes(x=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==6),]$s,
                y=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==6),]$classes,colour='r=2, k=6')) +
  geom_point(aes(x=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==8),]$s,
                 y=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==8),]$classes,colour='r=2, k=8'), shape=14) +
  geom_line(aes(x=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==8),]$s,
                y=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==8),]$classes,colour='r=2, k=8')) +
  geom_point(aes(x=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==10),]$s,
                 y=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==10),]$classes,colour='r=2, k=10'), shape=15) +
  geom_line(aes(x=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==10),]$s,
                y=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==10),]$classes,colour='r=2, k=10')) +
  geom_point(aes(x=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==12),]$s,
                 y=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==12),]$classes,colour='r=2, k=12'), shape=16) +
  geom_line(aes(x=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==12),]$s,
                y=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==12),]$classes,colour='r=2, k=12')) +
  geom_point(aes(x=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==14),]$s,
                 y=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==14),]$classes,colour='r=2, k=14'), shape=17) +
  geom_line(aes(x=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==14),]$s,
                y=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==14),]$classes,colour='r=2, k=14')) +
  geom_point(aes(x=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==16),]$s,
                 y=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==16),]$classes,colour='r=2, k=16'), shape=18) +
  geom_line(aes(x=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==16),]$s,
                y=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==16),]$classes,colour='r=2, k=16')) +
  geom_point(aes(x=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==18),]$s,
                 y=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==18),]$classes,colour='r=2, k=18'), shape=19) +
  geom_line(aes(x=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==18),]$s,
                y=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==18),]$classes,colour='r=2, k=18')) +
  geom_point(aes(x=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==20),]$s,
                 y=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==20),]$classes,colour='r=2, k=20'), shape=20) +
  geom_line(aes(x=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==20),]$s,
                y=ssc[,c('s', 'classes')][which(ssc$r==2 & ssc$k==20),]$classes,colour='r=2, k=20')) +
  geom_point(aes(x=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==2),]$s,
                 y=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==2),]$classes,colour='r=3, k=2'), shape=21) +
  geom_line(aes(x=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==2),]$s,
                y=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==2),]$classes,colour='r=3, k=2')) +
  geom_point(aes(x=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==4),]$s,
                 y=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==4),]$classes,colour='r=3, k=4'), shape=22) +
  geom_line(aes(x=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==4),]$s,
                y=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==4),]$classes,colour='r=3, k=4')) +
  geom_point(aes(x=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==6),]$s,
                 y=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==6),]$classes,colour='r=3, k=6'), shape=23) +
  geom_line(aes(x=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==6),]$s,
                y=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==6),]$classes,colour='r=3, k=6')) +
  geom_point(aes(x=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==8),]$s,
                 y=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==8),]$classes,colour='r=3, k=8'), shape=24) +
  geom_line(aes(x=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==8),]$s,
                y=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==8),]$classes,colour='r=3, k=8')) +
  geom_point(aes(x=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==10),]$s,
                 y=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==10),]$classes,colour='r=3, k=10'), shape=25) +
  geom_line(aes(x=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==10),]$s,
                y=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==10),]$classes,colour='r=3, k=10')) +
  geom_point(aes(x=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==12),]$s,
                 y=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==12),]$classes,colour='r=3, k=12'), shape=26) +
  geom_line(aes(x=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==12),]$s,
                y=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==12),]$classes,colour='r=3, k=12')) +
  geom_point(aes(x=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==14),]$s,
                 y=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==14),]$classes,colour='r=3, k=14'), shape=27) +
  geom_line(aes(x=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==14),]$s,
                y=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==14),]$classes,colour='r=3, k=14')) +
  geom_point(aes(x=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==16),]$s,
                 y=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==16),]$classes,colour='r=3, k=16'), shape=28) +
  geom_line(aes(x=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==16),]$s,
                y=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==16),]$classes,colour='r=3, k=16')) +
  geom_point(aes(x=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==18),]$s,
                 y=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==18),]$classes,colour='r=3, k=18'), shape=29) +
  geom_line(aes(x=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==18),]$s,
                y=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==18),]$classes,colour='r=3, k=18')) +
  geom_point(aes(x=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==20),]$s,
                 y=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==20),]$classes,colour='r=3, k=20'), shape=30) +
  geom_line(aes(x=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==20),]$s,
                y=ssc[,c('s', 'classes')][which(ssc$r==3 & ssc$k==20),]$classes,colour='r=3, k=20')) +
  labs(colour='Line')
print(figure_s1)

# Figure S2
unique_classes <- c()
for (s in sparam) {
  unique_freq <- as.data.frame(table(sort(ssc[,c('s', 'classes')][which(ssc$s==s),]$classes)))
  colnames(unique_freq) <- c('classes', 'freq')
  unique_freq$weight <- (as.numeric(unique_freq$freq) / as.numeric(sum(unique_freq$freq)))
  print(unique_freq)
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
print(figure_s2)

# Figure S3A
image(pseudo_list[['pseudo3']][['ssc']], model=list(r=1, k=16, s=3))

# Figure S3B
image(pseudo_list[['pseudo3']][['ssc']], model=list(r=3, k=16, s=3))

# Figure S4C
image(pseudo_list[['pseudo1']][['ssc']], model=list(r=pseudo_list[['pseudo1']][['optimal_ssc_params']]$r,
                                                    k=pseudo_list[['pseudo1']][['optimal_ssc_params']]$k,
                                                    s=pseudo_list[['pseudo1']][['optimal_ssc_params']]$s))

# Figure S5C
image(pseudo_list[['pseudo2']][['ssc']], model=list(r=pseudo_list[['pseudo2']][['optimal_ssc_params']]$r,
                                                    k=pseudo_list[['pseudo2']][['optimal_ssc_params']]$k,
                                                    s=pseudo_list[['pseudo2']][['optimal_ssc_params']]$s))

# Figure S7
image(lightdark[['ssc']], model=list(r=lightdark[['optimal_ssc_params']]$r,
                                     k=lightdark[['optimal_ssc_params']]$k,
                                     s=lightdark[['optimal_ssc_params']]$s))
