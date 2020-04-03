################################################################################
# Set Workspace and Load in Libraries                                          #
################################################################################
library(Cardinal)
library(devtools)
load_all('cardinalscripts')
library(stringr)
library(fuzzyjoin)
library(dplyr)
library(ggplot2)

################################################################################
# Initialize MultiProcessing for Windows                                       #
################################################################################
register(SnowParam(workers=4, log=TRUE, logdir=getwd()))

################################################################################
# Load in Datasets, Spot Lists, and ROI Lists                                  #
################################################################################
pseudo1 <- as(readMSIData("PA14_TLCA_2 DAYS_2016-06-09.imzML", resolution=200,
                          units="ppm", mass.range=c(200, 3500)),
              "MSContinuousImagingExperiment")
pseudo2 <- as(readMSIData("PA14_TLCA_2018-01-12.imzML", resolution=200,
                          units="ppm", mass.range=c(200, 3500)),
              "MSContinuousImagingExperiment")
pseudo3 <- as(readMSIData("PA14_TLCA_2019-05-06.imzML", resolution=200,
                          units="ppm", mass.range=c(200, 3500)),
              "MSContinuousImagingExperiment")
pseudo4 <- as(readMSIData("PA14_TLCA_2017-09-21.imzML", resolution=200,
                          units="ppm", mass.range=c(200, 3500)),
              "MSContinuousImagingExperiment")

spots1 <- 'PA14_TLCA_2 DAYS_2016-06-09.txt'
spots2 <- 'PA14_TLCA_2018-01-12.txt'
spots3 <- 'PA14_TLCA_2019-05-06.txt'
spots4 <- 'PA14_TLCA_2017-09-21.txt'

rois1 <- 'PA14_TLCA_2 DAYS_2016-06-09.csv'
rois2 <- 'PA14_TLCA_2018-01-12.csv'
rois3 <- 'PA14_TLCA_2019-05-06.csv'
rois4 <- 'PA14_TLCA_2017-09-21.csv'

################################################################################
# Update Metadata                                                              #
################################################################################
pseudo1 <- updateMetadata(pseudo1, spotFile=spots1, roiFile=rois1)
pseudo2 <- updateMetadata(pseudo2, spotFile=spots2, roiFile=rois2)
pseudo3 <- updateMetadata(pseudo3, spotFile=spots3, roiFile=rois3)
pseudo4 <- updateMetadata(pseudo4, spotFile=spots4, roiFile=rois4)

centroided(pseudo1) <- FALSE
centroided(pseudo2) <- FALSE
centroided(pseudo3) <- FALSE
centroided(pseudo4) <- FALSE

################################################################################
# Combine Datasets                                                             #
################################################################################
pseudoCombined <- Cardinal::combine(pseudo1, pseudo2, pseudo3, pseudo4)

################################################################################
# Preprocessing and Peak Picking                                               #
################################################################################
# Normalization, Signal Smoothing, and Baseline Subtraction
preprocessed <- normalize(pseudoCombined, method='rms')
preprocessed <- smoothSignal(preprocessed, method='sgolay')
preprocessed <- reduceBaseline(preprocessed, method='median')
preprocessed <- process(preprocessed)
# Peak Picking, Alignment, and Filtering
peaks <- peakPick(preprocessed, method='simple', SNR=4)
peaks <- peakAlign(peaks, tolerance=NA, units='mz')
peaks <- peakFilter(peaks, freq.min=0.05)
processedPseudoCombined <- process(peaks)

################################################################################
# Means Test to Find Significant Features                                      #
################################################################################
treatedMeans <- meansTest(processedPseudoCombined, ~ treated, groups=run(processedPseudoCombined))
untreatedMeans <- meansTest(processedPseudoCombined, ~ untreated, groups=run(processedPseudoCombined))

treatedMeansDf <- as.data.frame(topFeatures(treatedMeans, n=length(mz(processedPseudoCombined))))
untreatedMeansDf <- as.data.frame(topFeatures(untreatedMeans, n=length(mz(processedPseudoCombined))))

################################################################################
# Spatial DGMM Segmentation                                                    #
################################################################################
register(SerialParam(log=TRUE, logdir=getwd()))
set.seed(233)
pseudoSdgmmList <- spatialDGMMWrapper(processedPseudoCombined, r=1, k=4)

################################################################################
# Segmentation Test to Find Significant Features                               #
################################################################################
treatedSegTestDf <- segmentationTestWrapper(pseudoSdgmmList, fixedCondition='treated', classControl='Ymax')
untreatedSegTestDf <- segmentationTestWrapper(pseudoSdgmmList, fixedCondition='untreated', classControl='Ymax')
