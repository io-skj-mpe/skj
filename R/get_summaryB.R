#' 
#' Retrieve summary biomass from SS3 report file
#'
#' The summary biomass is the biomass-at-age summed over all ages over the minimum age specifiec in \code{starter.ss}
#'
#' @param data SS3 data file read using \code{r4ss::SS_readdat()}
#' @param report SS3 output read using \code{r4ss::SS_output()}
#' @export
get_summaryB <- function(start, report) {

    min_age <- start$min_age_summary_bio

    out <- report$batage
    out <- out[out$"Beg/Mid" == "B" & out$"Seas" == 1,]
    
    out <- split(out, f = out$Area)
    
    out <- lapply(out, function(x) data.frame("Yr" = x[,"Yr"], "value" = apply(x[,(13 + min_age):ncol(x)], 1, function(y) sum(y) / 1e3)))

    #out$Bsum <- apply(out[, (13 + min_age):ncol(out)], 1, sum)

    #out <- plyr::ddply(out[out$"Beg/Mid" == "B" & out$"Seas" == 1,], "Yr", plyr::summarise, value = sum(Bsum) / 1e3)
    
    # sum(out$value)
    # 136813.6
    
    return(out)

}

#N  <- report$natage
#Wt <- subset(report$ageselex, Factor == "bodywt")[, -1]

