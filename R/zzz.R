.onAttach <- function(libname, pkgname) {
    packageStartupMessage("skj version 0.1.8 (23-Jan-2024)")
}
 
.onLoad <- function(libname, pkgname) {
  invisible(suppressPackageStartupMessages(
    sapply(c("r4ss"),
        requireNamespace, quietly = TRUE)
  ))
}
