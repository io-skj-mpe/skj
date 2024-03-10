#V3.30.22.1;_safe;_compile_date:_Jan 30 2024;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_13.1
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-ost/ss3-source-code

#_data_and_control_files: DATA.SS // CONTROL.SS
0  # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and also read and use growth parameters
1  #_N_Growth_Patterns (Growth Patterns, Morphs, Bio Patterns, GP are terms used interchangeably in SS3)
1 #_N_platoons_Within_GrowthPattern 
#_Cond 1 #_Platoon_within/between_stdev_ratio (no read if N_platoons=1)
#_Cond sd_ratio_rd < 0: platoon_sd_ratio parameter required after movement params.
#_Cond  1 #vector_platoon_dist_(-1_in_first_val_gives_normal_approx)
#
2 # recr_dist_method for parameters:  2=main effects for GP, Area, Settle timing; 3=each Settle entity; 4=none (only when N_GP*Nsettle*pop==1)
1 # not yet implemented; Future usage: Spawner-Recruitment: 1=global; 2=by area
4 #  number of recruitment settlement assignments 
0 # unused option
#GPattern month  area  age (for each settlement assignment)
 1 1 1 0
 1 4 1 0
 1 7 1 0
 1 10 1 0
#
#_Cond 0 # N_movement_definitions goes here if Nareas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
#
3 #_Nblock_Patterns
 5 5 1 #_blocks_per_pattern 
# begin and end years of blocks
 1960 1988 1989 1993 1994 1998 1999 2003 2004 2009
 1960 1976 1977 1984 1985 1992 1993 2000 2001 2009
 1949 1949
#
# controls for all timevary parameters 
1 #_time-vary parm bound check (1=warn relative to base parm bounds; 3=no bound check); Also see env (3) and dev (5) options to constrain with base bounds
#
# AUTOGEN
 1 1 1 1 1 # autogen: 1st element for biology, 2nd for SR, 3rd for Q, 4th reserved, 5th for selex
# where: 0 = autogen time-varying parms of this category; 1 = read each time-varying parm line; 2 = read then autogen if parm min==-12345
#
#_Available timevary codes
#_Block types: 0: P_block=P_base*exp(TVP); 1: P_block=P_base+TVP; 2: P_block=TVP; 3: P_block=P_block(-1) + TVP
#_Block_trends: -1: trend bounded by base parm min-max and parms in transformed units (beware); -2: endtrend and infl_year direct values; -3: end and infl as fraction of base range
#_EnvLinks:  1: P(y)=P_base*exp(TVP*env(y));  2: P(y)=P_base+TVP*env(y);  3: P(y)=f(TVP,env_Zscore) w/ logit to stay in min-max;  4: P(y)=2.0/(1.0+exp(-TVP1*env(y) - TVP2))
#_DevLinks:  1: P(y)*=exp(dev(y)*dev_se;  2: P(y)+=dev(y)*dev_se;  3: random walk;  4: zero-reverting random walk with rho;  5: like 4 with logit transform to stay in base min-max
#_DevLinks(more):  21-25 keep last dev for rest of years
#
#_Prior_codes:  0=none; 6=normal; 1=symmetric beta; 2=CASAL's beta; 3=lognormal; 4=lognormal with biascorr; 5=gamma
#
# setup for M, growth, wt-len, maturity, fecundity, (hermaphro), recr_distr, cohort_grow, (movement), (age error), (catch_mult), sex ratio 
#_NATMORT
1 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate;_5=BETA:_Maunder_link_to_maturity;_6=Lorenzen_range
5 #_N_breakpoints
 0 1 2 3 4 # age(real) at M breakpoints
#
2 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specific_K_incr; 4=age_specific_K_decr; 5=age_specific_K_each; 6=NA; 7=NA; 8=growth cessation
0 #_Age(post-settlement) for L1 (aka Amin); first growth parameter is size at this age; linear growth below this
999 #_Age(post-settlement) for L2 (aka Amax); 999 to treat as Linf
-999 #_exponential decay for growth above maxage (value should approx initial Z; -999 replicates 3.24; -998 to not allow growth above maxage)
0  #_placeholder for future growth feature
#
0.1 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
#
1 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity
1 #_First_Mature_Age
1 #_fecundity_at_length option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn
3 #_parameter_offset_approach for M, G, CV_G:  1- direct, no offset**; 2- male=fem_parm*exp(male_parm); 3: male=female*exp(parm) then old=young*exp(parm)
#_** in option 1, any male parameter with value = 0.0 and phase <0 is set equal to female parameter
#
#_growth_parms
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env_var&link dev_link dev_minyr dev_maxyr dev_PH Block Block_Fxn
# Sex: 1  BioPattern: 1  NatMort
 0.075 2 0.8 0.8 1 6 -5 0 0 0 0 0.5 0 0 # NatM_break_1_Fem_GP_1
 -3 3 -0 -0 1 6 -7 0 0 0 0 0.5 0 0 # NatM_break_2_Fem_GP_1
 -3 3 -0 -0 1 6 -7 0 0 0 0 0.5 0 0 # NatM_break_3_Fem_GP_1
 -3 3 -0 -0 1 6 -6 0 0 0 0 0.5 0 0 # NatM_break_4_Fem_GP_1
 -3 3 -0 -0 1 6 -6 0 0 0 0 0.5 0 0 # NatM_break_5_Fem_GP_1
# Sex: 1  BioPattern: 1  Growth
 -30 30 5.89629 20 100 6 -5 0 0 0 0 0.5 0 0 # L_at_Amin_Fem_GP_1
 50 100 70.3509 70.2 100 6 -5 0 0 0 0 0.5 0 0 # L_at_Amax_Fem_GP_1
 -3 3 0.34809 0.373 100 6 -1 0 0 0 0 0.5 0 0 # VonBert_K_Fem_GP_1
 0 5 2.9096 1 1 0 -5 0 0 0 0 0 0 0 # Richards_Fem_GP_1
 0.01 60 0.2 0.2 100 6 -5 0 0 0 0 0.5 0 0 # CV_young_Fem_GP_1
 -3 3 -0.69 -0.69 100 6 -5 0 0 0 0 0.5 0 0 # CV_old_Fem_GP_1
# Sex: 1  BioPattern: 1  WtLen
 -3 3 4.97e-06 4.97e-06 100 6 -1 0 0 0 0 0.5 0 0 # Wtlen_1_Fem_GP_1
 2 4 3.39292 3.39292 100 6 -1 0 0 0 0 0.5 0 0 # Wtlen_2_Fem_GP_1
# Sex: 1  BioPattern: 1  Maturity&Fecundity
 1 150 38 38 100 6 -1 0 0 0 0 0.5 0 0 # Mat50%_Fem_GP_1
 -8 1 -1.25 -1.25 100 6 -1 0 0 0 0 0.5 0 0 # Mat_slope_Fem_GP_1
 0 2 1 1 100 6 -1 0 0 0 0 0.5 0 0 # Eggs/kg_inter_Fem_GP_1
 -1 1 0 0 100 6 -1 0 0 0 0 0.5 0 0 # Eggs/kg_slope_wt_Fem_GP_1
# Hermaphroditism
#  Recruitment Distribution 
 -4 4 0 0 99 0 -3 0 0 0 0 0.5 0 0 # RecrDist_GP_1
 -4 4 0 0 99 0 -3 0 0 0 0 0.5 0 0 # RecrDist_Area_1
 -4 4 0 0 99 0 -3 0 0 0 0 0.5 0 0 # RecrDist_month_1
 -4 4 0.19414 0 0.1 6 5 0 1 1983 2015 5 0 0 # RecrDist_month_4
 -4 4 0.00041429 0 0.1 6 5 0 1 1983 2015 5 0 0 # RecrDist_month_7
 -4 4 -0.217428 0 0.1 6 5 0 1 1983 2015 5 0 0 # RecrDist_month_10
#  Cohort growth dev base
 0.1 10 1 1 1 6 -1 0 0 0 0 0.5 0 0 # CohortGrowDev
#  Movement
#  Platoon StDev Ratio 
#  Age Error from parameters
#  catch multiplier
#  fraction female, by GP
 1e-06 0.999999 0.5 0.5 0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_1
