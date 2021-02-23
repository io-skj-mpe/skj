
#' 
#' Retrieve summary harvest rate from SS3 report file
#'
#' Returns catch over the summary biomass (the biomass-at-age summed over all ages over the minimum age specifiec in \code{starter.ss}).
#'
#' @param data SS3 \code{*.dat} file read using \code{r4ss::SS_readdat()}
#' @param report SS3 output read using \code{r4ss::SS_output()}
#' @export
get_summaryH <- function(start, data, report) {

    dfr_B <- get_summaryB(start, report)
    dfr_C <- get_catchSum(data, report)

    dfr <- merge(dfr_C, dfr_B, by = "Yr", suffixes = c(".catch", ".smryB"))
    
    dfr$value <- dfr$value.catch / dfr$value.smryB

    dfr$value.catch <- NULL
    dfr$value.smryB <- NULL
    
    return(dfr)
}
#'
#' @export
plot_summaryH <- function(start, data, report, ...) {

    dfr <- get_summaryH(start, data, report)
    
    plot(value ~ Yr, dfr, type = "b", pch = 19, ylab = "Harvest Rate", xlab = "Year", ...)
    abline(v = report$endyr + 1, col = 4, lty = 2)
}

