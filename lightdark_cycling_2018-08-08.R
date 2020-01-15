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
# Initialize Lists for Pseudomonas Data                                        #
################################################################################
lightdark <- list()

################################################################################
# Load in 3 Pseudomonas PA14 IMS Replicates Edit Metadata in pixelData()       #
################################################################################
lightdark_unproc <- readMSIData("E:/vitek_sdgmm_preprint/lightdark_cycling/imzml/LD-Cycling_2018-08-08.imzML")
lightdark_spots <- "E:/vitek_sdgmm_preprint/lightdark_cycling/imzml/LD-Cycling_2018-08-08.txt"
lightdark_rois <- list(c('A', 'light'),
                       c('B', 'dark'),
                       c('C', 'cycling'),
                       c('A_Control', 'light_ctrl'),
                       c('B_Control', 'dark_ctrl'),
                       c('C_Control', 'cycling_ctrl'))

lightdark[['unprocessed']] <- lightdark_unproc

################################################################################
# Preprocessing, Peak Picking, and Binning                                     #
################################################################################
# Normalization, Signal Smoothing, and Baseline Subtraction
preprocessed <- normalize(lightdark[['unprocessed']], method='tic')
preprocessed <- smoothSignal(preprocessed, method='sgolay')
preprocessed <- reduceBaseline(preprocessed, method='median')
preprocessed <- process(preprocessed)
# Peak Picking, Alignment, and Filtering
peaks <- peakPick(preprocessed, method='simple', SNR=4)
peaks <- peakAlign(peaks, tolerance=0.2, units='mz')
peaks <- peakFilter(peaks, freq.min=0.05)
peaks <- process(peaks)
# Bin Peaks
bin <- peakBin(preprocessed, ref=mz(peaks), type='height', tolerance=0.2, units='mz')
lightdark[['processed']] <- process(bin)

rm(preprocessed, peaks, bin)

################################################################################
# Multivariate Segmentation Using Spatial Shrunken Centroid Algorithm          #
################################################################################
set.seed(1120)

rparam <- c(1,2,3)
kparam <- c(2,4,6,8,10,12,14,16,18,20)
sparam <- c(0,3,6,9,12,15)

lightdark[['ssc']] <- spatialShrunkenCentroids(lightdark[['processed']], r=rparam, k=kparam, s=sparam)
lightdark[['optimal_ssc_params']] <- optimize_ssc_params(lightdark[['ssc']], sparam)

lightdark[['ssc_image']] <- image(lightdark[['ssc']], model=list(r=lightdark[['optimal_ssc_params']]$r,
                                                                 k=lightdark[['optimal_ssc_params']]$k,
                                                                 s=lightdark[['optimal_ssc_params']]$s))
lightdark[['ssc_t_stat_plot']] <- plot(lightdark[['ssc']], values='statistic',
									   model=list(r=lightdark[['optimal_ssc_params']]$r,
												  k=lightdark[['optimal_ssc_params']]$k,
												  s=lightdark[['optimal_ssc_params']]$s))
