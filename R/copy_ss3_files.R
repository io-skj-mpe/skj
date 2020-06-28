#' Copy IOTC 2017 SKJ assessment files
#'
#' StockSynthesis files retained in the package are copied to
#' the specified directory 
#' 
#' @param run source run
#' @param path destination directory path
#' @param overwrite logical indicating whether destination directory should be cleaned
#'
#' @examples
#' \dontrun{
#'
#' temp_path <- file.path(tempdir(), "ss3-example")
#' dir.create(temp_path, showWarnings = FALSE)
#' copy_ss3_files("io_h90_MAt_t4_rttp_tm25", temp_path)
#' }
#' @export
copy_ss3_files <- function(run, path, overwrite = TRUE) {
  
  if (!dir.exists(path)) {
    dir.create(path, run, recursive = TRUE)
  }
  
  # Find the data in the package:
  DIR <- system.file(file.path("extdata", run), package = "skj")
  file.copy(file.path(DIR, "control.ss"), file.path(path, run, "control.ss"), overwrite = overwrite)
  file.copy(file.path(DIR, "data.ss"), file.path(path, run, "data.ss"), overwrite = overwrite)
  file.copy(file.path(DIR, "forecast.ss"), file.path(path, run, "forecast.ss"), overwrite = overwrite)
  file.copy(file.path(DIR, "starter.ss"), file.path(path, run, "starter.ss"), overwrite = overwrite)
}