#  M2 parameter for each predator fleet
#
# timevary MG parameters 
#_ LO HI INIT PRIOR PR_SD PR_type  PHASE
 0.0001 2 0.3 0.3 0.5 6 -5 # RecrDist_month_4_dev_se
 -0.99 0.99 0 0 0.5 6 -6 # RecrDist_month_4_dev_autocorr
 0.0001 2 0.3 0.3 0.5 6 -5 # RecrDist_month_7_dev_se
 -0.99 0.99 0 0 0.5 6 -6 # RecrDist_month_7_dev_autocorr
 0.0001 2 0.3 0.3 0.5 6 -5 # RecrDist_month_10_dev_se
 -0.99 0.99 0 0 0.5 6 -6 # RecrDist_month_10_dev_autocorr
# info on dev vectors created for MGparms are reported with other devs after tag parameter section 
#
#_seasonal_effects_on_biology_parms
 0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_ LO HI INIT PRIOR PR_SD PR_type PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
6 #_Spawner-Recruitment; Options: 1=NA; 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=survival_3Parm; 8=Shepherd_3Parm; 9=RickerPower_3parm
0  # 0/1 to use steepness in initial equ recruitment calculation
0  #  future feature:  0/1 to make realized sigmaR a function of SR curvature
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn #  parm_name
             0            35       13.5097            20            10             6          1          0          0          0          0          0          0          0 # SR_LN(R0)
         0.201          0.99           0.9           0.9            10             6         -2          0          0          0          0          0          0          0 # SR_BH_flat_steep
             0            10      0.294913           0.6            10             6          6          0          0          0          0          0          0          0 # SR_sigmaR
            -5             5             0             0             1             6         -4          0          0          0          0          0          0          0 # SR_regime
             0           0.5             0             0            99             0         -2          0          0          0          0          0          0          0 # SR_autocorr
#_no timevary SR parameters
1 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1983 # first year of main recr_devs; early devs can precede this era
2014 # last year of main recr_devs; forecast devs start in following year
4 #_recdev phase 
1 # (0/1) to read 13 advanced options
 0 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 -4 #_recdev_early_phase
 -10 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1960 #_last_yr_nobias_adj_in_MPD; begin of ramp
 1983 #_first_yr_fullbias_adj_in_MPD; begin of plateau
 2014 #_last_yr_fullbias_adj_in_MPD
 2015 #_end_yr_for_ramp_in_MPD (can be in forecast to shape ramp, but SS3 sets bias_adj to 0.0 for fcast yrs)
 1 #_max_bias_adj_in_MPD (typical ~0.8; -3 sets all years to 0.0; -2 sets all non-forecast yrs w/ estimated recdevs to 1.0; -1 sets biasadj=1.0 for all yrs w/ recdevs)
 0 #_period of cycles in recruitment (N parms read below)
 -15 #min rec_dev
 15 #max rec_dev
 0 #_read_recdevs
