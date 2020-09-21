#V3.30.15.09-safe;_2020_07_06;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_12.0
#Stock Synthesis (SS) is a work of the U.S. Government and is not subject to copyright protection in the United States.
#Foreign copyrights may apply. See copyright.txt for more information.
#_user_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_user_info_available_at:https://vlab.ncep.noaa.gov/group/stock-synthesis
#_data_and_control_files: DATA.SS // CONTROL.SS
0  # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and also read and use growth parameters
1  #_N_Growth_Patterns (Growth Patterns, Morphs, Bio Patterns, GP are terms used interchangeably in SS)
1 #_N_platoons_Within_GrowthPattern 
#_Cond 1 #_Platoon_within/between_stdev_ratio (no read if N_platoons=1)
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
1 #_env/block/dev_adjust_method for all time-vary parms (1=warn relative to base parm bounds; 3=no bound check)
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
#
1 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate
5 #_N_breakpoints
 0 1 2 3 4 # age(real) at M breakpoints
#
2 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specific_K_incr; 4=age_specific_K_decr; 5=age_specific_K_each; 6=NA; 7=NA; 8=growth cessation
0 #_Age(post-settlement)_for_L1;linear growth below this
999 #_Growth_Age_for_L2 (999 to use as Linf)
-999 #_exponential decay for growth above maxage (value should approx initial Z; -999 replicates 3.24; -998 to not allow growth above maxage)
0  #_placeholder for future growth feature
#
0.1 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
#
1 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity
1 #_First_Mature_Age
1 #_fecundity option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn
3 #_parameter_offset_approach (1=none, 2= M, G, CV_G as offset from female-GP1, 3=like SS2 V1.x)
#
#_growth_parms
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env_var&link dev_link dev_minyr dev_maxyr dev_PH Block Block_Fxn
# Sex: 1  BioPattern: 1  NatMort
 0.075 2 0.8 0.8 1 6 -5 0 0 0 0 0.5 0 0 # NatM_p_1_Fem_GP_1
 -3 3 -0 -0 1 6 -7 0 0 0 0 0.5 0 0 # NatM_p_2_Fem_GP_1
 -3 3 -0 -0 1 6 -7 0 0 0 0 0.5 0 0 # NatM_p_3_Fem_GP_1
 -3 3 -0 -0 1 6 -6 0 0 0 0 0.5 0 0 # NatM_p_4_Fem_GP_1
 -3 3 -0 -0 1 6 -6 0 0 0 0 0.5 0 0 # NatM_p_5_Fem_GP_1
# Sex: 1  BioPattern: 1  Growth
 -30 30 5.89629 20 100 6 -5 0 0 0 0 0.5 0 0 # L_at_Amin_Fem_GP_1
 50 100 70.3509 70.2 100 6 -5 0 0 0 0 0.5 0 0 # L_at_Amax_Fem_GP_1
 -3 3 0.34809 0.373 100 6 -1 0 0 0 0 0.5 0 0 # VonBert_K_Fem_GP_1
 0 5 2.9096 1 1 0 -5 0 0 0 0 0 0 0 # Richards_Fem_GP_1
 0.01 60 0.2 0.2 100 6 -5 0 0 0 0 0.5 0 0 # CV_young_Fem_GP_1
 -3 3 -0.69 -0.69 100 6 -5 0 0 0 0 0.5 0 0 # CV_old_Fem_GP_1
# Sex: 1  BioPattern: 1  WtLen
 -3 3 4.97e-006 4.97e-006 100 6 -1 0 0 0 0 0.5 0 0 # Wtlen_1_Fem_GP_1
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
 -4 4 0.194141 0 0.1 6 5 0 1 1983 2015 5 0 0 # RecrDist_month_4
 -4 4 0.000414284 0 0.1 6 5 0 1 1983 2015 5 0 0 # RecrDist_month_7
 -4 4 -0.217428 0 0.1 6 5 0 1 1983 2015 5 0 0 # RecrDist_month_10
#  Cohort growth dev base
 0.1 10 1 1 1 6 -1 0 0 0 0 0.5 0 0 # CohortGrowDev
