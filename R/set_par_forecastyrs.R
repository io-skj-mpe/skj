#' @title Set number of parameters in par file to match forecast years
#'
#' @description The number of recruitment and implementation deviations in \code{ss.par} are checked to match the number of projection years in \code{forecast.ss}.
#' @param path file path to run directory
#' @param check logical indicating whether to check in \code{starter.ss} that \code{ss.par} is being used
#' 
#' @importFrom r4ss SS_readstarter
#' @importFrom r4ss SS_readforecast
#'
#' @export
set_par_forecastyrs <- function(path, check = FALSE) {
  
  st_file <- r4ss::SS_readstarter(file.path(path, "starter.ss"), verbose = FALSE)
  fc_file <- r4ss::SS_readforecast(file.path(path, "forecast.ss"), verbose = FALSE)
  ss_par  <- readLines(file.path(path, "ss.par"))
  
  nyr <- fc_file$Nforecastyrs + 1
  
  # check
  if (check) {
    stopifnot(st_file$init_values_src > 0)
  }
  
  loc <- grep("Fcast_recruitments", ss_par) + 1
  x   <- unlist(strsplit(ss_par[loc], split = "\ "))
  x   <- x[x != ""]
  
  if (nyr >= length(x)) {
    x <- c(x, rep("0.00000000000", nyr - length(x)))
  } else {
    x <- x[1:nyr]
  }
  ss_par[loc] <- paste0(c(" ", x), collapse = "\ ")
  
  loc <- grep("Fcast_impl_error", ss_par) + 1
  y   <- unlist(strsplit(ss_par[loc], split = "\ "))
  y   <- y[y != ""]
  
  nyr <- nyr - 1
  
  if (nyr >= length(y)) {
    y <- c(y, rep("0.00000000000", nyr - length(y)))
  } else {
    y <- y[1:nyr]
  }
  ss_par[loc] <- paste0(c(" ", y), collapse = "\ ")
  
  invisible(writeLines(ss_par, con = file.path(path, "ss.par")))
}