#_end of advanced SR options
#
#_placeholder for full parameter lines for recruitment cycles
# read specified recr devs
#_Yr Input_value
#
# all recruitment deviations
#  1983R 1984R 1985R 1986R 1987R 1988R 1989R 1990R 1991R 1992R 1993R 1994R 1995R 1996R 1997R 1998R 1999R 2000R 2001R 2002R 2003R 2004R 2005R 2006R 2007R 2008R 2009R 2010R 2011R 2012R 2013R 2014R 2015F 2016F 2017F 2018F 2019F 2020F 2021F 2022F 2023F 2024F 2025F 2026F
#  0.0562867 0.535069 -0.142965 -0.256349 0.584876 -0.337203 0.13611 0.290113 0.173785 0.0154481 0.250065 0.0579503 -0.0841045 -0.210611 -0.155116 0.480005 0.0904223 -0.0812844 0.460669 -0.0127616 0.0713423 0.45172 0.0310611 -0.762371 -0.0171707 0.0964536 -0.0709576 -0.336924 -0.571066 -0.146392 -0.0641352 -0.531966 0 0 0 0 0 0 0 0 0 0 0 0
#
#Fishing Mortality info 
0.15 # F ballpark value in units of annual_F
2000 # F ballpark year (neg value to disable)
3 # F_Method:  1=Pope midseason rate; 2=F as parameter; 3=F as hybrid; 4=fleet-specific parm/hybrid (#4 is superset of #2 and #3 and is recommended)
7 # max F (methods 2-4) or harvest fraction (method 1)
5  # N iterations for tuning in hybrid mode; recommend 3 (faster) to 5 (more precise if many fleets)
#
#_initial_F_parms; for each fleet x season that has init_catch; nest season in fleet; count = 0
#_for unconstrained init_F, use an arbitrary initial catch and set lambda=0 for its logL
#_ LO HI INIT PRIOR PR_SD  PR_type  PHASE
#
# F rates by fleet x season
# Yr:  1950 1950 1950 1950 1951 1951 1951 1951 1952 1952 1952 1952 1953 1953 1953 1953 1954 1954 1954 1954 1955 1955 1955 1955 1956 1956 1956 1956 1957 1957 1957 1957 1958 1958 1958 1958 1959 1959 1959 1959 1960 1960 1960 1960 1961 1961 1961 1961 1962 1962 1962 1962 1963 1963 1963 1963 1964 1964 1964 1964 1965 1965 1965 1965 1966 1966 1966 1966 1967 1967 1967 1967 1968 1968 1968 1968 1969 1969 1969 1969 1970 1970 1970 1970 1971 1971 1971 1971 1972 1972 1972 1972 1973 1973 1973 1973 1974 1974 1974 1974 1975 1975 1975 1975 1976 1976 1976 1976 1977 1977 1977 1977 1978 1978 1978 1978 1979 1979 1979 1979 1980 1980 1980 1980 1981 1981 1981 1981 1982 1982 1982 1982 1983 1983 1983 1983 1984 1984 1984 1984 1985 1985 1985 1985 1986 1986 1986 1986 1987 1987 1987 1987 1988 1988 1988 1988 1989 1989 1989 1989 1990 1990 1990 1990 1991 1991 1991 1991 1992 1992 1992 1992 1993 1993 1993 1993 1994 1994 1994 1994 1995 1995 1995 1995 1996 1996 1996 1996 1997 1997 1997 1997 1998 1998 1998 1998 1999 1999 1999 1999 2000 2000 2000 2000 2001 2001 2001 2001 2002 2002 2002 2002 2003 2003 2003 2003 2004 2004 2004 2004 2005 2005 2005 2005 2006 2006 2006 2006 2007 2007 2007 2007 2008 2008 2008 2008 2009 2009 2009 2009 2010 2010 2010 2010 2011 2011 2011 2011 2012 2012 2012 2012 2013 2013 2013 2013 2014 2014 2014 2014 2015 2015 2015 2015 2016 2016 2016 2016 2017 2017 2017 2017 2018 2018 2018 2018 2019 2019 2019 2019 2020 2020 2020 2020 2021 2021 2021 2021 2022 2022 2022 2022 2023 2023 2023 2023 2024 2024 2024 2024 2025 2025 2025 2025 2026 2026 2026 2026
# seas:  1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4
# PL 0.00954188 0.00958989 0.0095879 0.00955901 0.00957989 0.00962757 0.00962464 0.00959444 0.00961272 0.00965645 0.00964947 0.00961547 0.010835 0.0108822 0.0108724 0.0108325 0.0108488 0.010895 0.0108845 0.0108436 0.0108587 0.0109038 0.0108922 0.0108506 0.0108656 0.0109106 0.010899 0.0108573 0.0120806 0.0121319 0.0121197 0.0120742 0.0120908 0.0121401 0.0121259 0.0120782 0.0120935 0.0121425 0.0121282 0.0120801 0.0105953 0.0136801 0.011054 0.00829738 0.0105659 0.0127614 0.00806875 0.00737334 0.0108376 0.0123332 0.00839345 0.00721911 0.0111911 0.0116897 0.00851556 0.0074275 0.0112069 0.0117055 0.0085266 0.00743684 0.0197871 0.0206746 0.0150684 0.0131468 0.0237902 0.0248648 0.0181252 0.0158166 0.0267059 0.0279052 0.0203409 0.0177438 0.0247988 0.0259063 0.0188731 0.0164624 0.0278253 0.0290694 0.0211776 0.0184684 0.0306428 0.0181065 0.0442406 0.0431365 0.031468 0.0312865 0.0332319 0.0425561 0.0316547 0.0183731 0.0213886 0.015117 0.029567 0.0158216 0.0221331 0.0292026 0.023654 0.037541 0.0233747 0.0274893 0.0180747 0.0233331 0.0188526 0.0141471 0.0276509 0.0317784 0.0156246 0.0176511 0.0202229 0.0198619 0.0160998 0.0120275 0.0211083 0.0156624 0.0150894 0.0137718 0.0228442 0.0228132 0.0177361 0.0226134 0.0315774 0.0271405 0.0253009 0.0266646 0.0282605 0.0230041 0.0249053 0.0221698 0.0184613 0.0244953 0.0199241 0.0138868 0.0292541 0.0299404 0.0173462 0.0206416 0.0387879 0.0299822 0.0339514 0.0552369 0.0543252 0.0409293 0.0323906 0.0633462 0.0563553 0.0400651 0.0450649 0.0713607 0.0676455 0.0661363 0.0450431 0.0407907 0.0911117 0.0483679 0.0536072 0.0956084 0.0882765 0.0727483 0.0676176 0.0748146 0.0814431 0.0587275 0.0773421 0.115635 0.0541286 0.0868933 0.0849754 0.0840707 0.0745548 0.0906137 0.0485709 0.0934541 0.0746421 0.0791063 0.0791778 0.0909366 0.105539 0.0994635 0.102823 0.0861824 0.114007 0.0900821 0.0713494 0.151645 0.117343 0.127712 0.0963881 0.102605 0.118034 0.124074 0.139339 0.140038 0.174634 0.129726 0.126895 0.193041 0.164385 0.176902 0.168088 0.133169 0.156884 0.12131 0.128915 0.116596 0.154413 0.117624 0.139644 0.181586 0.196585 0.170361 0.17425 0.202667 0.194693 0.183941 0.154573 0.202182 0.227004 0.135929 0.165961 0.210934 0.195698 0.231766 0.190793 0.258941 0.264594 0.334226 0.159372 0.263399 0.279713 0.244862 0.172932 0.302965 0.194516 0.212749 0.268067 0.301116 0.165861 0.163782 0.145341 0.212063 0.205306 0.163175 0.17788 0.194155 0.205339 0.11736 0.119437 0.159345 0.114489 0.161215 0.128516 0.272908 0.144287 0.203303 0.251774 0.359049 0.212362 0.328699 0.148671 0.200959 0.306243 0.272488 0.117455 0.257373 0.188532 0.203954 0.117286 0.337726 0.352178 0.303201 0.129538 0.291787 0.336058 0.290749 0.124935 0.282681 0.326687 0.283576 0.122258 0.277304 0.321072 0.279228 0.120621 0.273996 0.317606 0.276537 0.119605 0.271942 0.315452 0.274863 0.118973 0.270662 0.314109 0.273819 0.118578 0.269863 0.31327 0.273167 0.118332 0.269363 0.312746 0.272759 0.118177 0.269051 0.312418 0.272504 0.118081 0.268855
# PSLS 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000542611 0 0 0 0.00122336 0.00019764 0 0.00160007 0.00708803 0.00692573 0.00331135 0.0122973 0.00499107 0.0157699 0.0387151 0.0451553 0.0128098 0.0205439 0.0547543 0.0720998 0.0224165 0.0394689 0.0635988 0.069432 0.0381722 0.0624985 0.0709384 0.0514912 0.0190345 0.035687 0.108266 0.0735139 0.0382831 0.0383237 0.114994 0.126281 0.0484925 0.0630966 0.0985979 0.0841843 0.0223561 0.0662107 0.0967607 0.143905 0.05753 0.0976014 0.109025 0.134068 0.0675647 0.0959511 0.141293 0.137659 0.0630797 0.0862341 0.183824 0.171129 0.124076 0.136256 0.187526 0.184631 0.0840791 0.101949 0.168849 0.245624 0.144116 0.127654 0.19025 0.26256 0.223925 0.12002 0.17947 0.177795 0.100134 0.11717 0.237864 0.217264 0.116799 0.140984 0.244548 0.311713 0.128773 0.101505 0.311351 0.220409 0.143696 0.11725 0.344799 0.26542 0.213632 0.0869808 0.251241 0.357604 0.127158 0.077299 0.212068 0.259991 0.129801 0.106165 0.239149 0.226158 0.119831 0.0761363 0.415193 0.555303 0.157387 0.147246 0.394497 0.243015 0.0762994 0.173076 0.31254 0.291795 0.2445 0.121401 0.322625 0.202899 0.258323 0.161053 0.31665 0.235958 0.291032 0.169764 0.234824 0.311095 0.2772 0.117876 0.192534 0.158104 0.28664 0.162107 0.211837 0.317049 0.313761 0.103676 0.331228 0.235287 0.330077 0.175082 0.295215 0.289189 0.346664 0.226842 0.407568 0.31665 0.349309 0.174848 0.299196 0.32442 0.341229 0.171253 0.293821 0.319173 0.336151 0.168969 0.290434 0.315893 0.332995 0.167554 0.288335 0.313861 0.33104 0.166677 0.287033 0.312599 0.329824 0.166131 0.286222 0.311812 0.329067 0.165791 0.285716 0.311322 0.328594 0.165578 0.2854 0.311015 0.328298 0.165446 0.285202 0.310823 0.328113 0.165363 0.285079 0.310703
# PSFS 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 5.17048e-05 0 0 4.28494e-05 3.96451e-05 9.20329e-06 0 0.000208576 0.00106432 0.000129272 2.78069e-05 0.00372369 0.00581238 0.00320118 0.00323647 0.0160251 0.0104358 0.00692224 0.00227841 0.00693552 0.01028 0.028648 0.00908363 0.00651245 0.0043307 0.0149742 0.0278256 0.0376907 0.0110844 0.00917079 0.00317631 0.0355378 0.0668645 0.0560317 0.0242345 0.00542218 0.0360576 0.0229993 0.00447772 0.00727362 0.0073798 0.0132603 0.0103264 0.00620023 0.0173416 0.0194319 0.00753204 0.0151646 0.0141735 0.0472392 0.0159841 0.0153603 0.0183227 0.0565056 0.0147624 0.0385735 0.0349704 0.0307886 0.0166856 0.0174922 0.0471812 0.0481312 0.0114411 0.0171611 0.0248424 0.0182943 0.0144519 0.0270352 0.0300834 0.0474262 0.0162278 0.0123627 0.0577758 0.0345317 0.00805812 0.0193802 0.0227432 0.0478191 0.0120781 0.0106148 0.0247884 0.0281203 0.0100618 0.0417579 0.0112819 0.0179669 0.0092725 0.0266678 0.0364003 0.018251 0.0187342 0.0462486 0.0256809 0.014795 0.0115452 0.0220742 0.023124 0.0613208 0.0274689 0.0397709 0.0159293 0.0778625 0.0144943 0.0257905 0.0273622 0.0784902 0.0228974 0.019392 0.0226568 0.0514612 0.0057739 0.0130103 0.0231878 0.0137254 0.00766197 0.00745241 0.0184639 0.016431 0.0020938 0.0104448 0.0154477 0.0243804 0.00440392 0.0121558 0.0101482 0.00446608 0.00303964 0.00401715 0.00742123 0.0154416 0.00793276 0.00855477 0.0125225 0.0118294 0.00864796 0.0108097 0.018353 0.0113821 0.0153462 0.0111733 0.0158623 0.0145247 0.00630826 0.00547132 0.0204843 0.0119779 0.0157381 0.0121856 0.019783 0.011621 0.0153371 0.0119103 0.0193786 0.0114091 0.0150954 0.0117429 0.0191312 0.0112789 0.0149463 0.0116394 0.0189781 0.0111982 0.0148538 0.0115751 0.0188829 0.0111481 0.0147962 0.0115351 0.0188237 0.0111168 0.0147603 0.0115101 0.0187866 0.0110972 0.0147378 0.0114945 0.0187635 0.011085 0.0147238 0.0114847 0.018749 0.0110774 0.014715 0.0114786
# Other 0.00193872 0.00194429 0.00194844 0.00194676 0.00389807 0.00390891 0.00391683 0.00391289 0.00375126 0.00376004 0.00376612 0.00381333 0.00366696 0.00366109 0.00366645 0.00374101 0.00413475 0.00436448 0.00418513 0.0041343 0.00425983 0.00440378 0.00437353 0.00452953 0.00486739 0.00474409 0.00516882 0.00459031 0.00534854 0.00523494 0.00524216 0.00539178 0.00473325 0.00485584 0.00457314 0.00465378 0.00480336 0.00507017 0.00464885 0.00464614 0.0056258 0.00542325 0.00509973 0.00521456 0.00580546 0.005789 0.00593463 0.00625826 0.00777623 0.00735513 0.00739028 0.00777645 0.00925662 0.00932291 0.00911475 0.00932193 0.00992374 0.00987986 0.0098081 0.0101891 0.0100691 0.0101318 0.00980813 0.0100058 0.0116847 0.0119289 0.0115988 0.0117371 0.0122189 0.0121274 0.0119858 0.0121583 0.0130103 0.0129915 0.0127789 0.0130621 0.0134644 0.0129575 0.0132357 0.0135189 0.0110498 0.01107 0.0133472 0.0117656 0.00975143 0.0100021 0.0114888 0.0100048 0.0124723 0.0130017 0.0148459 0.0134702 0.0183666 0.0191315 0.0204722 0.0185066 0.0242732 0.0240601 0.0252882 0.0239044 0.0199739 0.0209838 0.0229343 0.0208026 0.0218692 0.0235731 0.0267512 0.0241323 0.023005 0.0248256 0.0292618 0.0259056 0.0219579 0.0202963 0.0246097 0.025077 0.01908 0.0321857 0.0202855 0.0205531 0.0235104 0.0219563 0.0258724 0.0242834 0.0228772 0.0211782 0.0443355 0.0234876 0.0324375 0.0311 0.0360861 0.0335317 0.0292896 0.0272845 0.0341518 0.0307011 0.0291874 0.0260286 0.0330398 0.0338391 0.0301298 0.0258364 0.0292814 0.0301408 0.0248036 0.0316797 0.0382328 0.0353343 0.0439089 0.0434449 0.0441276 0.0485703 0.0494527 0.0388368 0.043096 0.0517491 0.0784805 0.0404659 0.0513983 0.0550793 0.08152 0.0600815 0.0652035 0.0485263 0.0694204 0.0630862 0.0779238 0.0801769 0.101592 0.0944927 0.0854436 0.0668455 0.108439 0.108192 0.11206 0.089703 0.105246 0.100836 0.10832 0.108317 0.104869 0.0938545 0.102357 0.100546 0.110225 0.10002 0.11892 0.114798 0.134502 0.137355 0.150389 0.146132 0.161283 0.138591 0.143947 0.124336 0.177742 0.138888 0.138171 0.123884 0.15482 0.124818 0.139525 0.131044 0.153337 0.12849 0.154917 0.140376 0.174766 0.111302 0.141943 0.136676 0.187388 0.134019 0.156325 0.155324 0.243538 0.171819 0.191022 0.191606 0.243627 0.201006 0.201066 0.203458 0.25897 0.247593 0.260064 0.305791 0.323177 0.341892 0.369901 0.411742 0.379664 0.353354 0.351727 0.351112 0.353853 0.323866 0.322675 0.332756 0.3087 0.278355 0.279655 0.302186 0.342394 0.313705 0.312531 0.329259 0.378487 0.382132 0.38742 0.409802 0.443038 0.444679 0.442769 0.455066 0.521411 0.398395 0.377876 0.368618 0.437327 0.364811 0.408379 0.360396 0.39334 0.338109 0.329353 0.32079 0.506191 0.403733 0.434986 0.392843 0.484232 0.388296 0.420701 0.381426 0.471544 0.379205 0.412151 0.374516 0.463805 0.373629 0.406883 0.370247 0.459016 0.370174 0.403613 0.367594 0.45604 0.368025 0.401577 0.365941 0.454182 0.366683 0.400305 0.364909 0.453023 0.365845 0.399511 0.364264 0.452298 0.365322 0.399014 0.36386 0.451845 0.364994 0.398703 0.363608
#
#_Q_setup for fleets with cpue or survey data
#_1:  fleet number
#_2:  link type: (1=simple q, 1 parm; 2=mirror simple q, 1 mirrored parm; 3=q and power, 2 parm; 4=mirror with offset, 2 parm)
#_3:  extra input for link, i.e. mirror fleet# or dev index number
#_4:  0/1 to select extra sd parameter
#_5:  0/1 for biasadj or not
#_6:  0/1 to float
#_   fleet      link link_info  extra_se   biasadj     float  #  fleetname
         5         1         0         0         0         1  #  PL_CPUE
         6         1         0         0         0         1  #  PSLS_CPUE_LONG
         7         1         0         0         0         1  #  OTHER_CPUE
