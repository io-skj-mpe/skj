#' @title Set of functions to tidy directory after SS3 run
#'
#' @description Useful for deleting unnecessary files following SS3 run and compressing necessary files.
#'
#' @export
SS_tidy <- function(dir, 
                    gzfiles    = c("Report.sso", "covar.sso", "CumReport.sso", "Forecast-report.sso"), 
                    keepfiles  = c("starter.ss", "forecast.ss", "ss.par", "watatage.ss"), 
                    inputfiles = c("control.ss", "data.ss")) {
  
  allfiles <- list.files(dir)
  loc      <- unlist(lapply(c(gzfiles, keepfiles, inputfiles, "*.R", "*.rda", "*.csv"), grep, allfiles))
  
  file.remove(file.path(dir, allfiles[-loc]))
  
  gzfiles  <- file.path(dir, gzfiles)
  
  gzfiles  <- gzfiles[basename(gzfiles) %in% list.files(dir)]
  
  lapply(gzfiles, function(x) ifelse(grepl("Windows", osVersion), shell(paste0("gzip ", x)), system(paste0("gzip ", normalizePath(x)))))
  
  invisible(0)
}
#' @export
SS_unpack <- function(dir, gzfiles = c("Report.sso", "covar.sso", "CumReport.sso", "Forecast-report.sso")) {
  
  gzfiles  <- file.path(dir, paste0(gzfiles, ".gz"))
  
  gzfiles  <- gzfiles[basename(gzfiles) %in% list.files(dir)]
  
  lapply(gzfiles, function(x) ifelse(grepl("Windows", osVersion), shell(paste0("gzip -d ", x)), system(paste0("gzip -d ", normalizePath(x)))))
  
  invisible(0)
}
#' @export
SS_pack <- function(dir, gzfiles = c("Report.sso", "covar.sso", "CumReport.sso", "Forecast-report.sso")) {
  
  gzfiles  <- file.path(dir, gzfiles)
  
  gzfiles  <- gzfiles[basename(gzfiles) %in% list.files(dir)]
  
  lapply(gzfiles, function(x) ifelse(grepl("Windows", osVersion), shell(paste0("gzip ", x)), system(paste0("gzip ", normalizePath(x)))))
  
  invisible(0)
}
