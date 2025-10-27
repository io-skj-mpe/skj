.onAttach <- function(libname, pkgname) {
    packageStartupMessage("skj version 0.1.5 (27-Oct-2025)")
}
 
.onLoad <- function(libname, pkgname) {
  invisible(suppressPackageStartupMessages(
    sapply(c("r4ss"),
        requireNamespace, quietly = TRUE)
  ))
}
