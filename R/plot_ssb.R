#' Retreive and plot the Spawning Biomass
#'
#' @param data output from call to r4ss::SS_readdat()
#' @param report output from call to r4ss::SS_output()
#' @export
get_ssb <- function(data, report) {

  ssb <- report$timeseries[, "SpawnBio"]
  ssb <- cbind(value = ssb / 1e3, Yr = report$timeseries$Yr, Area = report$timeseries$Area, Seas = 1:4)
  ssb <- ssb[ssb[,4] == 1,]
  
  ssb <- data.frame(value = tapply(ssb[,"value"], ssb[,"Yr"], sum))
  ssb <- data.frame(Yr = as.integer(rownames(ssb)), ssb)
  
  return(ssb)
}
#' @export
plot_ssb <- function(data, report, ...) {
  
  ssb <- get_ssb(data, report)

  plot(value ~ Yr, ssb, type = "b", pch = 19, ylab = "Spawning Biomass (e3)", xlab = "Year", ...)
  abline(v = report$endyr + 1, col = 4, lty = 2)
}
