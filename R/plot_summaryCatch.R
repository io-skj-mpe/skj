#' Plot the catches
#'
#' @param report output from call to r4ss::SS_output()
#' @importFrom dplyr '%>%'
#' @export
get_catchSum <- function(data, report, fleet = NULL) {
  
  catch_fleets <- read_fleetinfo(data) %>% dplyr::filter(type == "catch") %>% dplyr::select(fleetname)
  catch_fleets <- catch_fleets[,1]
  
  ffleets <- which(data$fleetinfo$type == 1)
  
  loc <- match(paste0("dead(B):_", ffleets), colnames(report$timeseries))
  
  catch <- report$timeseries[, loc]
  catch$Area <- report$timeseries$Area
  catch$Yr   <- report$timeseries$Yr
  catch$Seas <- 1:4
  
  catch$CATCHSUM <- apply(catch[,1:length(ffleets)], 1, sum)
  
  if (!is.null(fleet)) {
    if (fleet %in% catch_fleets) {
        loc <- match(fleet, catch_fleets)
        catch$CATCHSUM <- catch[, loc]
    } else {
        stop("Fleet not present")
    }
  } 
  
  dfr <- plyr::ddply(catch, c("Area", "Yr"), plyr::summarise, value = sum(CATCHSUM) / 1e3)
  
  return(dfr)
}
#'
#' @export
plot_catchSum <- function(data, report, ...) {
    
    dfr <- get_catchSum(data, report)
    dfr <- plyr::ddply(dfr, "Yr", plyr::summarise, value = sum(value))
    
    plot(value ~ Yr, dfr, type = "b", pch = 19, ylab = "Sum of Catches (e3)", xlab = "Year", ...)
    abline(v = report$endyr + 1, col = 4, lty = 2)
}
