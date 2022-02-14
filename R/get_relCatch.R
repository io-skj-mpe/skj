#'
#' Get relative catch
#' 
#' Extract distribution of catches across fleets and seasons 
#'
#' @param data SS3 data file read using \code{r4ss::SS_readdat()}
#' @param report SS3 output read using \code{r4ss::SS_output()}
#'
#' @export
get_relCatch <- function(data, report) {
  
  ffleets <- which(data$fleetinfo$type == 1)
  nfleets <- length(ffleets)
  narea   <- data$N_areas
  
  loc <- match(paste0("dead(B):_", ffleets), colnames(report$timeseries))
  
  Yr <- report$endyr + report$N_forecast_yrs
  
  catch_area <- report$timeseries[report$timeseries$Yr == Yr, "Area"]
  catch_out  <- report$timeseries[report$timeseries$Yr == Yr, loc]
  
  catch_out  <- split(catch_out, catch_area)
  catch_out  <- array(as.numeric(unlist(catch_out)), dim = c(4, nfleets, narea))
  
  catch_out <- catch_out / report$derived_quants$Value[report$derived_quants$Label == paste0("ForeCatch_", Yr)]
  
  dimnames(catch_out) <- list(Seas = 1:4, Fleet = ffleets, Area = 1:narea)
  
  # distribution across fleets and seasons
  return(catch_out)
}

