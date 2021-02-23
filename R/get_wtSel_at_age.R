#' 
#' Retrieve selectivity-at-age multiplied by body weight
#' from the SS report file
#'
#' @param data SS3 data file read using \code{r4ss::SS_readdat()}
#' @param report SS3 output read using \code{r4ss::SS_output()}
#' @importFrom plyr '.'
#' @export
get_wtSel_at_age <- function(data, report) {
    
    Nages <- data$Nages
    
    fleet_names <- data$fleetname
    
    Sel <- subset(report$ageselex, Factor == "Asel2")[, -1]
    Wt  <- subset(report$ageselex, Factor == "bodywt")[, -1]
    
    Sel <- plyr::dlply(Sel, .(Fleet, Seas, Sex, Morph), .fun = function(x) { y <- x[,c(7:(Nages + 7))]; rownames(y) <- x[,2]; y })
    Wt  <- plyr::dlply(Wt,  .(Fleet, Seas, Sex, Morph), .fun = function(x) { y <- x[,c(7:(Nages + 7))]; rownames(y) <- x[,2]; y })
    
    WtSel <- plyr::dlply(attributes(Sel)$split_labels, .(Fleet, Seas, Sex, Morph), function(z) data.frame())
    
    stopifnot(all(names(WtSel) == names(Sel)))
    
    WtSel[] <- lapply(names(WtSel), function(x) {
        
        y <- Sel[[x]] * Wt[[x]]
        y <- cbind(Yr = as.numeric(rownames(y)), y)
        return(y)
    })
    
    # rejoin
    WtSel <- plyr::ldply(WtSel)
    
    # split by fleet, rename and
    # rejoin
    WtSelbyFleet <- plyr::dlply(WtSel, .(Fleet), function(x) x[,-1])
    attributes(WtSelbyFleet) <- list(names = fleet_names)
    WtSel <- plyr::ldply(WtSelbyFleet, .id = "Fleet")
    
    # return
    return(WtSel)
}
