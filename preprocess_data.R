preprocess_dataset <- function(dataset) {
  preprocessed <- normalize(dataset, method='rms')
  preprocessed <- smoothSignal(preprocessed, method='sgolay')
  preprocessed <- reduceBaseline(preprocessed, method='median')
  return(process(preprocessed))
}

peak_process_dataset <- function(dataset) {
  peaks <- peakPick(dataset, method='simple', SNR=4)
  peaks <- peakAlign(peaks, tolerance=0.2, units='mz')
  peaks <- peakFilter(peaks, freq.min=0.05)
  return(process(peaks))
}

bin_peaks <- function(dataset, ref_dataset) {
  bin <- peakBin(dataset, ref=mz(ref_dataset), type='height', tolerance=0.2, units='mz')
  return(process(bin))
}
