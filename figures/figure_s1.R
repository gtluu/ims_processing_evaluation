library(Cardinal)
library(ggplot2)

ssc <- as.data.frame(summary(pseudo2[['ssc']]))
colnames(ssc) <- c('r', 'k', 's', 'classes', 'features_per_class')

figureS1 <- ggplot() +
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

svg("figures1.svg", width=10.67, height=6)
print(figureS1)
dev.off()
