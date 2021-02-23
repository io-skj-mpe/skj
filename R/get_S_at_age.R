#'
#' Extract selectivity at age from report file
#'
#' Fleets are renamed using names provided in the data file
#' 
#' @param data SS3 \code{*.dat} file read using \code{r4ss::SS_readdat()}
#' @param report SS3 output read using \code{r4ss::SS_output()}
#' @importFrom plyr '.'
#' @export
get_S_at_age <- function(data, report) {
  
  # extract
  Sel <- subset(report$ageselex, Factor == "Asel2")[, -1]
  
  # rename fleets
  Sel <- plyr::dlply(Sel, .(Fleet), .fun = function(x) x[,-1])
  attributes(Sel) <- list(names = data$fleetnames)
  Sel <- plyr::ldply(Sel, .id = "Fleet")  
  
  # return
  return(Sel)
}