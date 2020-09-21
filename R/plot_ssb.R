#' Retreive and plot the Spawning Biomass
#'
#' @param data output from call to r4ss::SS_readdat()
#' @param report output from call to r4ss::SS_output()
#' @import plyr
#' @export
get_ssb <- function(data, report) {

  ssb <- report$timeseries[, "SpawnBio"]
  ssb <- cbind(value = ssb, Yr = report$timeseries$Yr, Seas = 1:4)
  
  ssb <- as.data.frame(ssb[ssb[,3] == 1, 2:1])
  
  return(ssb)
}
#' @export
plot_ssb <- function(data, report, ...) {
  
  ssb <- get_ssb(data, report)

  plot(value / 1e3 ~ Yr, ssb, type = "b", pch = 19, ylab = "Spawning Biomass (e3)", xlab = "Year", ...)
  abline(v = report$endyr, col = 4, lty = 2)
}