-9999 0 0 0 0 0
#
#_Q_parms(if_any);Qunits_are_ln(q)
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
           -25            25      -10.6744             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_PL_CPUE(5)
           -25            25      -11.1932             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_PSLS_CPUE_LONG(6)
           -25            25      -7.47164             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_OTHER_CPUE(7)
#_no timevary Q parameters
#
#_size_selex_patterns
#Pattern:_0;  parm=0; selex=1.0 for all sizes
#Pattern:_1;  parm=2; logistic; with 95% width specification
#Pattern:_5;  parm=2; mirror another size selex; PARMS pick the min-max bin to mirror
#Pattern:_11; parm=2; selex=1.0  for specified min-max population length bin range
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_6;  parm=2+special; non-parm len selex
#Pattern:_43; parm=2+special+2;  like 6, with 2 additional param for scaling (mean over bin range)
#Pattern:_8;  parm=8; double_logistic with smooth transitions and constant above Linf option
#Pattern:_9;  parm=6; simple 4-parm double logistic with starting length; parm 5 is first length; parm 6=1 does desc as offset
#Pattern:_21; parm=2+special; non-parm len selex, read as pairs of size, then selex
#Pattern:_22; parm=4; double_normal as in CASAL
#Pattern:_23; parm=6; double_normal where final value is directly equal to sp(6) so can be >1.0
#Pattern:_24; parm=6; double_normal with sel(minL) and sel(maxL), using joiners
#Pattern:_2;  parm=6; double_normal with sel(minL) and sel(maxL), using joiners, back compatibile version of 24 with 3.30.18 and older
#Pattern:_25; parm=3; exponential-logistic in length
#Pattern:_27; parm=special+3; cubic spline in length; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=special+3+2; cubic spline; like 27, with 2 additional param for scaling (mean over bin range)
#_discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_discarded_dead;_4=define_dome-shaped_retention
#_Pattern Discard Male Special
 27 0 0 7 # 1 PL
 27 0 0 5 # 2 PSLS
 27 0 0 5 # 3 PSFS
 27 0 0 5 # 4 Other
 5 0 0 1 # 5 PL_CPUE
 5 0 0 2 # 6 PSLS_CPUE_LONG
 5 0 0 4 # 7 OTHER_CPUE
#
#_age_selex_patterns
#Pattern:_0; parm=0; selex=1.0 for ages 0 to maxage
#Pattern:_10; parm=0; selex=1.0 for ages 1 to maxage
#Pattern:_11; parm=2; selex=1.0  for specified min-max age
#Pattern:_12; parm=2; age logistic
#Pattern:_13; parm=8; age double logistic. Recommend using pattern 18 instead.
#Pattern:_14; parm=nages+1; age empirical
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_16; parm=2; Coleraine - Gaussian
#Pattern:_17; parm=nages+1; empirical as random walk  N parameters to read can be overridden by setting special to non-zero
#Pattern:_41; parm=2+nages+1; // like 17, with 2 additional param for scaling (mean over bin range)
#Pattern:_18; parm=8; double logistic - smooth transition
#Pattern:_19; parm=6; simple 4-parm double logistic with starting age
#Pattern:_20; parm=6; double_normal,using joiners
#Pattern:_26; parm=3; exponential-logistic in age
#Pattern:_27; parm=3+special; cubic spline in age; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=2+special+3; // cubic spline; with 2 additional param for scaling (mean over bin range)
#Age patterns entered with value >100 create Min_selage from first digit and pattern from remainder
#_Pattern Discard Male Special
 11 0 0 0 # 1 PL
 11 0 0 0 # 2 PSLS
 11 0 0 0 # 3 PSFS
 11 0 0 0 # 4 Other
 11 0 0 0 # 5 PL_CPUE
 11 0 0 0 # 6 PSLS_CPUE_LONG
 11 0 0 0 # 7 OTHER_CPUE
