#'
#' Read fleet information from data file
#' 
#' @param data SS3 \code{*.dat} file read using \code{r4ss::SS_readdat()}
#' 
#' @return A dataframe listing the type of fleet, timing, units, area and fleet name
#'
#' @export
read_fleetinfo <- function(data) {
  
  fleetinfo <- data$fleetinfo
  cpueinfo  <- data$CPUEinfo
  
  lookup <- 1:4
  names(lookup) <- c("catch", "bycatch", "index", "ignore")
  
  fleetinfo$type <- vapply(fleetinfo$type, function(x) names(lookup[match(x, lookup)]), character(1))
  
  lookup <- c(-1, 1)
  names(lookup) <- c("Annual", "Monthly")
  
  fleetinfo$surveytiming <- vapply(fleetinfo$surveytiming, function(x) names(lookup[match(x, lookup)]), character(1))
  
  lookup <- 1:2
  names(lookup) <- c("Biomass", "Numbers")
  
  fleetinfo$units[fleetinfo$type != "index"] <- vapply(fleetinfo$units[fleetinfo$type != "index"], function(x) names(lookup[match(x, lookup)]), character(1))
  
  lookup <- 0:2
  names(lookup) <- c("Numbers", "Biomass", "FMort")
  
  fleetinfo$units[fleetinfo$type == "index"] <- vapply(cpueinfo$Units[fleetinfo$type == "index"], function(x) names(lookup[match(x, lookup)]), character(1))
  
  return(fleetinfo)
}
