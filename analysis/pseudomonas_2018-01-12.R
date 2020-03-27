################################################################################
# Set Workspace and Load in Libraries                                          #
################################################################################
library(devtools)
load_all('cardinal')
load_all('cardinalscripts')
library(stringr)
library(fuzzyjoin)
library(dplyr)
library(ggplot2)
library(reticulate)
kneed <- import('kneed')
numpy <- import('numpy')

################################################################################
# Load in Pseudomonas PA14 IMS Replicate and Edit Metadata in pixelData()      #
################################################################################
unprocessed <- as(readMSIData("PA14_TLCA_2018-01-12.imzML",
                              resolution=200, units='ppm'),
                  'MSContinuousImagingExperiment')

################################################################################
# Preprocessing, Peak Picking, and Binning                                     #
################################################################################
# Normalization, Signal Smoothing, and Baseline Subtraction
preprocessed <- normalize(unprocessed, method='rms')
preprocessed <- smoothSignal(preprocessed, method='sgolay')
preprocessed <- reduceBaseline(preprocessed, method='median')
preprocessed <- process(preprocessed)
# Peak Picking, Alignment, and Filtering
peaks <- peakPick(preprocessed, method='simple', SNR=4)
peaks <- peakAlign(peaks, tolerance=0.2, units='mz')
peaks <- peakFilter(peaks, freq.min=0.05)
processed <- process(peaks)

################################################################################
# Multivariate Segmentation Using Spatial Shrunken Centroid Algorithm          #
################################################################################
set.seed(1120)

rparam <- c(1,2,3)
kparam <- c(2,4,6,8,10,12,14,16,18,20)
sparam <- c(0,3,6,9,12,15)

ssc <- spatialShrunkenCentroids(processed, r=rparam, k=kparam, s=sparam)

sscParams <- optimizeSSCParams(ssc, sparam, rparam, kparam)

################################################################################
# Store All Objects in a List                                                  #
################################################################################
pseudo2 <- list('processed'=processed, 'ssc'=ssc, 'sscParams'=sscParams)

save.image("pseudomonas_2018-01-12.RData")
