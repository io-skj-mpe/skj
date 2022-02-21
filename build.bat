del skj_*.tar.gz
Rscript -e "roxygen2::roxygenize('.')"
Rscript version_update.R
Rcmd build --no-build-vignettes .
Rcmd INSTALL skj_*.tar.gz

