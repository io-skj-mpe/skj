#' Plot the Spawning Biomass
#'
#' @param report output from call to r4ss::SS_output()
#' @import plyr
#' @export
plot_ssb <- function(data, report, ...) {
    
  ssb <- report$timeseries[, "SpawnBio"]
  ssb <- cbind(value = ssb, Yr = report$timeseries$Yr, Seas = 1:4)
  
  ssb <- ssb[ssb[,3] == 1,]

  plot(value / 1e3 ~ Yr, ssb, type = "b", pch = 19, ylab = "Spawning Biomass (e3)", xlab = "Year", ...)
  abline(v = report$endyr, col = 4, lty = 2)
}