#  Movement
#  Age Error from parameters
#  catch multiplier
#  fraction female, by GP
 1e-006 0.999999 0.5 0.5 0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_1
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
1983 # first year of main recr_devs; early devs can preceed this era
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
 2015 #_end_yr_for_ramp_in_MPD (can be in forecast to shape ramp, but SS sets bias_adj to 0.0 for fcast yrs)
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
#  0.0562867 0.535069 -0.142965 -0.256349 0.584876 -0.337203 0.13611 0.290114 0.173785 0.0154481 0.250065 0.0579503 -0.0841045 -0.210611 -0.155116 0.480005 0.0904223 -0.0812844 0.460669 -0.0127616 0.0713423 0.45172 0.0310611 -0.762371 -0.0171706 0.0964535 -0.0709576 -0.336924 -0.571066 -0.146392 -0.0641352 -0.531966 0 0 0 0 0 0 0 0 0 0 0 0
# implementation error by year in forecast:  0 0 0 0 0 0 0 0 0 0
#
#Fishing Mortality info 
0.15 # F ballpark value in units of annual_F
2000 # F ballpark year (neg value to disable)
3 # F_Method:  1=Pope; 2=instan. F; 3=hybrid (hybrid is recommended)
7 # max F or harvest rate, depends on F_Method
# no additional F input needed for Fmethod 1
# if Fmethod=2; read overall start F value; overall phase; N detailed inputs to read
# if Fmethod=3; read N iterations for tuning for Fmethod 3
5  # N iterations for tuning F in hybrid method (recommend 3 to 7)
#
#_initial_F_parms; count = 0
#_ LO HI INIT PRIOR PR_SD  PR_type  PHASE
#2026 2421
# F rates by fleet
# Yr:  1950 1950 1950 1950 1951 1951 1951 1951 1952 1952 1952 1952 1953 1953 1953 1953 1954 1954 1954 1954 1955 1955 1955 1955 1956 1956 1956 1956 1957 1957 1957 1957 1958 1958 1958 1958 1959 1959 1959 1959 1960 1960 1960 1960 1961 1961 1961 1961 1962 1962 1962 1962 1963 1963 1963 1963 1964 1964 1964 1964 1965 1965 1965 1965 1966 1966 1966 1966 1967 1967 1967 1967 1968 1968 1968 1968 1969 1969 1969 1969 1970 1970 1970 1970 1971 1971 1971 1971 1972 1972 1972 1972 1973 1973 1973 1973 1974 1974 1974 1974 1975 1975 1975 1975 1976 1976 1976 1976 1977 1977 1977 1977 1978 1978 1978 1978 1979 1979 1979 1979 1980 1980 1980 1980 1981 1981 1981 1981 1982 1982 1982 1982 1983 1983 1983 1983 1984 1984 1984 1984 1985 1985 1985 1985 1986 1986 1986 1986 1987 1987 1987 1987 1988 1988 1988 1988 1989 1989 1989 1989 1990 1990 1990 1990 1991 1991 1991 1991 1992 1992 1992 1992 1993 1993 1993 1993 1994 1994 1994 1994 1995 1995 1995 1995 1996 1996 1996 1996 1997 1997 1997 1997 1998 1998 1998 1998 1999 1999 1999 1999 2000 2000 2000 2000 2001 2001 2001 2001 2002 2002 2002 2002 2003 2003 2003 2003 2004 2004 2004 2004 2005 2005 2005 2005 2006 2006 2006 2006 2007 2007 2007 2007 2008 2008 2008 2008 2009 2009 2009 2009 2010 2010 2010 2010 2011 2011 2011 2011 2012 2012 2012 2012 2013 2013 2013 2013 2014 2014 2014 2014 2015 2015 2015 2015 2016 2016 2016 2016 2017 2017 2017 2017 2018 2018 2018 2018 2019 2019 2019 2019 2020 2020 2020 2020 2021 2021 2021 2021 2022 2022 2022 2022 2023 2023 2023 2023 2024 2024 2024 2024 2025 2025 2025 2025 2026 2026 2026 2026
# seas:  1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4
# PL 0.00954188 0.00958989 0.0095879 0.00955901 0.00957989 0.00962759 0.0096247 0.00959455 0.00961289 0.00965669 0.00964982 0.00961594 0.0108356 0.010883 0.0108734 0.0108336 0.01085 0.0108964 0.0108859 0.0108451 0.0108604 0.0109056 0.010894 0.0108525 0.0108676 0.0109127 0.0109011 0.0108594 0.0120829 0.0121343 0.0121222 0.0120767 0.0120933 0.0121426 0.0121285 0.0120807 0.0120961 0.0121451 0.0121307 0.0120827 0.0105975 0.0136829 0.0110563 0.00829913 0.0105681 0.0127641 0.00807046 0.00737491 0.0108399 0.0123358 0.00839524 0.00722064 0.0111935 0.0116922 0.00851738 0.00742908 0.0112093 0.011708 0.00852843 0.00743843 0.0197913 0.020679 0.0150716 0.0131496 0.0237953 0.0248701 0.0181291 0.01582 0.0267117 0.0279113 0.0203453 0.0177477 0.0248042 0.025912 0.0188772 0.0164659 0.0278314 0.0290757 0.0211822 0.0184724 0.0306495 0.0181105 0.0442503 0.043146 0.031475 0.0312934 0.0332393 0.0425656 0.0316617 0.0183772 0.0213934 0.0151203 0.0295736 0.0158251 0.0221381 0.0292091 0.0236593 0.0375494 0.0233799 0.0274955 0.0180787 0.0233384 0.0188568 0.0141503 0.0276571 0.0317856 0.0156281 0.0176551 0.0202275 0.0198665 0.0161035 0.0120302 0.0211131 0.0156659 0.0150928 0.0137749 0.0228494 0.0228184 0.0177402 0.0226185 0.0315846 0.0271467 0.0253066 0.0266707 0.028267 0.0230094 0.024911 0.0221749 0.0184655 0.0245009 0.0199287 0.01389 0.0292608 0.0299473 0.0173502 0.0206464 0.038797 0.0299892 0.0339594 0.0552499 0.0543381 0.0409389 0.032398 0.0633602 0.0563673 0.0400732 0.0450735 0.0713734 0.0676567 0.0661465 0.0450498 0.0407968 0.0911254 0.0483753 0.0536158 0.0956245 0.0882924 0.0727622 0.0676311 0.0748301 0.0814606 0.0587405 0.0773598 0.115663 0.0541419 0.0869151 0.0849975 0.0840934 0.0745756 0.0906398 0.0485853 0.0934823 0.074665 0.0791311 0.079203 0.0909658 0.105573 0.0994958 0.102857 0.0862114 0.114046 0.0901137 0.0713748 0.1517 0.117387 0.12776 0.0964248 0.102645 0.118081 0.124124 0.139396 0.140097 0.17471 0.129784 0.126952 0.193131 0.164463 0.176988 0.168173 0.133238 0.156968 0.121377 0.128987 0.116663 0.154503 0.117692 0.139724 0.181689 0.196694 0.170454 0.174346 0.20278 0.194803 0.184046 0.154661 0.202299 0.227138 0.136008 0.166056 0.211054 0.195809 0.231898 0.190902 0.259093 0.264753 0.334434 0.159476 0.263582 0.279921 0.245052 0.173068 0.303207 0.19467 0.212916 0.268282 0.301368 0.166006 0.16393 0.145476 0.212269 0.205513 0.163345 0.17807 0.194367 0.20557 0.117494 0.119575 0.159531 0.114626 0.161408 0.128669 0.273227 0.144455 0.203542 0.252073 0.359487 0.212633 0.329134 0.148873 0.201242 0.306693 0.2729 0.117631 0.257751 0.188806 0.204248 0.117454 0.33821 0.352693 0.303643 0.129717 0.292171 0.336481 0.291089 0.125067 0.282952 0.326973 0.2838 0.122343 0.277475 0.321251 0.279368 0.120673 0.274102 0.317717 0.276624 0.119638 0.272008 0.315521 0.274917 0.118993 0.270703 0.314152 0.273853 0.118591 0.269888 0.313297 0.273188 0.11834 0.269379 0.312763 0.272772 0.118182 0.269061 0.312429 0.272512 0.118084 0.268862
# PSLS 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000542733 0 0 0 0.00122363 0.000197684 0 0.00160043 0.00708963 0.0069273 0.0033121 0.0123 0.0049922 0.0157735 0.0387239 0.0451657 0.0128127 0.0205486 0.0547661 0.0721137 0.0224203 0.0394748 0.063607 0.0694395 0.0381757 0.0625039 0.0709457 0.0514977 0.0190373 0.0356928 0.108284 0.0735277 0.0382909 0.0383319 0.115019 0.126309 0.0485031 0.0631103 0.0986201 0.0842043 0.0223616 0.0662275 0.0967862 0.143945 0.0575462 0.0976295 0.109057 0.134107 0.0675845 0.0959793 0.141334 0.137699 0.063098 0.0862593 0.183879 0.171182 0.124116 0.1363 0.187588 0.184693 0.0841075 0.101984 0.168908 0.24571 0.144167 0.1277 0.19032 0.26266 0.224013 0.120068 0.179544 0.177871 0.100178 0.117223 0.237977 0.217372 0.116859 0.141058 0.244676 0.311875 0.128839 0.101555 0.311499 0.22051 0.14376 0.117302 0.344955 0.265545 0.213737 0.0870242 0.251365 0.357779 0.127219 0.0773358 0.212167 0.260112 0.129862 0.106215 0.239265 0.226272 0.119894 0.0761775 0.415427 0.555638 0.157487 0.14734 0.394745 0.243163 0.0763444 0.173178 0.312742 0.292005 0.244691 0.121501 0.322902 0.203078 0.258557 0.161201 0.316942 0.236176 0.291303 0.169923 0.235043 0.311384 0.27746 0.117986 0.192711 0.158247 0.286902 0.162259 0.212043 0.317374 0.314102 0.103794 0.331615 0.23557 0.330488 0.175304 0.295573 0.289523 0.347056 0.227097 0.408033 0.31702 0.349737 0.17506 0.299521 0.324733 0.341522 0.17138 0.294005 0.319349 0.336318 0.169043 0.290543 0.315999 0.333096 0.1676 0.288403 0.313927 0.331102 0.166705 0.287075 0.312639 0.329863 0.166149 0.286248 0.311838 0.329091 0.165802 0.285732 0.311337 0.328609 0.165585 0.28541 0.311025 0.328308 0.16545 0.285209 0.310829 0.328119 0.165365 0.285083 0.310707
# PSFS 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 5.17164e-005 0 0 4.28592e-005 3.96541e-005 9.20538e-006 0 0.000208623 0.00106457 0.000129301 2.78133e-005 0.00372455 0.00581372 0.00320192 0.00323721 0.0160288 0.0104382 0.00692386 0.00227892 0.006937 0.010282 0.0286531 0.0090851 0.00651339 0.00433125 0.014976 0.0278289 0.0376955 0.011086 0.00917219 0.00317683 0.0355441 0.0668773 0.0560431 0.0242396 0.00542335 0.0360655 0.0230044 0.00447873 0.00727534 0.0073816 0.0132636 0.0103291 0.00620191 0.0173465 0.0194375 0.00753427 0.0151691 0.0141778 0.0472536 0.015989 0.0153651 0.0183283 0.056523 0.0147671 0.0385859 0.0349819 0.030799 0.0166913 0.0174983 0.0471979 0.0481484 0.0114452 0.0171674 0.0248517 0.0183013 0.0144575 0.027046 0.0300958 0.0474463 0.0162348 0.0123682 0.057802 0.0345478 0.00806202 0.01939 0.0227551 0.0478449 0.0120848 0.0106207 0.0248021 0.0281356 0.0100671 0.0417794 0.0112875 0.0179756 0.00927705 0.0266813 0.0364193 0.0182607 0.0187442 0.0462734 0.0256947 0.0148028 0.0115512 0.0220855 0.0231359 0.0613523 0.0274833 0.0397925 0.0159382 0.0779075 0.0145031 0.0258073 0.0273811 0.0785462 0.0229139 0.0194057 0.0226724 0.0514959 0.00577796 0.0130201 0.0232067 0.0137372 0.00766884 0.00745935 0.0184816 0.0164471 0.00209589 0.0104554 0.0154636 0.0244058 0.00440851 0.0121685 0.010159 0.00447084 0.00304283 0.0040213 0.00742886 0.0154577 0.00794121 0.00856427 0.0125372 0.0118438 0.00865888 0.0108238 0.0183779 0.011398 0.0153674 0.0111881 0.0158828 0.0145432 0.00631628 0.00547837 0.0205116 0.011994 0.0157578 0.0121998 0.0198043 0.0116322 0.0153498 0.0119191 0.0193916 0.0114159 0.0151031 0.0117483 0.0191392 0.0112831 0.0149511 0.0116427 0.018983 0.0112008 0.0148568 0.0115772 0.018886 0.0111497 0.0147981 0.0115364 0.0188256 0.0111178 0.0147614 0.0115109 0.0187878 0.0110979 0.0147386 0.011495 0.0187642 0.0110854 0.0147243 0.011485 0.0187495 0.0110776 0.0147153 0.0114788
# Other 0.00193872 0.00194429 0.00194844 0.00194676 0.00389807 0.00390892 0.00391684 0.00391293 0.00375132 0.00376014 0.00376626 0.00381352 0.0036672 0.00366138 0.00366679 0.0037414 0.00413524 0.00436505 0.00418573 0.00413493 0.00426052 0.00440452 0.00437429 0.00453035 0.00486829 0.00474498 0.00516982 0.00459121 0.0053496 0.00523599 0.00524322 0.00539288 0.00473423 0.00485685 0.00457409 0.00465475 0.00480436 0.00507123 0.00464983 0.00464712 0.00562699 0.0054244 0.00510081 0.00521566 0.00580669 0.00579023 0.00593589 0.00625959 0.00777788 0.00735669 0.00739186 0.0077781 0.00925859 0.0093249 0.00911669 0.00932392 0.00992586 0.00988197 0.0098102 0.0101913 0.0100712 0.010134 0.00981024 0.010008 0.0116872 0.0119314 0.0116013 0.0117397 0.0122215 0.0121301 0.0119884 0.0121609 0.0130131 0.0129943 0.0127817 0.013065 0.0134673 0.0129603 0.0132386 0.0135218 0.0110522 0.0110724 0.0133501 0.0117682 0.00975358 0.0100043 0.0114914 0.010007 0.012475 0.0130045 0.0148492 0.0134732 0.0183707 0.0191358 0.0204768 0.0185107 0.0242787 0.0240654 0.0252938 0.0239098 0.0199784 0.0209886 0.0229395 0.0208073 0.0218741 0.0235784 0.0267573 0.0241378 0.0230103 0.0248313 0.0292684 0.0259114 0.0219629 0.0203009 0.0246153 0.0250827 0.0190844 0.032193 0.0202902 0.0205577 0.0235157 0.0219613 0.0258783 0.024289 0.0228825 0.0211831 0.0443457 0.0234929 0.0324449 0.0311071 0.0360944 0.0335394 0.0292964 0.0272908 0.0341597 0.0307082 0.0291942 0.0260347 0.0330475 0.033847 0.0301369 0.0258425 0.0292882 0.0301475 0.0248089 0.031686 0.0382399 0.0353404 0.0439157 0.0434512 0.0441337 0.048577 0.0494599 0.0388426 0.0431029 0.0517579 0.0784949 0.0404738 0.0514088 0.055091 0.0815378 0.0600949 0.0652183 0.0485377 0.0694373 0.063102 0.077944 0.0801985 0.10162 0.0945201 0.0854689 0.0668657 0.108473 0.108225 0.112096 0.0897317 0.105279 0.100869 0.108355 0.108354 0.104905 0.0938871 0.102393 0.100582 0.110266 0.100057 0.118965 0.114842 0.134555 0.13741 0.15045 0.146193 0.161353 0.138653 0.144012 0.124393 0.177825 0.138955 0.13824 0.123948 0.154903 0.124887 0.139604 0.131119 0.153427 0.128564 0.155005 0.140454 0.174862 0.111361 0.142018 0.136751 0.187493 0.134095 0.156414 0.155414 0.24368 0.171918 0.19113 0.191713 0.243762 0.201118 0.20118 0.203575 0.259124 0.247745 0.260231 0.306002 0.323416 0.342154 0.370193 0.41207 0.379961 0.353625 0.352001 0.351397 0.354157 0.324157 0.322977 0.333081 0.309012 0.278645 0.279952 0.302514 0.342775 0.31406 0.312887 0.329638 0.378931 0.382583 0.387873 0.410276 0.443547 0.445193 0.443287 0.455615 0.522071 0.398917 0.378387 0.369133 0.437965 0.365361 0.408994 0.360928 0.393908 0.338589 0.329816 0.321243 0.506923 0.404324 0.435592 0.393365 0.484842 0.388747 0.421133 0.381779 0.471941 0.379492 0.412423 0.374737 0.464052 0.373808 0.407052 0.370384 0.45917 0.370285 0.403718 0.36768 0.456135 0.368094 0.401642 0.365995 0.454242 0.366726 0.400346 0.364942 0.45306 0.365872 0.399536 0.364284 0.452321 0.365339 0.39903 0.363873 0.451859 0.365005 0.398713 0.363616
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
           -25            25      -10.6735             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_PL_CPUE(5)
           -25            25      -11.1926             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_PSLS_CPUE_LONG(6)
           -25            25      -7.47079             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_OTHER_CPUE(7)
