#'
#' Extract exploitable biomass
#' 
#' @param data SS3 \code{*.dat} file read using \code{r4ss::SS_readdat()}
#' @param report SS3 output read using \code{r4ss::SS_output()}
#' @importFrom plyr '.'
#' @include get_NwtSel_at_age.R
#' @export
get_Bex <- function(data, report) {
  
  Nages <- data$Nages
  
  # exploited numbers at age
  Bex <- get_NwtSel_at_age(data, report)  
  
  # split, sum and recombind
  Bex <- plyr::dlply(Bex, .(Area, Fleet, Seas, Sex, Morph, Yr), .fun = function(x) sum(x[, 7:(Nages + 7)]))
  Bex <- plyr::ldply(Bex)
  names(Bex)[ncol(Bex)] <- paste0("0:", Nages)
  
  # coerce
  Bex$Fleet <- as.character(Bex$Fleet)
  Bex$Yr    <- as.numeric(as.character(Bex$Yr))
  
  # return
  return(Bex)
}
