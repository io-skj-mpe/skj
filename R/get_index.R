#'
#' Extract index
#' 
#' @param data SS3 data file read using \code{r4ss::SS_readdat()}
#' @param report SS3 output read using \code{r4ss::SS_output()}
#' @importFrom plyr '.'
#' @importFrom dplyr '%>%' 
#' @importFrom dplyr filter
#' @importFrom dplyr select
#' @importFrom dplyr left_join
#' @importFrom reshape2 melt
#' @include get_Bex.R get_Nex.R read_fleetinfo.R
#' @export
get_index <- function(data, report) {

    index_fleets <- read_fleetinfo(data) %>% dplyr::filter(type == "index") %>% dplyr::select(fleetname)
    index_units  <- read_fleetinfo(data) %>% dplyr::filter(type == "index") %>% dplyr::select(Fleet = fleetname, units)

    # get exploitable biomass
    bex <- get_Bex(data, report)
    colnames(bex)[ncol(bex)] <- "Bex"
    
    bex <- bex %>% dplyr::filter(Fleet %in% index_fleets[,1])
    bex <- plyr::ddply(bex, .(Area, Fleet, Seas, Yr), plyr::summarise, Bex = sum(Bex))
    
    # get exploitable numbers
    nex <- get_Nex(data, report)
    colnames(nex)[ncol(nex)] <- "Nex"

    nex <- nex %>% dplyr::filter(Fleet %in% index_fleets[,1])
    nex <- plyr::ddply(nex, .(Area, Fleet, Seas, Yr), plyr::summarise, Nex = sum(Nex))

    # create year:season
    bex <- bex %>% dplyr::mutate(Yr_Seas = Yr + (Seas - 1) / 4 + 0.125) %>% as.data.frame()
    nex <- nex %>% dplyr::mutate(Yr_Seas = Yr + (Seas - 1) / 4 + 0.125) %>% as.data.frame()
    
    # merge and select units
    vuln <- merge(bex, nex, by = c("Area", "Fleet", "Seas", "Yr", "Yr_Seas"))
    vuln <- merge(vuln, index_units)

    vuln$Vuln <- vuln$Nex
    vuln$Vuln[vuln$units == "Biomass"] <- vuln$Bex[vuln$units == "Biomass"]

    vuln$Fleet_label <- with(vuln, paste0(Fleet, " (", units, ")"))
    
    # get catchability and join
    Q <- report$cpue %>% dplyr::summarise(Fleet = unique(Fleet_name), Q = unique(Calc_Q), .groups = "Fleet")
    
    vuln <- dplyr::left_join(vuln, Q, by = "Fleet")
    
    # get fleet area combinations
    retain_fleet_area <- reshape2::melt(table(report$cpue$Area, report$cpue$Fleet_name) > 0, varnames = c("Area", "Fleet")) %>% filter(value) %>% select(-value)
    
    # calculate index
    vuln$index <- with(vuln, Vuln * Q)
    
    # get observed values
    # get from model report file
    vuln_out <- report$cpue
    colnames(vuln_out)[9] <- "Vuln"

    vuln_out <- vuln_out %>% dplyr::filter(Fleet_name %in% index_fleets[,1])
    vuln_out <- vuln_out %>% dplyr::select(-Fleet)
    colnames(vuln_out)[1] <- "Fleet"

    # safe removal of Subseas and Month
    vuln_out <- plyr::ddply(vuln_out, .(Area, Fleet, Seas, Yr), plyr::summarise, Vuln = unique(Vuln), Obs = unique(Obs), Exp = unique(Exp))

    # create year:season
    vuln_out <- vuln_out %>% dplyr::mutate(Yr_Seas = Yr + (Seas - 1) / 4 + 0.125) 

    vuln_out <- merge(vuln_out, index_units)
    vuln_out$Fleet_label <- with(vuln_out, paste0(Fleet, " (", units, ")"))
    
    # FULL JOIN
    vuln_full <- dplyr::left_join(vuln, vuln_out, by = c("Fleet", "Area", "Seas", "Yr", "Yr_Seas", "units", "Fleet_label"), suffix = c("", "_out"))
    
    # SUBSET TO FLEET-AREA COMBINATION IN DATA
    vuln_full <- left_join(retain_fleet_area, vuln_full)
    
    # check that reconstructed index is the same as the model outputted values
    # over the range of the data
    #stopifnot(with(subset(vuln_full, !is.na(Vuln_out)), all.equal(Vuln, Vuln_out, tolerance = 1e-1)))
    #stopifnot(with(subset(vuln_full, !is.na(Vuln_out)), all.equal(index, Exp, tolerance = 1e-2)))

    # tidy up
    vuln_full$Bex <- NULL
    vuln_full$Nex <- NULL
    vuln_full$Vuln_out <- NULL
    colnames(vuln_full)[match("Exp", colnames(vuln_full))] <- "index_mle"
    colnames(vuln_full)[match("Obs", colnames(vuln_full))] <- "index_obs"
    
    # return
    return(vuln_full)
}
