edit_metadata <- function(dataset, spot_file, roi_list) {
  spots <- as.data.frame(read.table(spot_file, sep=" ", col.names=c("x", "y", "spot", "region")))
  spots$x <- as.integer(str_split(str_split(spots$spot, "X", simplify=TRUE)[,2], "Y", simplify=TRUE)[,1])
  spots$y <- as.integer(str_split(spots$spot, "Y", simplify=TRUE)[,2])
  spots$region <- as.character(spots$region)
  for (roi in roi_list) {
    spots$region[spots$region == roi[1]] <- roi[2]
  }
  pd_df <- as.data.frame(pixelData(dataset))
  pd_df <- difference_inner_join(pd_df, spots, by=c('x','y'), max_dist=0)
  pixelData(dataset)$region <- as.factor(pd_df$region)
  run(dataset) <- as.factor(paste(run(dataset), pixelData(dataset)$region, sep='_'))
  return(dataset)
}