#
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
# 1   PL LenSelex
             0             0             0             0             0             0        -99          0          0          0          0        0.5          0          0  #  SizeSpline_Code_PL(1)
        -0.001             1      0.993424             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradLo_PL(1)
            -1         0.001     -0.489077             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradHi_PL(1)
             1             1       22.6447             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_1_PL(1)
             1             1       37.5977             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_2_PL(1)
             1             1       42.0377             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_3_PL(1)
             1             1        45.702             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_4_PL(1)
             1             1       51.7386             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_5_PL(1)
             1             1       59.9904             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_6_PL(1)
             1             1       71.3145             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_7_PL(1)
            -9             7      -7.54192             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_1_PL(1)
            -9             7      -2.23097             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_2_PL(1)
            -9             7      -1.45791             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_3_PL(1)
            -9             7            -1             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_4_PL(1)
            -9             7      -1.51095             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_5_PL(1)
            -9             7      -1.10331             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_6_PL(1)
            -9             7     -0.726287             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_7_PL(1)
# 2   PSLS LenSelex
             0             0             0             0             0             0        -99          0          0          0          0        0.5          0          0  #  SizeSpline_Code_PSLS(2)
        -0.001             1      0.677649             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradLo_PSLS(2)
            -1         0.001     -0.172786             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradHi_PSLS(2)
             1             1        23.125             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_1_PSLS(2)
             1             1       41.9035             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_2_PSLS(2)
             1             1       45.6322             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_3_PSLS(2)
             1             1       50.2975             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_4_PSLS(2)
             1             1       70.9228             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_5_PSLS(2)
            -9             7       -8.9974             0         0.001             1         -2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_1_PSLS(2)
            -9             7      -2.00166             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_2_PSLS(2)
            -9             7            -1             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_3_PSLS(2)
            -9             7      -1.21535             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_4_PSLS(2)
            -9             7       -3.3567             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_5_PSLS(2)
# 3   PSFS LenSelex
             0             0             0             0             0             0        -99          0          0          0          0        0.5          0          0  #  SizeSpline_Code_PSFS(3)
        -0.001             1      0.125331             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradLo_PSFS(3)
            -1         0.001     -0.348721             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradHi_PSFS(3)
             1             1       23.1313             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_1_PSFS(3)
             1             1       44.1442             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_2_PSFS(3)
             1             1       48.4634             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_3_PSFS(3)
             1             1       54.7779             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_4_PSFS(3)
             1             1       71.2972             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_5_PSFS(3)
            -9             7      -8.99994             0         0.001             1         -2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_1_PSFS(3)
            -9             7      -1.80513             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_2_PSFS(3)
            -9             7            -1             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_3_PSFS(3)
            -9             7      -1.45786             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_4_PSFS(3)
            -9             7      -2.29328             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_5_PSFS(3)
# 4   Other LenSelex
             0             0             0             0             0             0        -99          0          0          0          0        0.5          0          0  #  SizeSpline_Code_Other(4)
        -0.001             1      0.122981             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradLo_Other(4)
            -1         0.001     -0.175122             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradHi_Other(4)
             1             1       22.5552             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_1_Other(4)
             1             1       44.2844             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_2_Other(4)
             1             1       51.4468             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_3_Other(4)
             1             1       58.8149             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_4_Other(4)
             1             1       72.4351             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_5_Other(4)
            -9             7      -5.25681             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_1_Other(4)
            -9             7      -1.79033             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_2_Other(4)
            -9             7            -1             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_3_Other(4)
            -9             7     -0.824168             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_4_Other(4)
            -9             7     -0.882218             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_5_Other(4)
# 5   PL_CPUE LenSelex
             1             1             1             1            99             0        -99          0          0          0          0        0.5          0          0  #  SizeSel_P1_PL_CPUE(5)
            22            22            22            22            99             0        -99          0          0          0          0        0.5          0          0  #  SizeSel_P2_PL_CPUE(5)
# 6   PSLS_CPUE_LONG LenSelex
             3             3             3             3            99             0        -99          0          0          0          0        0.5          0          0  #  SizeSel_P1_PSLS_CPUE_LONG(6)
            22            22            22            22            99             0        -99          0          0          0          0        0.5          0          0  #  SizeSel_P2_PSLS_CPUE_LONG(6)
# 7   OTHER_CPUE LenSelex
             3             3             3             3            99             0        -99          0          0          0          0        0.5          0          0  #  SizeSel_P1_OTHER_CPUE(7)
            22            22            22            22            99             0        -99          0          0          0          0        0.5          0          0  #  SizeSel_P2_OTHER_CPUE(7)
# 1   PL AgeSelex
             0             8             0             5            99             0        -99          0          0          0          0          0          0          0  #  minage@sel=1_PL(1)
             0             8             8             5            99             0        -99          0          0          0          0          0          0          0  #  maxage@sel=1_PL(1)
# 2   PSLS AgeSelex
             0             8             0             5            99             0        -99          0          0          0          0          0          0          0  #  minage@sel=1_PSLS(2)
             0             8             8             5            99             0        -99          0          0          0          0          0          0          0  #  maxage@sel=1_PSLS(2)
# 3   PSFS AgeSelex
             0             8             0             5            99             0        -99          0          0          0          0          0          0          0  #  minage@sel=1_PSFS(3)
             0             8             8             5            99             0        -99          0          0          0          0          0          0          0  #  maxage@sel=1_PSFS(3)
# 4   Other AgeSelex
             0             8             0             5            99             0        -99          0          0          0          0          0          0          0  #  minage@sel=1_Other(4)
             0             8             8             5            99             0        -99          0          0          0          0          0          0          0  #  maxage@sel=1_Other(4)
# 5   PL_CPUE AgeSelex
             0             8             0             5            99             0        -99          0          0          0          0          0          0          0  #  minage@sel=1_PL_CPUE(5)
             0             8             8             5            99             0        -99          0          0          0          0          0          0          0  #  maxage@sel=1_PL_CPUE(5)
# 6   PSLS_CPUE_LONG AgeSelex
             0             8             0             5            99             0        -99          0          0          0          0          0          0          0  #  minage@sel=1_PSLS_CPUE_LONG(6)
             0             8             8             5            99             0        -99          0          0          0          0          0          0          0  #  maxage@sel=1_PSLS_CPUE_LONG(6)
# 7   OTHER_CPUE AgeSelex
             0             8             0             5            99             0        -99          0          0          0          0          0          0          0  #  minage@sel=1_OTHER_CPUE(7)
             0             8             8             5            99             0        -99          0          0          0          0          0          0          0  #  maxage@sel=1_OTHER_CPUE(7)
