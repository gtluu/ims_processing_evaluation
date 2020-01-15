################################################################################
# Set Workspace and Load in Libraries                                          #
################################################################################
setwd("E:/vitek_sdgmm_preprint/pseudomonas/r")
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
# Load in Pseudomonas PA14 IMS Replicate and Edit Metadata in pixelData()      #
################################################################################
filename <- "E:/vitek_sdgmm_preprint/pseudomonas/imzml/PA14_TLCA_2019-05-06.imzML"
unprocessed <- readMSIData(filename)
spots <- "E:/vitek_sdgmm_preprint/pseudomonas/imzml/PA14_TLCA_2019-05-06.txt"
rois <- list(c('MeOH_Control', 'control'),
             c('TLCA_Control', 'tlca'),
             c('MeOH', 'pseudomonas'),
             c('TLCA', 'pseudomonas_tlca'),
             c('Matrix', 'matrix'))
unprocessed <- edit_metadata(unprocessed, spots, rois)
# remove matrix roi from pseudo2
unprocessed <- unprocessed[features(unprocessed),
                           pixels(unprocessed,
						          pixelData(unprocessed)$region != 'matrix')]

################################################################################
# Preprocessing, Peak Picking, and Binning                                     #
################################################################################
# Normalization, Signal Smoothing, and Baseline Subtraction
preprocessed <- preprocess_dataset(unprocessed)
# Peak Picking, Alignment, and Filtering
peaks <- peak_process_dataset(preprocessed)
processed <- bin_peaks(preprocessed, peaks)

################################################################################
# Multivariate Segmentation Using Spatial Shrunken Centroid Algorithm          #
################################################################################
set.seed(1120)

rparam <- c(1,2,3)
kparam <- c(2,4,6,8,10,12,14,16,18,20)
sparam <- c(0,3,6,9,12,15)

ssc <- spatialShrunkenCentroids(processed, r=rparam, k=kparam, s=sparam)
ssc_params <- optimize_ssc_params(ssc, sparam)
ssc_image <- image(ssc, model=list(r=ssc_params$r, k=ssc_params$k,
								   s=ssc_params$s))
t_stat_plot <- plot(ssc, values="statistic", model=list(r=ssc_params$r,
                                                        k=ssc_params$k,
														s=ssc_params$s))

################################################################################
# Store All Objects in a List                                                  #
################################################################################
pseudo2 <- list('unprocessed'=unprocessed, 'processed'=processed, 'ssc'=ssc,
			    'optimal_ssc_params'=ssc_params)
