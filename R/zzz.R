.onAttach <- function(libname, pkgname) {
    packageStartupMessage("skj version 0.1.9 (19-Oct-2026)")
}
 
.onLoad <- function(libname, pkgname) {
  invisible(suppressPackageStartupMessages(
    sapply(c("r4ss"),
        requireNamespace, quietly = TRUE)
  ))
}
