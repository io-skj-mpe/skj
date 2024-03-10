.onAttach <- function(libname, pkgname) {
    packageStartupMessage("skj version 0.1.9 (10-Mar-2024)")
}
 
.onLoad <- function(libname, pkgname) {
  invisible(suppressPackageStartupMessages(
    sapply(c("r4ss"),
        requireNamespace, quietly = TRUE)
  ))
}