#_No_Dirichlet parameters
# timevary selex parameters 
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type    PHASE  #  parm_name
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Knot_1_PL(1)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Knot_1_PL(1)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Knot_2_PL(1)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Knot_2_PL(1)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Knot_3_PL(1)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Knot_3_PL(1)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Knot_4_PL(1)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Knot_4_PL(1)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Knot_5_PL(1)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Knot_5_PL(1)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Knot_6_PL(1)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Knot_6_PL(1)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Knot_7_PL(1)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Knot_7_PL(1)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Val_1_PL(1)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Val_1_PL(1)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Val_2_PL(1)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Val_2_PL(1)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Val_3_PL(1)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Val_3_PL(1)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Val_4_PL(1)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Val_4_PL(1)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Val_5_PL(1)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Val_5_PL(1)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Val_6_PL(1)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Val_6_PL(1)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Val_7_PL(1)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Val_7_PL(1)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Knot_1_PSLS(2)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Knot_1_PSLS(2)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Knot_2_PSLS(2)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Knot_2_PSLS(2)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Knot_3_PSLS(2)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Knot_3_PSLS(2)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Knot_4_PSLS(2)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Knot_4_PSLS(2)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Knot_5_PSLS(2)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Knot_5_PSLS(2)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Val_1_PSLS(2)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Val_1_PSLS(2)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Val_2_PSLS(2)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Val_2_PSLS(2)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Val_3_PSLS(2)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Val_3_PSLS(2)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Val_4_PSLS(2)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Val_4_PSLS(2)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Val_5_PSLS(2)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Val_5_PSLS(2)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Knot_1_PSFS(3)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Knot_1_PSFS(3)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Knot_2_PSFS(3)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Knot_2_PSFS(3)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Knot_3_PSFS(3)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Knot_3_PSFS(3)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Knot_4_PSFS(3)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Knot_4_PSFS(3)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Knot_5_PSFS(3)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Knot_5_PSFS(3)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Val_1_PSFS(3)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Val_1_PSFS(3)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Val_2_PSFS(3)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Val_2_PSFS(3)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Val_3_PSFS(3)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Val_3_PSFS(3)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Val_4_PSFS(3)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Val_4_PSFS(3)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Val_5_PSFS(3)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Val_5_PSFS(3)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Knot_1_Other(4)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Knot_1_Other(4)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Knot_2_Other(4)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Knot_2_Other(4)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Knot_3_Other(4)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Knot_3_Other(4)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Knot_4_Other(4)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Knot_4_Other(4)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Knot_5_Other(4)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Knot_5_Other(4)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Val_1_Other(4)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Val_1_Other(4)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Val_2_Other(4)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Val_2_Other(4)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Val_3_Other(4)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Val_3_Other(4)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Val_4_Other(4)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Val_4_Other(4)_dev_autocorr
        0.0001             2          0.05          0.05           0.5             6      -5  # SizeSpline_Val_5_Other(4)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # SizeSpline_Val_5_Other(4)_dev_autocorr
# info on dev vectors created for selex parms are reported with other devs after tag parameter section 
#
0   #  use 2D_AR1 selectivity? (0/1)
#_no 2D_AR1 selex offset used
#_specs:  fleet, ymin, ymax, amin, amax, sigma_amax, use_rho, len1/age2, devphase, before_range, after_range
#_sigma_amax>amin means create sigma parm for each bin from min to sigma_amax; sigma_amax<0 means just one sigma parm is read and used for all bins
#_needed parameters follow each fleet's specifications
# -9999  0 0 0 0 0 0 0 0 0 0 # terminator
#
# Tag loss and Tag reporting parameters go next
1 # TG_custom:  0=no read and autogen if tag data exist; 1=read
#_Note -  tag parameters cannot be time-varying
#_Note -  phase=-1000 sets parm value to previous parm; phase=-100X sets to parm(X) value
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_1
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_2
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_3
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_4
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_5
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_6
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_7
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_8
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_9
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_10
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_11
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_12
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_13
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_14
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_15
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_16
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_17
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_18
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_19
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_20
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_21
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_22
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_23
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_24
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_25
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_26
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_27
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_28
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_29
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_30
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_31
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_32
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_33
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_34
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_35
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_36
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_37
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_38
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_39
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_40
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_41
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_42
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_43
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_44
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_45
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_46
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_47
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_48
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_49
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_50
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_51
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_52
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_53
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_54
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_55
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_56
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_57
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_58
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_59
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_60
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_61
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_62
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_63
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_64
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_65
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_66
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_67
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_68
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_69
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_70
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_71
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_72
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_73
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_74
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_75
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_76
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_77
 -15 10 -10  -10 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_78
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_1
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_2
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_3
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_4
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_5
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_6
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_7
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_8
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_9
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_10
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_11
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_12
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_13
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_14
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_15
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_16
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_17
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_18
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_19
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_20
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_21
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_22
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_23
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_24
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_25
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_26
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_27
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_28
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_29
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_30
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_31
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_32
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_33
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_34
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_35
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_36
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_37
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_38
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_39
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_40
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_41
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_42
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_43
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_44
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_45
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_46
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_47
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_48
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_49
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_50
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_51
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_52
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_53
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_54
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_55
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_56
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_57
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_58
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_59
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_60
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_61
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_62
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_63
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_64
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_65
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_66
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_67
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_68
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_69
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_70
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_71
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_72
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_73
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_74
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_75
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_76
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_77
 -15 10 -4.185  -4.185 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_78
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_1
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_2
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_3
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_4
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_5
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_6
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_7
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_8
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_9
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_10
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_11
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_12
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_13
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_14
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_15
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_16
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_17
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_18
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_19
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_20
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_21
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_22
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_23
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_24
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_25
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_26
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_27
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_28
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_29
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_30
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_31
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_32
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_33
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_34
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_35
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_36
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_37
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_38
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_39
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_40
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_41
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_42
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_43
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_44
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_45
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_46
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_47
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_48
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_49
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_50
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_51
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_52
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_53
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_54
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_55
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_56
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_57
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_58
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_59
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_60
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_61
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_62
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_63
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_64
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_65
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_66
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_67
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_68
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_69
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_70
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_71
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_72
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_73
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_74
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_75
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_76
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_77
 1 150 20  20 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_78
 -20 20 -2.24279  0 99 1 1 0 0 0 0 0 0 0 # TG_report_fleet:_1
 -20 20 10  10 0.2 1 -4 0 0 0 0 0 0 0 # TG_report_fleet:_2
 -20 20 10  10 0.2 1 -4 0 0 0 0 0 0 0 # TG_report_fleet:_3
 -20 20 -10  -10 2 1 -4 0 0 0 0 0 0 0 # TG_report_fleet:_4
 -4 0 0  0 2 6 -4 0 0 0 0 0 0 0 # TG_rpt_decay_fleet:_1
 -4 0 0  0 2 6 -4 0 0 0 0 0 0 0 # TG_rpt_decay_fleet:_2
 -4 0 0  0 2 6 -4 0 0 0 0 0 0 0 # TG_rpt_decay_fleet:_3
 -4 0 0  0 2 6 -4 0 0 0 0 0 0 0 # TG_rpt_decay_fleet:_4