#_no timevary Q parameters
#
#_size_selex_patterns
#Pattern:_0;  parm=0; selex=1.0 for all sizes
#Pattern:_1;  parm=2; logistic; with 95% width specification
#Pattern:_5;  parm=2; mirror another size selex; PARMS pick the min-max bin to mirror
#Pattern:_11; parm=2; selex=1.0  for specified min-max population length bin range
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_6;  parm=2+special; non-parm len selex
#Pattern:_43; parm=2+special+2;  like 6, with 2 additional param for scaling (average over bin range)
#Pattern:_8;  parm=8; double_logistic with smooth transitions and constant above Linf option
#Pattern:_9;  parm=6; simple 4-parm double logistic with starting length; parm 5 is first length; parm 6=1 does desc as offset
#Pattern:_21; parm=2+special; non-parm len selex, read as pairs of size, then selex
#Pattern:_22; parm=4; double_normal as in CASAL
#Pattern:_23; parm=6; double_normal where final value is directly equal to sp(6) so can be >1.0
#Pattern:_24; parm=6; double_normal with sel(minL) and sel(maxL), using joiners
#Pattern:_25; parm=3; exponential-logistic in size
#Pattern:_27; parm=3+special; cubic spline 
#Pattern:_42; parm=2+special+3; // like 27, with 2 additional param for scaling (average over bin range)
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
#Pattern:_13; parm=8; age double logistic
#Pattern:_14; parm=nages+1; age empirical
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_16; parm=2; Coleraine - Gaussian
#Pattern:_17; parm=nages+1; empirical as random walk  N parameters to read can be overridden by setting special to non-zero
#Pattern:_41; parm=2+nages+1; // like 17, with 2 additional param for scaling (average over bin range)
#Pattern:_18; parm=8; double logistic - smooth transition
#Pattern:_19; parm=6; simple 4-parm double logistic with starting age
#Pattern:_20; parm=6; double_normal,using joiners
#Pattern:_26; parm=3; exponential-logistic in age
#Pattern:_27; parm=3+special; cubic spline in age
#Pattern:_42; parm=2+special+3; // cubic spline; with 2 additional param for scaling (average over bin range)
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
             1             1             1             1            99             1         -3          0          0          0          0        0.5          0          0  #  SizeSel_P1_PL_CPUE(5)
            22            22            22            22            99             1         -3          0          0          0          0        0.5          0          0  #  SizeSel_P2_PL_CPUE(5)
