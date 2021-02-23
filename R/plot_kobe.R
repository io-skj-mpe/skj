#' Plot Kobe
#'
#' @param report output from call to r4ss::SS_output()
#' @export
plot_kobe <- function(report, ...) {
  
  status <- report$Kobe
  
  plot(F.Fmsy ~ B.Bmsy, status, type = "b", pch = 19, ylab = "F / Fmsy", xlab = "Biomass / Bmsy", xlim = c(0, max(status[, "B.Bmsy"])), col = 4, ...)
  
  status <- report$Kobe[report$Kobe$Yr >= report$endyr, ]
  
  points(F.Fmsy ~ B.Bmsy, status, type = "b", col = 2)
  
  status <- report$Kobe[report$Kobe$Yr >= report$endyr + 1, ]
  
  points(F.Fmsy ~ B.Bmsy, status, type = "b", pch = 19, col = 2)
  
  abline(v = 1, h = 1, lty = 2)
}



