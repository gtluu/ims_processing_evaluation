################################################################################
# Set Workspace and Load in Libraries                                          #
################################################################################
setwd("E:/vitek_sdgmm_preprint/lightdark_cycling/r")
library(Cardinal)
library(stringr)
library(fuzzyjoin)
library(dplyr)
library(ggplot2)
library(reticulate)
kneed <- import('kneed')
numpy <- import('numpy')

################################################################################
# Initialize MultiProcessing for Windows                                       #
################################################################################
register(SnowParam(workers=(detectCores()-1), progressbar=TRUE))

################################################################################
# Load in 3 Pseudomonas PA14 IMS Replicates Edit Metadata in pixelData()       #
################################################################################
filename <- "E:/vitek_sdgmm_preprint/lightdark_cycling/imzml/LD-Cycling_2018-08-08.imzML"
unprocessed <- readMSIData(filename)
spots <- "E:/vitek_sdgmm_preprint/lightdark_cycling/imzml/LD-Cycling_2018-08-08.txt"
rois <- list(c('A', 'light'),
             c('B', 'dark'),
             c('C', 'cycling'),
             c('A_Control', 'light_ctrl'),
             c('B_Control', 'dark_ctrl'),
             c('C_Control', 'cycling_ctrl'))
unprocessed <- edit_metadata(unprocessed, spots, rois)

################################################################################
# Preprocessing, Peak Picking, and Binning                                     #
################################################################################
# Normalization, Signal Smoothing, and Baseline Subtraction
preprocessed <- normalize(unprocessed, method='tic')
preprocessed <- smoothSignal(preprocessed, method='sgolay')
preprocessed <- reduceBaseline(preprocessed, method='median')
preprocessed <- process(preprocessed)
# Peak Picking, Alignment, and Filtering
peaks <- peakPick(preprocessed, method='simple', SNR=4)
peaks <- peakAlign(peaks, tolerance=0.2, units='mz')
peaks <- peakFilter(peaks, freq.min=0.05)
peaks <- process(peaks)
processed <- peaks

################################################################################
# Multivariate Segmentation Using Spatial Shrunken Centroid Algorithm          #
################################################################################
set.seed(1120)

rparam <- c(1,2,3)
rparam <- c(1)
rparam <- c(2)
kparam <- c(2,4,6,8,10,12,14,16,18,20)
sparam <- c(0,3,6,9,12,15)

ssc <- spatialShrunkenCentroids(processed, r=rparam, k=kparam, s=sparam)
ssc2 <- spatialShrunkenCentroids(processed, r=rparam, k=kparam, s=sparam)
ssc_params <- optimize_ssc_params(ssc, sparam)
ssc_image <- image(ssc, model=list(r=ssc_params$r,
                                   k=ssc_params$k,
                                   s=ssc_params$s))
t_stat_plot <- plot(ssc, values='statistic',
									  model=list(r=ssc_params$r,
								    k=ssc_params$k,
									  s=ssc_params$s))