# 6   PSLS_CPUE_LONG LenSelex
             3             3             3             3            99             3         -3          0          0          0          0        0.5          0          0  #  SizeSel_P1_PSLS_CPUE_LONG(6)
            22            22            22            22            99             1         -3          0          0          0          0        0.5          0          0  #  SizeSel_P2_PSLS_CPUE_LONG(6)
# 7   OTHER_CPUE LenSelex
             3             3             3             3            99             3         -3          0          0          0          0        0.5          0          0  #  SizeSel_P1_OTHER_CPUE(7)
            22            22            22            22            99             1         -3          0          0          0          0        0.5          0          0  #  SizeSel_P2_OTHER_CPUE(7)
# 1   PL AgeSelex
             0             8             0             5            99             0         -1          0          0          0          0          0          0          0  #  minage@sel=1_PL(1)
             0             8             8             5            99             0         -1          0          0          0          0          0          0          0  #  maxage@sel=1_PL(1)
# 2   PSLS AgeSelex
             0             8             0             5            99             0         -1          0          0          0          0          0          0          0  #  minage@sel=1_PSLS(2)
             0             8             8             5            99             0         -1          0          0          0          0          0          0          0  #  maxage@sel=1_PSLS(2)
# 3   PSFS AgeSelex
             0             8             0             5            99             0         -1          0          0          0          0          0          0          0  #  minage@sel=1_PSFS(3)
             0             8             8             5            99             0         -1          0          0          0          0          0          0          0  #  maxage@sel=1_PSFS(3)
