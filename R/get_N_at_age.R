#'
#' Extract numbers at age from report file
#'
#' Numbers-at-age are partitioned by fleet, with the timing (Beg vs Mid) accounted for. 
#' Fleets are renamed using names provided in the data file.
#' 
#' @param data SS3 \code{*.dat} file read using \code{r4ss::SS_readdat()}
#' @param report SS3 output read using \code{r4ss::SS_output()}
#' @import plyr
#' @export
get_N_at_age <- function(data, report) {
  
  fleet_names <- data$fleetname
  
  surveytiming <- data$surveytiming
  
  # NUMBERS AT AGE
  N <- report$natage
  
  # split by fleet according to timing
  NbyFleet <- lapply(surveytiming, function(timing) { 
    if(timing < 0) z <- N[N[, "Beg/Mid"] == "B",] else z <- N[N[, "Beg/Mid"] == "M",]; z })
  
  attributes(NbyFleet) <- list(names = fleet_names)
  
  # rejoin
  N <- ldply(NbyFleet, .id = "Fleet")
  
  # return
  return(N)
}