#
# deviation vectors for timevary parameters
#  base   base first block   block  env  env   dev   dev   dev   dev   dev
#  type  index  parm trend pattern link  var  vectr link _mnyr  mxyr phase  dev_vector
#      1    21     1     0     0     0     0     1     1  1983  2015     5 0.0017706 0.0365871 -0.00668595 0.00562807 0.0266489 0.0333815 0.13729 -0.0181126 0.208508 0.0133782 -0.00508178 0.100858 -0.0735138 -0.0236853 0.120933 -0.0113353 0.125832 0.0529838 -0.20145 0.0872987 -0.0340733 -0.200313 -0.0590603 0.0803071 0.115531 0.423315 -0.0650723 -0.0235975 0.173945 0.0867187 0.0585676 0.0334381 -0.0370022
#      1    22     3     0     0     0     0     2     1  1983  2015     5 -5.3193e-06 1.82328e-05 -9.268e-06 -8.8294e-05 4.88701e-05 -6.82802e-05 4.41988e-05 0.00013006 -0.00032164 0.00021162 3.79049e-05 -0.000177563 0.000191547 -0.000103645 0.000123086 0.000525554 -2.69984e-05 2.10264e-05 0.000508225 -0.000460261 -4.25272e-06 0.0001257 -0.000209338 -0.00020644 -0.000233234 -0.000428183 0.000339099 -0.000288645 -0.000396474 0.000191377 0.000180295 -0.000112448 9.8542e-05
#      1    23     5     0     0     0     0     3     1  1983  2015     5 -0.00307509 0.0325907 -0.00306371 0.0125766 0.00651097 0.0810203 0.109895 -0.0999675 0.319343 -0.0130142 -0.0491943 0.231734 -0.151704 0.105022 0.155743 -0.142753 0.234928 -0.00943842 -0.23889 0.0877448 -0.0430189 -0.276363 -0.0213857 0.101408 0.153545 0.640701 -0.156889 0.0149648 0.185195 0.153681 -0.0552498 0.171417 0.0174871
#      5     4     7     0     0     0     0     4     1  2004  2008    -4      0      0      0      0      0
#      5     5     9     0     0     0     0     5     1  2004  2008    -4      0      0      0      0      0
#      5     6    11     0     0     0     0     6     1  2004  2008    -4      0      0      0      0      0
#      5     7    13     0     0     0     0     7     1  2004  2008    -4      0      0      0      0      0
#      5     8    15     0     0     0     0     8     1  2004  2008    -4      0      0      0      0      0
#      5     9    17     0     0     0     0     9     1  2004  2008    -4      0      0      0      0      0
#      5    10    19     0     0     0     0    10     1  2004  2008    -4      0      0      0      0      0
#      5    11    21     0     0     0     0    11     1  2004  2008    -4      0      0      0      0      0
#      5    12    23     0     0     0     0    12     1  2004  2008    -4      0      0      0      0      0
#      5    13    25     0     0     0     0    13     1  2004  2008    -4      0      0      0      0      0
#      5    14    27     0     0     0     0    14     1  2004  2008    -4      0      0      0      0      0
#      5    15    29     0     0     0     0    15     1  2004  2008    -4      0      0      0      0      0
#      5    16    31     0     0     0     0    16     1  2004  2008    -4      0      0      0      0      0
#      5    17    33     0     0     0     0    17     1  2004  2008    -4      0      0      0      0      0
#      5    21    35     0     0     0     0    18     1  2004  2008    -4      0      0      0      0      0
#      5    22    37     0     0     0     0    19     1  2004  2008    -4      0      0      0      0      0
#      5    23    39     0     0     0     0    20     1  2004  2008    -4      0      0      0      0      0
#      5    24    41     0     0     0     0    21     1  2004  2008    -4      0      0      0      0      0
#      5    25    43     0     0     0     0    22     1  2004  2008    -4      0      0      0      0      0
#      5    26    45     0     0     0     0    23     1  2004  2008    -4      0      0      0      0      0
#      5    27    47     0     0     0     0    24     1  2004  2008    -4      0      0      0      0      0
#      5    28    49     0     0     0     0    25     1  2004  2008    -4      0      0      0      0      0
#      5    29    51     0     0     0     0    26     1  2004  2008    -4      0      0      0      0      0
#      5    30    53     0     0     0     0    27     1  2004  2008    -4      0      0      0      0      0
#      5    34    55     0     0     0     0    28     1  2004  2008    -4      0      0      0      0      0
#      5    35    57     0     0     0     0    29     1  2004  2008    -4      0      0      0      0      0
#      5    36    59     0     0     0     0    30     1  2004  2008    -4      0      0      0      0      0
#      5    37    61     0     0     0     0    31     1  2004  2008    -4      0      0      0      0      0
#      5    38    63     0     0     0     0    32     1  2004  2008    -4      0      0      0      0      0
#      5    39    65     0     0     0     0    33     1  2004  2008    -4      0      0      0      0      0
#      5    40    67     0     0     0     0    34     1  2004  2008    -4      0      0      0      0      0
#      5    41    69     0     0     0     0    35     1  2004  2008    -4      0      0      0      0      0
#      5    42    71     0     0     0     0    36     1  2004  2008    -4      0      0      0      0      0
#      5    43    73     0     0     0     0    37     1  2004  2008    -4      0      0      0      0      0
#      5    47    75     0     0     0     0    38     1  2004  2008    -4      0      0      0      0      0
#      5    48    77     0     0     0     0    39     1  2004  2008    -4      0      0      0      0      0
#      5    49    79     0     0     0     0    40     1  2004  2008    -4      0      0      0      0      0
#      5    50    81     0     0     0     0    41     1  2004  2008    -4      0      0      0      0      0
#      5    51    83     0     0     0     0    42     1  2004  2008    -4      0      0      0      0      0
#      5    52    85     0     0     0     0    43     1  2004  2008    -4      0      0      0      0      0
#      5    53    87     0     0     0     0    44     1  2004  2008    -4      0      0      0      0      0
#      5    54    89     0     0     0     0    45     1  2004  2008    -4      0      0      0      0      0
#      5    55    91     0     0     0     0    46     1  2004  2008    -4      0      0      0      0      0
#      5    56    93     0     0     0     0    47     1  2004  2008    -4      0      0      0      0      0
     #
# Input variance adjustments factors: 
 #_1=add_to_survey_CV
 #_2=add_to_discard_stddev
 #_3=add_to_bodywt_CV
 #_4=mult_by_lencomp_N
 #_5=mult_by_agecomp_N
 #_6=mult_by_size-at-age_N
 #_7=mult_by_generalized_sizecomp
#_Factor  Fleet  Value
      4      1      0.05
      4      2      0.05
      4      3      0.05
      4      4      0.05
 -9999   1    0  # terminator
#
4 #_maxlambdaphase
1 #_sd_offset; must be 1 if any growthCV, sigmaR, or survey extraSD is an estimated parameter
# read 7 changes to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin; 17=F_ballpark; 18=initEQregime
#like_comp fleet  phase  value  sizefreq_method
 1 5 1 1 1
 1 6 1 1 1
 1 7 1 0 1
 4 1 1 1 1
 4 2 1 1 1
 4 3 1 1 1
 4 4 1 1 1
