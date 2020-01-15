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
# Determine Reference Peak List                                                #
################################################################################
# pseudo1, pseudo2, and pseudo3 should already be loaded from individual scripts
pseudo_list <- list('pseudo1'=pseudo1, 'pseudo2'=pseudo2, 'pseudo3'=pseudo3)

pseudo_peaks <- list()
for (i in 1:length(pseudo_list)) {
  # Normalization, Signal Smoothing, and Baseline Subtraction
  preprocessed <- preprocess_dataset(pseudo_list[[i]][['unprocessed']])
  # Peak Picking, Alignment, and Filtering
  peaks <- peak_process_dataset(preprocessed)
  pseudo_peaks[[i]] <- data.frame('peaks'=mz(peaks))
}

# Peaks that were present in at least 2 data sets (based on fuzzyjoin merging)
# within +/- 0.2 m/z were used to create the reference peak list. The mean of
# the peaks found in the replicates were averaged and added to the final peak
# list.
fuzzy_join1 <- difference_full_join(pseudo_peaks[[1]], pseudo_peaks[[2]],
                                    by='peaks', max_dist=0.2)
fuzzy_join2 <- fuzzy_join1
colnames(fuzzy_join1) <- c('peaks', 'peaks2')
colnames(fuzzy_join2) <- c('peaks1', 'peaks')
fuzzy_join1 <- difference_full_join(fuzzy_join1, pseudo_peaks[[3]],
                                    by='peaks', max_dist=0.2)
fuzzy_join2 <- difference_full_join(fuzzy_join2, pseudo_peaks[[3]],
                                    by='peaks', max_dist=0.2)
colnames(fuzzy_join1) <- c('peaks1', 'peaks2', 'peaks3')
colnames(fuzzy_join2) <- c('peaks1', 'peaks2', 'peaks3')
fuzzy_join1$mean <- rowMeans(fuzzy_join1, na.rm=TRUE)
fuzzy_join2$mean <- rowMeans(fuzzy_join2, na.rm=TRUE)
fuzzy_mean <- merge(fuzzy_join1, fuzzy_join2, by='mean')
ref_peaks <- unique(fuzzy_mean$mean)

################################################################################
# Combine Data Sets Using Reference Peak List                                  #
################################################################################
# preprocess individual data sets and peak pick with reference peak list
for (i in 1:length(pseudo_list)) {
  # Normalization, Signal Smoothing, and Baseline Subtraction
  preprocessed <- preprocess_dataset(pseudo_list[[i]][['unprocessed']])
  # Peak Picking, Alignment, and Filtering
  peaks <- peakPick(preprocessed, method='simple', SNR=4)
  peaks <- peakAlign(peaks, tolerance=0.2, units='mz', ref=ref_peaks)
  peaks <- process(peaks)
  bin <- peakBin(peaks, ref=ref_peaks, type='height', tolerance=0.2, units='mz')
  pseudo_list[[i]][['processed_reference']] <- process(bin)
}

# combine data sets
pseudo_combined <- Cardinal::combine(pseudo_list[[1]][['processed_reference']],
                                     pseudo_list[[2]][['processed_reference']],
                                     pseudo_list[[3]][['processed_reference']])

# drop any unused level ('matrix' in this case) from region column
pixelData(pseudo_combined)$region <- droplevels(pixelData(pseudo_combined)$region)


################################################################################
# Identifying Differentially Expressed Features w/ Statistical Significance    #
################################################################################
# run meansTest and show results
pseudo_combined_means <- meansTest(pseudo_combined, ~ region,
                                   groups=run(pseudo_combined))
summary(pseudo_combined_means)
topFeatures(pseudo_combined_means, n=10000)