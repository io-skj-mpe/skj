#' Plot the fishing mortality
#'
#' @param report output from call to r4ss::SS_output()
#' @export
get_summaryF <- function(report) {

  loc <- which(regexpr("^F_....", report$derived_quants$Label) > 0)
  
  values <- report$derived_quants$Value[loc]
  
  years <- report$startyr:(report$startyr + length(loc) - 1)
  
  return(data.frame(Yr = years, value = values))
}
#' @export
plot_summaryF <- function(report) {
  
  x <- get_summaryF(report)
  
  plot(value ~ Yr, data = x, type = "b", pch = 19, ylab = "Summary Fishing Mortality", xlab = "Year")
  abline(v = report$endyr + 1, col = 4, lty = 2)
  
}
#' 
#' @export
get_Fsum <- function(data, report) {
  
  ffleets <- which(data$fleetinfo$type == 1)
  
  loc <- match(paste0("F:_", ffleets), colnames(report$timeseries))
  
  fmort <- report$timeseries[, loc]
  fmort$Yr <- report$timeseries$Yr
  fmort$Area <- report$timeseries$Area
  fmort$Seas <- 1:4
  
  fmort$FSUM <- apply(fmort[,1:length(ffleets)], 1, sum)
  
  return(plyr::ddply(fmort, "Yr", plyr::summarise, Yr = unique(Yr), value = sum(FSUM)))
}
#'
#' @export
plot_Fsum <- function(data, report, ...) {
    
    fmort_summary <- get_Fsum(data, report)

    plot(value ~ Yr, fmort_summary, type = "b", pch = 19, ylab = "Sum of Fishing Mortalities", xlab = "Year", ...)
    abline(v = report$endyr + 1, col = 4, lty = 2)
}