-9999  1  1  1  1  #  terminator
#
# lambdas (for info only; columns are phases)
#  0 0 0 0 #_CPUE/survey:_1
#  0 0 0 0 #_CPUE/survey:_2
#  0 0 0 0 #_CPUE/survey:_3
#  0 0 0 0 #_CPUE/survey:_4
#  1 1 1 1 #_CPUE/survey:_5
#  1 1 1 1 #_CPUE/survey:_6
#  0 0 0 0 #_CPUE/survey:_7
#  1 1 1 1 #_lencomp:_1
#  1 1 1 1 #_lencomp:_2
#  1 1 1 1 #_lencomp:_3
#  1 1 1 1 #_lencomp:_4
#  0 0 0 0 #_lencomp:_5
#  0 0 0 0 #_lencomp:_6
#  0 0 0 0 #_lencomp:_7
#  1 1 1 1 #_init_equ_catch1
#  1 1 1 1 #_init_equ_catch2
#  1 1 1 1 #_init_equ_catch3
#  1 1 1 1 #_init_equ_catch4
#  1 1 1 1 #_init_equ_catch5
#  1 1 1 1 #_init_equ_catch6
#  1 1 1 1 #_init_equ_catch7
#  1 1 1 1 #_recruitments
#  1 1 1 1 #_parameter-priors
#  1 1 1 1 #_parameter-dev-vectors
#  1 1 1 1 #_TG-comp_group:_1
#  1 1 1 1 #_TG-comp_group:_2
#  1 1 1 1 #_TG-comp_group:_3
#  1 1 1 1 #_TG-comp_group:_4
#  1 1 1 1 #_TG-comp_group:_5
#  1 1 1 1 #_TG-comp_group:_6
#  1 1 1 1 #_TG-comp_group:_7
#  1 1 1 1 #_TG-comp_group:_8
#  1 1 1 1 #_TG-comp_group:_9
#  1 1 1 1 #_TG-comp_group:_10
#  1 1 1 1 #_TG-comp_group:_11
#  1 1 1 1 #_TG-comp_group:_12
#  1 1 1 1 #_TG-comp_group:_13
#  1 1 1 1 #_TG-comp_group:_14
#  1 1 1 1 #_TG-comp_group:_15
#  1 1 1 1 #_TG-comp_group:_16
#  1 1 1 1 #_TG-comp_group:_17
#  1 1 1 1 #_TG-comp_group:_18
#  1 1 1 1 #_TG-comp_group:_19
#  1 1 1 1 #_TG-comp_group:_20
#  1 1 1 1 #_TG-comp_group:_21
#  1 1 1 1 #_TG-comp_group:_22
#  1 1 1 1 #_TG-comp_group:_23
#  1 1 1 1 #_TG-comp_group:_24
#  1 1 1 1 #_TG-comp_group:_25
#  1 1 1 1 #_TG-comp_group:_26
#  1 1 1 1 #_TG-comp_group:_27
#  1 1 1 1 #_TG-comp_group:_28
#  1 1 1 1 #_TG-comp_group:_29
#  1 1 1 1 #_TG-comp_group:_30
#  1 1 1 1 #_TG-comp_group:_31
#  1 1 1 1 #_TG-comp_group:_32
#  1 1 1 1 #_TG-comp_group:_33
#  1 1 1 1 #_TG-comp_group:_34
#  1 1 1 1 #_TG-comp_group:_35
#  1 1 1 1 #_TG-comp_group:_36
#  1 1 1 1 #_TG-comp_group:_37
#  1 1 1 1 #_TG-comp_group:_38
#  1 1 1 1 #_TG-comp_group:_39
#  1 1 1 1 #_TG-comp_group:_40
#  1 1 1 1 #_TG-comp_group:_41
#  1 1 1 1 #_TG-comp_group:_42
#  1 1 1 1 #_TG-comp_group:_43
#  1 1 1 1 #_TG-comp_group:_44
#  1 1 1 1 #_TG-comp_group:_45
#  1 1 1 1 #_TG-comp_group:_46
#  1 1 1 1 #_TG-comp_group:_47
#  1 1 1 1 #_TG-comp_group:_48
#  1 1 1 1 #_TG-comp_group:_49
#  1 1 1 1 #_TG-comp_group:_50
#  1 1 1 1 #_TG-comp_group:_51
#  1 1 1 1 #_TG-comp_group:_52
#  1 1 1 1 #_TG-comp_group:_53
#  1 1 1 1 #_TG-comp_group:_54
#  1 1 1 1 #_TG-comp_group:_55
#  1 1 1 1 #_TG-comp_group:_56
#  1 1 1 1 #_TG-comp_group:_57
#  1 1 1 1 #_TG-comp_group:_58
#  1 1 1 1 #_TG-comp_group:_59
#  1 1 1 1 #_TG-comp_group:_60
#  1 1 1 1 #_TG-comp_group:_61
#  1 1 1 1 #_TG-comp_group:_62
#  1 1 1 1 #_TG-comp_group:_63
#  1 1 1 1 #_TG-comp_group:_64
#  1 1 1 1 #_TG-comp_group:_65
#  1 1 1 1 #_TG-comp_group:_66
#  1 1 1 1 #_TG-comp_group:_67
#  1 1 1 1 #_TG-comp_group:_68
#  1 1 1 1 #_TG-comp_group:_69
#  1 1 1 1 #_TG-comp_group:_70
#  1 1 1 1 #_TG-comp_group:_71
#  1 1 1 1 #_TG-comp_group:_72
#  1 1 1 1 #_TG-comp_group:_73
#  1 1 1 1 #_TG-comp_group:_74
#  1 1 1 1 #_TG-comp_group:_75
#  1 1 1 1 #_TG-comp_group:_76
#  1 1 1 1 #_TG-comp_group:_77
#  1 1 1 1 #_TG-comp_group:_78
#  1 1 1 1 #_TG-negbin_group:_1
#  1 1 1 1 #_TG-negbin_group:_2
#  1 1 1 1 #_TG-negbin_group:_3
#  1 1 1 1 #_TG-negbin_group:_4
#  1 1 1 1 #_TG-negbin_group:_5
#  1 1 1 1 #_TG-negbin_group:_6
#  1 1 1 1 #_TG-negbin_group:_7
#  1 1 1 1 #_TG-negbin_group:_8
#  1 1 1 1 #_TG-negbin_group:_9
#  1 1 1 1 #_TG-negbin_group:_10
#  1 1 1 1 #_TG-negbin_group:_11
#  1 1 1 1 #_TG-negbin_group:_12
#  1 1 1 1 #_TG-negbin_group:_13
#  1 1 1 1 #_TG-negbin_group:_14
#  1 1 1 1 #_TG-negbin_group:_15
#  1 1 1 1 #_TG-negbin_group:_16
#  1 1 1 1 #_TG-negbin_group:_17
#  1 1 1 1 #_TG-negbin_group:_18
#  1 1 1 1 #_TG-negbin_group:_19
#  1 1 1 1 #_TG-negbin_group:_20
#  1 1 1 1 #_TG-negbin_group:_21
#  1 1 1 1 #_TG-negbin_group:_22
#  1 1 1 1 #_TG-negbin_group:_23
#  1 1 1 1 #_TG-negbin_group:_24
#  1 1 1 1 #_TG-negbin_group:_25
#  1 1 1 1 #_TG-negbin_group:_26
#  1 1 1 1 #_TG-negbin_group:_27
#  1 1 1 1 #_TG-negbin_group:_28
#  1 1 1 1 #_TG-negbin_group:_29
#  1 1 1 1 #_TG-negbin_group:_30
#  1 1 1 1 #_TG-negbin_group:_31
#  1 1 1 1 #_TG-negbin_group:_32
#  1 1 1 1 #_TG-negbin_group:_33
#  1 1 1 1 #_TG-negbin_group:_34
#  1 1 1 1 #_TG-negbin_group:_35
#  1 1 1 1 #_TG-negbin_group:_36
#  1 1 1 1 #_TG-negbin_group:_37
#  1 1 1 1 #_TG-negbin_group:_38
#  1 1 1 1 #_TG-negbin_group:_39
#  1 1 1 1 #_TG-negbin_group:_40
#  1 1 1 1 #_TG-negbin_group:_41
#  1 1 1 1 #_TG-negbin_group:_42
#  1 1 1 1 #_TG-negbin_group:_43
#  1 1 1 1 #_TG-negbin_group:_44
#  1 1 1 1 #_TG-negbin_group:_45
#  1 1 1 1 #_TG-negbin_group:_46
#  1 1 1 1 #_TG-negbin_group:_47
#  1 1 1 1 #_TG-negbin_group:_48
#  1 1 1 1 #_TG-negbin_group:_49
#  1 1 1 1 #_TG-negbin_group:_50
#  1 1 1 1 #_TG-negbin_group:_51
#  1 1 1 1 #_TG-negbin_group:_52
#  1 1 1 1 #_TG-negbin_group:_53
#  1 1 1 1 #_TG-negbin_group:_54
#  1 1 1 1 #_TG-negbin_group:_55
#  1 1 1 1 #_TG-negbin_group:_56
#  1 1 1 1 #_TG-negbin_group:_57
#  1 1 1 1 #_TG-negbin_group:_58
#  1 1 1 1 #_TG-negbin_group:_59
#  1 1 1 1 #_TG-negbin_group:_60
#  1 1 1 1 #_TG-negbin_group:_61
#  1 1 1 1 #_TG-negbin_group:_62
#  1 1 1 1 #_TG-negbin_group:_63
#  1 1 1 1 #_TG-negbin_group:_64
#  1 1 1 1 #_TG-negbin_group:_65
#  1 1 1 1 #_TG-negbin_group:_66
#  1 1 1 1 #_TG-negbin_group:_67
#  1 1 1 1 #_TG-negbin_group:_68
#  1 1 1 1 #_TG-negbin_group:_69
#  1 1 1 1 #_TG-negbin_group:_70
#  1 1 1 1 #_TG-negbin_group:_71
#  1 1 1 1 #_TG-negbin_group:_72
#  1 1 1 1 #_TG-negbin_group:_73
#  1 1 1 1 #_TG-negbin_group:_74
#  1 1 1 1 #_TG-negbin_group:_75
#  1 1 1 1 #_TG-negbin_group:_76
#  1 1 1 1 #_TG-negbin_group:_77
#  1 1 1 1 #_TG-negbin_group:_78
#  1 1 1 1 #_crashPenLambda
#  1 1 1 1 # F_ballpark_lambda
0 # (0/1/2) read specs for more stddev reporting: 0 = skip, 1 = read specs for reporting stdev for selectivity, size, and numbers, 2 = add options for M,Dyn. Bzero, SmryBio
 # 0 2 0 0 # Selectivity: (1) fleet, (2) 1=len/2=age/3=both, (3) year, (4) N selex bins
 # 0 0 # Growth: (1) growth pattern, (2) growth ages
 # 0 0 0 # Numbers-at-age: (1) area(-1 for all), (2) year, (3) N ages
 # -1 # list of bin #'s for selex std (-1 in first bin to self-generate)
 # -1 # list of ages for growth std (-1 in first bin to self-generate)
 # -1 # list of ages for NatAge std (-1 in first bin to self-generate)
999