# 4   Other AgeSelex
             0             8             0             5            99             0         -1          0          0          0          0          0          0          0  #  minage@sel=1_Other(4)
             0             8             8             5            99             0         -1          0          0          0          0          0          0          0  #  maxage@sel=1_Other(4)
# 5   PL_CPUE AgeSelex
             0             8             0             5            99             0         -1          0          0          0          0          0          0          0  #  minage@sel=1_PL_CPUE(5)
             0             8             8             5            99             0         -1          0          0          0          0          0          0          0  #  maxage@sel=1_PL_CPUE(5)
# 6   PSLS_CPUE_LONG AgeSelex
             0             8             0             5            99             0         -1          0          0          0          0          0          0          0  #  minage@sel=1_PSLS_CPUE_LONG(6)
             0             8             8             5            99             0         -1          0          0          0          0          0          0          0  #  maxage@sel=1_PSLS_CPUE_LONG(6)
# 7   OTHER_CPUE AgeSelex
             0             8             0             5            99             0         -1          0          0          0          0          0          0          0  #  minage@sel=1_OTHER_CPUE(7)
             0             8             8             5            99             0         -1          0          0          0          0          0          0          0  #  maxage@sel=1_OTHER_CPUE(7)
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
0   #  use 2D_AR1 selectivity(0/1)
#_no 2D_AR1 selex offset used
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
#      1    21     1     0     0     0     0     1     1  1983  2015     5 0.00177066 0.0365861 -0.00668639 0.00562898 0.0266492 0.0333802 0.137283 -0.0181117 0.208503 0.0133799 -0.00508191 0.100864 -0.0735157 -0.023685 0.120938 -0.011335 0.125839 0.0529808 -0.201448 0.0872988 -0.034074 -0.200311 -0.0590631 0.0803083 0.115533 0.423315 -0.0650736 -0.0235959 0.173951 0.0867132 0.0585632 0.033439 -0.0370025
#      1    22     3     0     0     0     0     2     1  1983  2015     5 -5.33046e-006 1.82143e-005 -9.2119e-006 -8.81219e-005 4.86966e-005 -6.82954e-005 4.41577e-005 0.000130121 -0.00032147 0.000211543 3.77331e-005 -0.000177536 0.000191547 -0.000103294 0.000123061 0.000525742 -2.66929e-005 2.06096e-005 0.000508705 -0.000459804 -4.12309e-006 0.000126272 -0.000209602 -0.00020658 -0.000232468 -0.000428379 0.000339417 -0.000287966 -0.000396314 0.000191133 0.000180413 -0.000112234 9.84696e-005
#      1    23     5     0     0     0     0     3     1  1983  2015     5 -0.00307553 0.0325917 -0.00306376 0.0125782 0.00651072 0.0810215 0.109898 -0.0999655 0.319341 -0.0130135 -0.0491963 0.231731 -0.151706 0.105024 0.155748 -0.142751 0.234927 -0.00943744 -0.238891 0.0877388 -0.0430204 -0.276363 -0.0213866 0.101408 0.15354 0.640703 -0.156894 0.0149675 0.185195 0.153675 -0.0552511 0.171417 0.0174886
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
0 # (0/1/2) read specs for more stddev reporting: 0 = skip, 1 = read specs for reporting stdev for selectivity, size, and numbers, 2 = add options for M and Dyn Bzero
 # 0 2 0 0 # Selectivity: (1) fleet, (2) 1=len/2=age/3=both, (3) year, (4) N selex bins
 # 0 0 # Growth: (1) growth pattern, (2) growth ages
 # 0 0 0 # Numbers-at-age: (1) area(-1 for all), (2) year, (3) N ages
 # -1 # list of bin #'s for selex std (-1 in first bin to self-generate)
 # -1 # list of ages for growth std (-1 in first bin to self-generate)
 # -1 # list of ages for NatAge std (-1 in first bin to self-generate)
999

