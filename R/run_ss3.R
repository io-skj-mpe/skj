#' Run SS3
#' 
#' @export
run_ss3 <- function(admb_options = "", ss_bin = "ss3", hess = FALSE, ignore.stdout = TRUE, admb_pause = 0.05, show.output.on.console = FALSE, ...) {
  
  # Input checking:
  admb_options <- sanitize_admb_options(admb_options, "-nohess")
  admb_options <- sanitize_admb_options(admb_options, "-noest")
  
  os <- .Platform$OS.type
  
  bin <- Sys.which(ss_bin) #get_bin(ss_bin)
  
  if (bin == "") stop("The SS3 executable was not found in your path")
  
  ss_em_options <- ifelse(hess, "", "-nohess")
  
  if(os == "unix") {
    system(paste0(bin, " ", ss_em_options, " ", admb_options), ignore.stdout = ignore.stdout, ...)
    rename_ss3_files(path = file.path(sc, it, type), ss_bin = ss_bin,
                     extensions = c("par", "rep", "log", "bar"))
  } else {
    system(paste0(paste0(bin, " "), ss_em_options, admb_options),
           invisible = TRUE, ignore.stdout = ignore.stdout,
           show.output.on.console = show.output.on.console, ...)
    #rename_ss3_files(path = "", ss_bin = ss_bin, extensions = c("par", "rep", "log", "bar"))
  }
  Sys.sleep(admb_pause)
}

#' Rename SS3-version-specific files
#'
#' @param path The path to the folder with the files.
#' @param ss_bin A character value giving the SS binary name
#' @param extensions A character vector of file extensions to rename without
#'   periods preceding the values.
#' @author Sean C. Anderson
rename_ss3_files <- function(path, ss_bin, extensions) {
  for(i in seq_along(extensions)) {
    file.rename(from = file.path(path, paste0(ss_bin, ".", extensions[i])),
                to   = file.path(path, paste0("ss3",  ".", extensions[i])))
  }
}

#' Check admb options to make sure there aren't flags there shouldn't
#' be
#'
#' @param x The admb options
#' @param exclude A character object (not a vector)
#' @author Sean C. Anderson
sanitize_admb_options <- function(x, exclude = "-nohess") {
  if(length(x) > 1) stop("x should be of length 1")
  if(length(exclude) > 1) stop("exclude should be of length 1")

  x_split <- strsplit(x, " ")[[1]]
  x_split_g <- grep(exclude, x_split)
  if(sum(x_split_g) > 0) {
    warning(paste("Removed admb_option", x_split[x_split_g]))
    x_split_clean <- x_split[-x_split_g]
  } else {
    x_split_clean <- x_split
  }
  paste(x_split_clean, collapse = " ")
}
