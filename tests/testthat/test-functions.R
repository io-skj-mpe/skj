
### RUN SS3 2023 ASSESSMENT

#run <- "io_h90_MAt_t4_rttp_tm25"
#run <- "io_h90_q0_tlambda1"

runs <- scan(system.file("extdata", "runs_2023", package = "skj"), what = character())
run  <- sample(runs, 1)

run_path <- tempdir()
dir.create(run_path, showWarnings = FALSE, recursive = TRUE)
setwd(run_path)

copy_ss3_files(run = run, path = ".")
setwd(run)

run_ss3()

skj_dat <- r4ss::SS_readdat("data.ss")
skj_rep <- r4ss::SS_output(".", printstats = FALSE, verbose = FALSE, covar = FALSE)

#### TEST
test_wt_at_age <- function(data, report, iter = 100) {
    
    Nages <- data$Nages
    
    Wt1 <- subset(report$ageselex, Factor == "bodywt")[, -1]
    Wt2 <- report$wtatage
    
    test <- logical(iter)
    
    for (i in 1:iter) {
        
        loc <- sample(nrow(Wt1), 1)
        
        Wt1_fold <- Wt1[loc, ]
        Wt2_fold <- subset(Wt2,  Fleet == Wt1_fold$Fleet & Yr == Wt1_fold$Yr & Seas == Wt1_fold$Seas & Sex == Wt1_fold$Sex & BirthSeas == Wt1_fold$Morph)

        if (nrow(Wt2_fold) == 0) {
            message("factor combination not in 'wtatage'")
            test[i] <- NA
            next
        }
        
        test[i] <- all(Wt1_fold[,c(7:(Nages + 7))] == Wt2_fold[,c(7:(Nages + 7))])
    }
    return(all(test, na.rm = TRUE))
}

test_that("test_wt_at_age", {
  expect_true(test_wt_at_age(skj_dat, skj_rep))
})

test_wtSel_at_age <- function(data, report, iter = 100) {
    
    Nages <- data$Nages
    
    fleet_names <- data$fleetname
    
    # raw data
    Sel <- subset(report$ageselex, Factor == "Asel2")[, -1]
    Wt  <- subset(report$ageselex, Factor == "bodywt")[, -1]
    
    # function to be tested
    WtSel <- get_wtSel_at_age(data, report)
    
    test <- logical(iter)
    
    for (i in 1:iter) {
        
        loc <- sample(nrow(WtSel), 1)
        
        # function output
        WtSel_fold <- WtSel[loc, ]
        
        # raw inputs
        Wt_fold   <- subset(Wt,  Fleet == match(WtSel_fold$Fleet, fleet_names) & Yr == WtSel_fold$Yr & Seas == WtSel_fold$Seas & Sex == WtSel_fold$Sex & Morph == WtSel_fold$Morph)
        Sel_fold  <- subset(Sel, Fleet == match(WtSel_fold$Fleet, fleet_names) & Yr == WtSel_fold$Yr & Seas == WtSel_fold$Seas & Sex == WtSel_fold$Sex & Morph == WtSel_fold$Morph)
        
        # check output from function equals 
        # expected output from raw data
        test[i] <- all(WtSel_fold[,c(6:(Nages + 6))] == Wt_fold[,c(7:(Nages + 7))] * Sel_fold[,c(7:(Nages + 7))])
    }
    return(all(test))
}

test_that("test_wtSel_at_age", {
  expect_true(test_wtSel_at_age(skj_dat, skj_rep))
})

test_NwtSel_at_age <- function(data, report, iter = 100) {
    
    Nages <- data$Nages
    
    fleet_names <- data$fleetname
    
    # NUMBERS AT AGE
    N <- get_N_at_age(data, report)
    
    # WEIGHT * SELECTIVITY AT AGE
    WtSel <- get_wtSel_at_age(data, report)
    
    # function to be tested
    NwtSel <- get_NwtSel_at_age(data, report)
    
    test <- logical(iter)
    
    for (i in 1:iter) {
        
        loc <- sample(nrow(NwtSel), 1)
        
        # function output
        NwtSel_fold <- NwtSel[loc, ]
        
        # raw inputs
        N_fold     <- subset(N,     Fleet == NwtSel_fold$Fleet & Yr == NwtSel_fold$Yr & Seas == NwtSel_fold$Seas & Sex == NwtSel_fold$Sex & Morph == NwtSel_fold$Morph)
        WtSel_fold <- subset(WtSel, Fleet == NwtSel_fold$Fleet & Yr == NwtSel_fold$Yr & Seas == NwtSel_fold$Seas & Sex == NwtSel_fold$Sex & Morph == NwtSel_fold$Morph)

        # check output from function equals 
        # expected output from raw data
        test[i] <- all(NwtSel_fold[,c(7:(Nages + 7))] == N_fold[,c(14:(Nages + 14))] * WtSel_fold[,c(6:(Nages + 6))])
    }
    return(all(test))
}

test_that("test_NwtSel_at_age", {
  expect_true(test_NwtSel_at_age(skj_dat, skj_rep))
})

test_Nex_at_age <- function(data, report, iter = 100) {
  
  Nages <- data$Nages
  
  fleet_names <- data$fleetname
  
  surveytiming <- data$surveytiming
  
  # raw data
  Sraw <- subset(report$ageselex, Factor == "Asel2")[, -1]
  Nraw <- report$natage
  
  # function to be tested
  Nex <- get_Nex_at_age(data, report)
  
  test <- logical(iter)
  
  for (i in 1:iter) {
    
    loc <- sample(nrow(Nex), 1)
    
    # function output
    Nex_fold <- Nex[loc, ]
    
    # fleet number
    Fleet_loc <- match(Nex_fold$Fleet, fleet_names)
    
    # raw inputs
    Sraw_fold <- subset(Sraw, Fleet ==  Fleet_loc & Yr == Nex_fold$Yr & Seas == Nex_fold$Seas & Sex == Nex_fold$Sex & Morph == Nex_fold$Morph)
    Nraw_fold <- subset(Nraw, Yr == Nex_fold$Yr & Seas == Nex_fold$Seas & Sex == Nex_fold$Sex & Morph == Nex_fold$Morph)[ifelse(surveytiming[Fleet_loc] < 0, 1, 2),]
    
    # check output from function equals 
    # expected output from raw data
    test[i] <- all(Nex_fold[,c(7:(Nages + 7))] == Nraw_fold[,c(13:(Nages + 13))] * Sraw_fold[,c(7:(Nages + 7))])
  }
  return(all(test))
}

test_that("test_Nex_at_age", {
  expect_true(test_Nex_at_age(skj_dat, skj_rep))
})


#### END OF TESTS

