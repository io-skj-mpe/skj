#'
#' Extract exploited numbers at age and sum across ages
#'
#' @param data SS3 \code{*.dat} file read using \code{r4ss::SS_readdat()}
#' @param report SS3 output read using \code{r4ss::SS_output()}
#' @importFrom plyr '.'
#' @include get_Nex_at_age.R
#' @export
get_Nex <- function(data, report) {
  
  Nages <- data$Nages
  
  # exploited numbers at age
  Nex <- get_Nex_at_age(data, report)  
  
  # split, sum and recombind
  Nex <- plyr::dlply(Nex, .(Area, Fleet, Seas, Sex, Morph, Yr), .fun = function(x) sum(x[, 7:(Nages + 7)]))
  Nex <- plyr::ldply(Nex)
  names(Nex)[ncol(Nex)] <- paste0("0:", Nages)
  
  # return
  return(Nex)
}
