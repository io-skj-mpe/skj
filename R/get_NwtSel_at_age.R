#' 
#' Retrieve the selected weight at age for calculation of the
#' exploitable biomass
#'
#' @param data SS3 \code{*.dat} file read using \code{r4ss::SS_readdat()}
#' @param report SS3 output read using \code{r4ss::SS_output()}
#' @import plyr
#' @include get_N_at_age.R get_wtSel_at_age.R
#' @export
get_NwtSel_at_age <- function(data, report) {

    Nfleets <- data$Nfleets
    Nareas  <- data$N_areas
    Nages   <- data$Nages

    Ystart  <- data$styr

    # NUMBERS AT AGE
    N <- get_N_at_age(data, report)
    
    # remove years prior to start year
    N <- subset(N, Yr >= Ystart)
    
    # split by fleet
    NbyFleet <- dlply(N, .(Fleet), .fun = function(x) x[,-1])
    
    # WEIGHT * SELECTIVITY AT AGE
    WtSel <- get_wtSel_at_age(data, report)
    
    # remove years prior to start year
    WtSel <- subset(WtSel, Yr >= Ystart)
    
    # split by fleet
    WtSelbyFleet <- dlply(WtSel, .(Fleet), .fun = function(x) x[,-1])
    
    # then by other factors
    WtSelbyFactor <- lapply(WtSelbyFleet, function(x) dlply(x, .(Seas, Sex, Morph), .fun = function(y) {z <- y[, c(5:(Nages + 5))]; rownames(z) <- y[, "Yr"]; z }))
    
    NwtSel <- vector('list', Nfleets)
    NwtSel <- lapply(NwtSel, function(x) vector('list', Nareas))
    
    for (i in 1:Nfleets) {
        
        # for each fleet split N by area
        NbyArea <- dlply(NbyFleet[[i]], .(Area), .fun = function(x) x[,-1])
        
        for (j in 1:Nareas) {
            
            # for each area split N by factors 
            # common to WtSel
            NbyFactor <- dlply(NbyArea[[j]], .(Seas, Sex, Morph), .fun = function(y) { z <- y[, 12:(Nages + 12)]; rownames(z) <- y[, "Yr"]; z })
            
            # check Seas:Sex:Morph congruence
            stopifnot(all(names(NbyFactor) == names(WtSelbyFactor[[i]])))
            
            # implicit loop over Seas:Sex:Morph
            # and multiply by N by WtSel
            NwtSel[[i]][[j]] <- lapply(names(NbyFactor), function(x) { 
                
                # check that years match
                stopifnot(all(rownames(NbyFactor[[x]]) == rownames(WtSelbyFactor[[i]][[x]])))
                
                # return N * Wt * Sel
                NbyFactor[[x]] * WtSelbyFactor[[i]][[x]] 
            })
            
            # add year
            NwtSel[[i]][[j]] <- lapply(NwtSel[[i]][[j]], function(x) { x <- cbind(Yr = rownames(x), x); x })
            
            # rejoin by factor
            attributes(NwtSel[[i]][[j]]) <- attributes(WtSelbyFactor[[i]])
            NwtSel[[i]][[j]] <- ldply(NwtSel[[i]][[j]])
        }
        
        # rejoin by area
        attributes(NwtSel[[i]]) <- attributes(NbyArea)
        NwtSel[[i]] <- ldply(NwtSel[[i]])
    }
    
    # rejoin by fleet
    attributes(NwtSel) <- attributes(NbyFleet)
    NwtSel <- ldply(NwtSel)
    
    # return
    return(NwtSel)
}


