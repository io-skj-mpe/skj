#' Plot the catches
#'
#' @param report output from call to r4ss::SS_output()
#' @import plyr
#' @export
get_catchSum <- function(data, report) {
  
  ffleets <- which(data$fleetinfo$type == 1)
  
  loc <- match(paste0("retain(B):_", ffleets), colnames(report$timeseries))
  
  catch <- report$timeseries[, loc]
  catch$Yr <- report$timeseries$Yr
  catch$Seas <- 1:4
  
  catch$CATCHSUM <- apply(catch[,1:length(ffleets)], 1, sum)
  
  return(ddply(catch, .(Yr), summarise, Yr = unique(Yr), catch = sum(CATCHSUM) / 1e3))
}
#'
#' @export
plot_catchSum <- function(data, report, ...) {
    
    catch_summary <- get_catchSum(data, report)

    plot(catch ~ Yr, catch_summary, type = "b", pch = 19, ylab = "Sum of Catches (e3)", xlab = "Year", ...)
    abline(v = report$endyr + 1, col = 4, lty = 2)
}
