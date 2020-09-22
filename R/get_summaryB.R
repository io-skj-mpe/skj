
#' 
#' Retrieve summary biomass from SS3 report file
#'
#' The summary biomass is the biomass-at-age summed over all ages over the minimum age specifiec in \code{starter.ss}
#'
#' @param data SS3 \code{*.dat} file read using \code{r4ss::SS_readdat()}
#' @param report SS3 output read using \code{r4ss::SS_output()}
#' 
#' @import plyr
#' @export
get_summaryB <- function(start, report) {

    min_age <- start$min_age_summary_bio

    out <- report$batage

    out$Bsum <- apply(out[, (13 + min_age):ncol(out)], 1, sum)

    out <- ddply(out[out$"Beg/Mid" == "B" & out$"Seas" == 1,], "Yr", summarise, value = sum(Bsum) / 1e3)
    
    return(out)

}

#N  <- report$natage
#Wt <- subset(report$ageselex, Factor == "bodywt")[, -1]

