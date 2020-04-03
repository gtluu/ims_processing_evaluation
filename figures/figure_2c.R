library(Cardinal)

# Figure 2C
twentyeighteen <- Cardinal::combine(processedPseudoCombined[which(run(processedPseudoCombined)=='PA14_TLCA_2018-01-12_MeOH')],
                                    processedPseudoCombined[which(run(processedPseudoCombined)=='PA14_TLCA_2018-01-12_TLCA')],
                                    processedPseudoCombined[which(run(processedPseudoCombined)=='PA14_TLCA_2018-01-12_PA14_MeOH')],
                                    processedPseudoCombined[which(run(processedPseudoCombined)=='PA14_TLCA_2018-01-12_PA14_TLCA_')])
run(twentyeighteen) <- as.factor('2018')

image(twentyeighteen, mz=211.2773989, plusminus=0.2, normalize.image='linear', contrast.enhance='histogram')
image(twentyeighteen, mz=269.178925, plusminus=0.2, normalize.image='linear', contrast.enhance='histogram')
image(twentyeighteen, mz=609.2278087, plusminus=0.2, normalize.image='linear', contrast.enhance='histogram')
