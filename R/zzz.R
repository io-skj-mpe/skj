.onAttach <- function(libname, pkgname) {
    packageStartupMessage("skj version 0.1.7 (28-Dec-2023)")
}
 
.onLoad <- function(libname, pkgname) {
  invisible(suppressPackageStartupMessages(
    sapply(c("r4ss"),
        requireNamespace, quietly = TRUE)
  ))
}
