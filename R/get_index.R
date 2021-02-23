#'
#' Extract index
#' 
#' @param data SS3 data file read using \code{r4ss::SS_readdat()}
#' @param report SS3 output read using \code{r4ss::SS_output()}
#' @import dplyr
#' @include get_Bex.R get_Nex.R read_fleetinfo.R
#' @export
get_index <- function(data, report) {

    index_fleets <- read_fleetinfo(data) %>% filter(type == "index") %>% select(fleetname)
    index_units  <- read_fleetinfo(data) %>% filter(type == "index") %>% select(Fleet = fleetname, units)

    # get exploitable biomass
    bex <- get_Bex(data, report)
    colnames(bex)[ncol(bex)] <- "Bex"
    
    bex <- bex %>% filter(Fleet %in% index_fleets[,1])
    bex <- ddply(bex, .(Area, Fleet, Seas, Yr), summarise, Bex = sum(Bex))
    
    # get exploitable numbers
    nex <- get_Nex(data, report)
    colnames(nex)[ncol(nex)] <- "Nex"

    nex <- nex %>% filter(Fleet %in% index_fleets[,1])
    nex <- ddply(nex, .(Area, Fleet, Seas, Yr), summarise, Nex = sum(Nex))

    # create year:season
    bex <- bex %>% mutate(Yr_Seas = Yr + (Seas - 1) / 4 + 0.125) %>% as.data.frame()
    nex <- nex %>% mutate(Yr_Seas = Yr + (Seas - 1) / 4 + 0.125) %>% as.data.frame()
    
    # merge and select units
    vuln <- merge(bex, nex, by = c("Area", "Fleet", "Seas", "Yr", "Yr_Seas"))
    vuln <- merge(vuln, index_units)

    vuln$Vuln <- vuln$Nex
    vuln$Vuln[vuln$units == "Biomass"] <- vuln$Bex[vuln$units == "Biomass"]

    vuln$Fleet_label <- with(vuln, paste0(Fleet, " (", units, ")"))
    
    # get catchability and join
    Q <- report$cpue %>% summarise(Fleet = unique(Fleet_name), Q = unique(Calc_Q), .groups = "Fleet")
    
    vuln <- left_join(vuln, Q, by = "Fleet")
    
    # calculate index
    vuln$index <- with(vuln, Vuln * Q)
    
    # get observed values
    # get from model report file
    vuln_out <- report$cpue
    colnames(vuln_out)[9] <- "Vuln"

    vuln_out <- vuln_out %>% filter(Fleet_name %in% index_fleets[,1])
    vuln_out <- vuln_out %>% select(-Fleet)
    colnames(vuln_out)[1] <- "Fleet"

    # safe removal of Subseas and Month
    vuln_out <- ddply(vuln_out, .(Area, Fleet, Seas, Yr), summarise, Vuln = unique(Vuln), Obs = unique(Obs), Exp = unique(Exp))

    # create year:season
    vuln_out <- vuln_out %>% mutate(Yr_Seas = Yr + (Seas - 1) / 4 + 0.125) 

    vuln_out <- merge(vuln_out, index_units)
    vuln_out$Fleet_label <- with(vuln_out, paste0(Fleet, " (", units, ")"))
    
    # FULL JOIN
    vuln_full <- left_join(vuln, vuln_out, by = c("Fleet", "Area", "Seas", "Yr", "Yr_Seas", "units", "Fleet_label"), suffix = c("", "_out"))
    
    # check that reconstructed index is the same as the model outputted values
    # over the range of the data
    #stopifnot(with(subset(vuln_full, !is.na(Vuln_out)), all.equal(Vuln, Vuln_out, tolerance = 1e-1)))
    #stopifnot(with(subset(vuln_full, !is.na(Vuln_out)), all.equal(index, Exp, tolerance = 1e-2)))

    # tidy up
    vuln_full$Bex <- NULL
    vuln_full$Nex <- NULL
    vuln_full$Vuln_out <- NULL
    vuln_full$Exp <- NULL
    colnames(vuln_full)[match("Obs", colnames(vuln_full))] <- "index_obs"
    
    # return
    return(vuln_full)
}
