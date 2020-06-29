#'
#' Retrieve exploited numbers at age
#' 
#' Extracts predicted numbers at age and multiplies through
#' by the selectivity per fleet
#' 
#' @param data SS3 \code{*.dat} file read using \code{r4ss::SS_readdat()}
#' @param report SS3 output read using \code{r4ss::SS_output()}
#' @import plyr
#' @include get_N_at_age.R get_S_at_age.R
#' @export
get_Nex_at_age <- function(data, report) {
  
  fleet_names <- data$fleetname
  
  Nages  <- data$Nages
  Nareas <- data$N_areas
  
  Ystart <- data$styr

  # NUMBERS AT AGE BY FLEET
  N <- get_N_at_age(data, report)
  
  # remove years prior to start year
  N <- subset(N, Yr >= Ystart)
  
  # split by Area
  NbyArea <- dlply(N, .(Area), .fun = function(x) x[,-2])
  
  # SELECTIVITY
  S <- get_S_at_age(data, report)
  
  # remove years prior to start year
  S <- subset(S, Yr >= Ystart)
  
  # split by factors common to N
  SbyFactor <- dlply(S, .(Fleet, Seas, Sex, Morph), .fun = function(x) { y <- x[,c(7:(Nages + 7))]; rownames(y) <- x[, "Yr"]; y })
  
  # for each area
  N <- vector('list', length = Nareas)
  attributes(N) <- attributes(NbyArea)
  
  for (i in 1:Nareas) {
    
    # split Numbers
    NbyFactor <- dlply(NbyArea[[i]], .(Fleet, Seas, Sex, Morph), .fun = function(x) { y <- x[,c(13:(Nages + 13))]; rownames(y) <- x[, "Yr"]; y })
    
    # implicit loop over factors
    StimesN <- dlply(attributes(SbyFactor)$split_labels, .(Fleet, Seas, Sex, Morph), function(z) data.frame())
    
    stopifnot(all(names(StimesN) == names(NbyFactor)))
    
    StimesN[] <- lapply(names(StimesN), function(x) {
      
      y <- NbyFactor[[x]] * SbyFactor[[x]]
      y <- cbind(Yr = as.numeric(rownames(y)), y)
      return(y)
    })
    N[[i]] <- ldply(StimesN)
  }
  
  # rejoin
  N <- ldply(N, .id = "Area")
  
  # return
  return(N)
}




