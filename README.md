# Evaluation of data analysis platforms and compatibility with MALDI-TOF imaging mass spectrometry datasets

This repository was made to hold data for our [publication of the same title](https://pubs.acs.org/doi/10.1021/jasms.0c00039).

R code for processing done using Cardinal on <i>Pseudomonas aeruginosa</i> PA14 imaging mass spectrometry data sets. Cardinal 2.4.0.9000, a forked branch of [Cardinal MSI](https://github.com/kuwisdelu/Cardinal) with several pending bug fixes, can be found [here](https://github.com/gtluu/Cardinal/tree/v2.4.0.9000). Discussion with the developer regarding the bug fixes in Cardinal 2.4.0.9000 is currently ongoing and will be updated on this page. Custom in-house functions used during analysis can be found in the [cardinalscripts](https://github.com/gtluu/cardinalscripts) repository.

### analysis
R scripts for any statistical analysis done on individual or combined data sets.

### figures
R scripts used to generate ion/segmentation images for publication. Further editing done in Inkscape.

### data
Spot Lists from Bruker FlexImaging v4.1 and ROI CSV tables used for analysis.

## Cardinal 2.4.9000 Changes

    o Fix bug in 'spatialFastmap()' when iterating over
		FastMap components where
		'iData(x)[,spatial$neighbors[[oa]]]' and
		'iData(x)[,spatial$neighbors[[ob]]]' are stored
		as a numeric vector instead of a matrix
    o Fix bug in 'spatialShrunkenCentroids()' where
		'if ( all(class==pred$class) )' causes error
		due to NA values in 'class' or 'pred$class'
