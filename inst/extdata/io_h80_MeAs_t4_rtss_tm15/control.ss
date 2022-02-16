#V3.30.16.02;_2020_09_21;_safe;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_12.2
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
3 #_parameter_offset_approach for M, G, CV_G:  1- direct, no offset; 2- male=fem_parm*exp(male_parm); 3: male=female*exp(parm) then old=young*exp(parm)
#
#_growth_parms
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env_var&link dev_link dev_minyr dev_maxyr dev_PH Block Block_Fxn
# Sex: 1  BioPattern: 1  NatMort
 0.075 2 2 0.8 1 6 5 0 0 0 0 0.5 0 0 # NatM_p_1_Fem_GP_1
 -5 3 -1.15208 -0 1 6 7 0 0 0 0 0.5 0 0 # NatM_p_2_Fem_GP_1
 -5 3 -0.169869 -0 1 6 7 0 0 0 0 0.5 0 0 # NatM_p_3_Fem_GP_1
 -5 3 0.47245 -0 1 6 6 0 0 0 0 0.5 0 0 # NatM_p_4_Fem_GP_1
 -5 3 0.36552 -0 1 6 6 0 0 0 0 0.5 0 0 # NatM_p_5_Fem_GP_1
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
 -4 4 0.223531 0 0.1 6 5 0 1 1983 2015 5 0 0 # RecrDist_month_4
 -4 4 0.0420975 0 0.1 6 5 0 1 1983 2015 5 0 0 # RecrDist_month_7
 -4 4 -0.234103 0 0.1 6 5 0 1 1983 2015 5 0 0 # RecrDist_month_10
#  Cohort growth dev base
 0.1 10 1 1 1 6 -1 0 0 0 0 0.5 0 0 # CohortGrowDev
#  Movement
#  Age Error from parameters
#  catch multiplier
#  fraction female, by GP
 1e-06 0.999999 0.5 0.5 0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_1
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
             0            35       13.9691            20            10             6          1          0          0          0          0          0          0          0 # SR_LN(R0)
         0.201          0.99           0.8           0.8            10             6         -2          0          0          0          0          0          0          0 # SR_BH_flat_steep
             0            10      0.278739           0.6            10             6          6          0          0          0          0          0          0          0 # SR_sigmaR
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
#  0.0764596 0.446507 -0.242484 -0.274434 0.538837 -0.349796 0.0706121 0.272866 0.139161 -0.0313906 0.216416 0.0293445 -0.11953 -0.204011 -0.161717 0.513342 0.065247 -0.0753736 0.447463 -0.0424284 0.0842098 0.45754 0.0329518 -0.64224 0.0206204 0.118742 -0.0833305 -0.282966 -0.510148 -0.0778395 -0.00215001 -0.430482 0 0 0 0 0 0 0 0 0 0 0 0
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
# PL 0.0102381 0.0102951 0.0102794 0.0102445 0.0102819 0.0103385 0.0103214 0.0102849 0.0103191 0.0103708 0.0103486 0.0103074 0.0116306 0.0116862 0.0116589 0.0116106 0.011644 0.0116986 0.0116706 0.0116214 0.0116538 0.0117073 0.0116781 0.0116283 0.0116607 0.0117141 0.0116851 0.0116351 0.0129642 0.0130251 0.0129938 0.0129393 0.0129752 0.0130339 0.0130001 0.0129431 0.0129775 0.0130359 0.0130019 0.0129444 0.0113692 0.014686 0.0118501 0.0088908 0.0113373 0.0136994 0.0086496 0.0079005 0.0116289 0.01324 0.00899804 0.00773567 0.0120091 0.0125503 0.00912982 0.00795978 0.0120272 0.0125683 0.00914225 0.00797018 0.0212367 0.0222006 0.0161581 0.0140912 0.0255361 0.0267038 0.0194389 0.0169553 0.0286697 0.0299724 0.0218167 0.019022 0.0266224 0.027824 0.0202405 0.0176459 0.0298674 0.0312171 0.0227091 0.0197939 0.0328879 0.0194409 0.0474334 0.0462331 0.0337758 0.033595 0.035632 0.0456097 0.0339751 0.0197278 0.022931 0.0161985 0.0317272 0.0169856 0.0237275 0.0312934 0.0253859 0.0403136 0.0250681 0.0294695 0.0194047 0.0250604 0.0202182 0.0151637 0.0296785 0.0341244 0.0167535 0.0189168 0.021703 0.0213246 0.0172605 0.0128886 0.0226512 0.0168137 0.0161742 0.0147546 0.0245087 0.0244878 0.0190112 0.0242271 0.0338809 0.0291355 0.0271227 0.0285734 0.0303287 0.024699 0.026705 0.023764 0.0198177 0.0263088 0.0213695 0.014888 0.0314097 0.032147 0.0185759 0.022066 0.0414784 0.0320882 0.0364686 0.0598594 0.0595629 0.0453414 0.0360976 0.0708488 0.0631664 0.0448669 0.0503111 0.0795764 0.0756507 0.0742141 0.0508311 0.0465512 0.105472 0.0566381 0.062966 0.111851 0.102428 0.0833048 0.0763805 0.0839521 0.0915307 0.0662534 0.0875704 0.131737 0.0620979 0.100036 0.097684 0.0963708 0.085263 0.103232 0.0550193 0.105451 0.0842107 0.0892555 0.0893613 0.102995 0.120348 0.114141 0.118394 0.0994825 0.13197 0.1043 0.0823719 0.174807 0.135414 0.147407 0.111023 0.118147 0.1363 0.143478 0.161022 0.162131 0.203271 0.150509 0.145738 0.220698 0.188258 0.203023 0.192456 0.151771 0.177856 0.136416 0.143487 0.128938 0.170475 0.129493 0.153778 0.201633 0.221088 0.19375 0.199545 0.233262 0.224862 0.211714 0.176365 0.230015 0.258969 0.154758 0.188146 0.239622 0.223754 0.266345 0.219194 0.296775 0.302652 0.381103 0.180572 0.29699 0.314277 0.27304 0.191731 0.336865 0.218256 0.240618 0.304763 0.344772 0.191684 0.19007 0.168603 0.246409 0.239732 0.19095 0.207412 0.225829 0.239334 0.137007 0.13879 0.184516 0.132684 0.186024 0.146882 0.31068 0.164941 0.232969 0.287478 0.409952 0.244028 0.378832 0.170298 0.228197 0.345966 0.306072 0.131449 0.290234 0.216408 0.238023 0.138416 0.403951 0.431171 0.375458 0.160553 0.365329 0.427894 0.372434 0.159446 0.363254 0.425859 0.370931 0.158882 0.36204 0.424444 0.369733 0.158404 0.361005 0.423278 0.368781 0.158034 0.360219 0.422396 0.368062 0.157754 0.359622 0.421726 0.367516 0.157541 0.359168 0.421216 0.367099 0.157378 0.358822 0.420828 0.366782 0.157255 0.358558 0.420532 0.366541 0.157161 0.358358
# PSLS 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000614689 0 0 0 0.0013863 0.000224188 0 0.00180878 0.0080347 0.00785242 0.00373477 0.0138164 0.00560769 0.0177405 0.0440145 0.052488 0.0152405 0.0248519 0.0665938 0.0875258 0.0271361 0.0475577 0.0759327 0.0822485 0.0451025 0.0735546 0.0836388 0.0616289 0.0231858 0.0439787 0.133236 0.0893693 0.0458885 0.0452772 0.134722 0.148832 0.0579814 0.0761302 0.118908 0.101513 0.027012 0.0799878 0.116389 0.172542 0.0690297 0.117163 0.130463 0.160141 0.0809127 0.115023 0.169133 0.16531 0.0763121 0.104903 0.223529 0.207728 0.15078 0.16566 0.227266 0.223464 0.102043 0.123885 0.204157 0.295537 0.173335 0.153392 0.227959 0.315258 0.271023 0.1448 0.213867 0.211585 0.119888 0.141063 0.286548 0.261204 0.140364 0.169111 0.291136 0.368747 0.152111 0.119324 0.365417 0.261466 0.172989 0.142739 0.421583 0.324658 0.261651 0.106148 0.303303 0.429662 0.153115 0.0927087 0.252608 0.310702 0.156499 0.128924 0.290293 0.273222 0.144415 0.0916818 0.4958 0.653552 0.182511 0.167967 0.447436 0.279374 0.0894365 0.20554 0.373795 0.352294 0.299112 0.149741 0.398903 0.251769 0.323007 0.202264 0.394801 0.290981 0.357026 0.20763 0.284523 0.373783 0.332704 0.140765 0.227643 0.186948 0.342172 0.194639 0.253635 0.380046 0.379499 0.126187 0.400638 0.280847 0.390659 0.205947 0.348598 0.348816 0.429906 0.286882 0.519466 0.40677 0.455602 0.22915 0.390241 0.426167 0.454828 0.228427 0.388869 0.424691 0.45333 0.227748 0.387853 0.423659 0.452263 0.227246 0.387081 0.42287 0.45145 0.226864 0.386498 0.422273 0.450833 0.226574 0.386053 0.421818 0.450363 0.226354 0.385714 0.421471 0.450005 0.226185 0.385456 0.421207 0.449732 0.226057 0.38526 0.421006 0.449525 0.22596 0.38511 0.420852
# PSFS 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 5.71823e-05 0 0 4.73275e-05 4.38608e-05 1.0188e-05 0 0.000230441 0.00117792 0.000143109 3.0691e-05 0.0041001 0.00639737 0.00352241 0.00358259 0.0180371 0.0119812 0.00806804 0.002673 0.00813915 0.0120364 0.0334015 0.0105242 0.00750964 0.00499038 0.0172614 0.0322462 0.0443621 0.0132814 0.0111175 0.00385308 0.0427096 0.0792597 0.0653593 0.0279162 0.00624231 0.0418911 0.0269754 0.00527951 0.00861926 0.00878209 0.0157899 0.0122571 0.00733337 0.0204689 0.0228774 0.0088285 0.0177229 0.0165746 0.0552949 0.0187264 0.0180787 0.0217257 0.067406 0.0176488 0.0461334 0.0418518 0.0368172 0.0198891 0.0208194 0.056227 0.0574022 0.013613 0.0203772 0.0295094 0.0217223 0.0171366 0.0321337 0.0359964 0.0567795 0.0192978 0.0146917 0.0689395 0.0412975 0.00961914 0.0230301 0.0268954 0.0562136 0.0140799 0.0122962 0.0286454 0.0323851 0.0115934 0.0486621 0.0133439 0.0214815 0.0111471 0.0321212 0.0438608 0.0219037 0.0222892 0.0548517 0.0305249 0.017551 0.0136409 0.0261789 0.0276338 0.0736743 0.032996 0.0475798 0.0189763 0.0924182 0.0170827 0.0301033 0.0315928 0.0894472 0.0259373 0.0221793 0.0263439 0.0606054 0.00686167 0.0156158 0.0281395 0.0167494 0.00936217 0.00913046 0.0227418 0.0203059 0.0025779 0.0127774 0.0188273 0.0296266 0.00531133 0.0145621 0.0121333 0.00531834 0.00359275 0.0047463 0.00883148 0.0184749 0.00948277 0.0102427 0.015098 0.0143185 0.0104122 0.0128689 0.021648 0.0133175 0.0179349 0.0132687 0.0193169 0.0180587 0.00793929 0.00696668 0.0265297 0.0156514 0.0205396 0.0160393 0.0264149 0.0155754 0.0204442 0.0159702 0.0263099 0.0155197 0.0203794 0.0159225 0.0262332 0.0154766 0.0203277 0.0158844 0.0261729 0.0154433 0.0202883 0.0158556 0.0261274 0.0154181 0.0202584 0.0158337 0.0260927 0.0153989 0.0202356 0.015817 0.0260663 0.0153842 0.0202183 0.0158043 0.0260462 0.0153731 0.0202051 0.0157946 0.0260308 0.0153646 0.020195 0.0157873
# Other 0.00207708 0.00208409 0.0020864 0.00208385 0.00417762 0.0041913 0.00419539 0.00418956 0.00402119 0.00403232 0.00403433 0.00408309 0.00393078 0.00392603 0.00392729 0.00400532 0.00443183 0.00467993 0.00448254 0.00442611 0.00456564 0.00472182 0.00468409 0.00484901 0.00521661 0.00508654 0.0055357 0.00491397 0.00573219 0.00561281 0.00561428 0.00577204 0.00507285 0.00520635 0.0048977 0.00498184 0.00514777 0.00543591 0.00497856 0.00497344 0.00602892 0.00581429 0.00546131 0.00558175 0.00622127 0.00620625 0.00635523 0.00669878 0.00833317 0.00788545 0.00791441 0.00832436 0.00992039 0.00999607 0.00976222 0.00997986 0.0106365 0.0105942 0.0105056 0.010909 0.0107931 0.0108657 0.0105072 0.0107143 0.0125269 0.0127952 0.0124278 0.0125706 0.0131019 0.0130102 0.012844 0.0130227 0.0139511 0.013937 0.0136931 0.0139895 0.0144366 0.0138992 0.0141813 0.0144776 0.0118467 0.0118728 0.014299 0.0126005 0.0104558 0.0107287 0.0123093 0.0107148 0.0133731 0.0139458 0.0159047 0.0144233 0.0196886 0.0205178 0.0219308 0.0198174 0.0260249 0.0258112 0.0271016 0.0256094 0.0214236 0.0225154 0.0245792 0.0222827 0.0234509 0.0252891 0.0286657 0.0258466 0.0246667 0.0266292 0.0313518 0.0277433 0.0235419 0.0217681 0.0263621 0.0268498 0.0204518 0.034516 0.0217303 0.0220061 0.0252028 0.0235485 0.0277183 0.0260061 0.02453 0.022718 0.0475111 0.0251621 0.0347914 0.0333734 0.0386824 0.0359298 0.0314229 0.0292786 0.0365754 0.0328236 0.0311982 0.027817 0.0354018 0.0366088 0.0330575 0.0286992 0.0327684 0.0338441 0.0278694 0.0355291 0.0427437 0.0394405 0.0491031 0.0487408 0.049794 0.0554707 0.0573365 0.0455161 0.0506382 0.0604962 0.0908132 0.0461626 0.057837 0.0616324 0.0915424 0.0679201 0.0741515 0.0555496 0.0799179 0.0727552 0.089674 0.0919598 0.116172 0.107626 0.0968258 0.0754822 0.122418 0.122227 0.126765 0.101889 0.120343 0.115997 0.125052 0.125319 0.121525 0.10869 0.11821 0.115961 0.127227 0.115494 0.137171 0.132401 0.15541 0.15879 0.173749 0.169177 0.18774 0.16135 0.166539 0.143416 0.205268 0.160377 0.158971 0.141744 0.175998 0.140775 0.155995 0.145665 0.17008 0.142152 0.171482 0.156787 0.197806 0.127303 0.16344 0.158074 0.217143 0.154772 0.179206 0.177664 0.279231 0.196712 0.21794 0.219138 0.280339 0.232251 0.232306 0.23446 0.297372 0.283074 0.295686 0.346042 0.363693 0.38126 0.410005 0.458278 0.427248 0.401609 0.402852 0.405546 0.41242 0.378877 0.377542 0.390083 0.363427 0.328528 0.329461 0.355154 0.40224 0.368122 0.364708 0.38255 0.439394 0.442055 0.444942 0.469503 0.509841 0.513512 0.510554 0.525184 0.605128 0.463334 0.437228 0.422788 0.49788 0.412205 0.459183 0.408763 0.455248 0.399038 0.394139 0.389383 0.627499 0.506421 0.546237 0.498291 0.623705 0.503225 0.5431 0.495723 0.62082 0.501159 0.541133 0.494031 0.618738 0.499534 0.539512 0.492631 0.617054 0.498256 0.538265 0.491567 0.61578 0.49729 0.53732 0.490759 0.614812 0.496555 0.536601 0.490144 0.614074 0.495995 0.536053 0.489676 0.613513 0.495568 0.535636 0.489319 0.613086 0.495244 0.535318 0.489048
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
           -25            25      -10.5394             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_PL_CPUE(5)
           -25            25      -11.0073             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_PSLS_CPUE_LONG(6)
           -25            25      -7.32865             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_OTHER_CPUE(7)
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
        -0.001             1      0.996156             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradLo_PL(1)
            -1         0.001     -0.507059             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradHi_PL(1)
             1             1       22.6447             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_1_PL(1)
             1             1       37.5977             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_2_PL(1)
             1             1       42.0377             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_3_PL(1)
             1             1        45.702             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_4_PL(1)
             1             1       51.7386             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_5_PL(1)
             1             1       59.9904             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_6_PL(1)
             1             1       71.3145             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_7_PL(1)
            -9             7      -7.98566             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_1_PL(1)
            -9             7      -2.33185             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_2_PL(1)
            -9             7      -1.49438             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_3_PL(1)
            -9             7            -1             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_4_PL(1)
            -9             7      -1.50951             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_5_PL(1)
            -9             7      -1.17496             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_6_PL(1)
            -9             7     -0.853269             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_7_PL(1)
# 2   PSLS LenSelex
             0             0             0             0             0             0        -99          0          0          0          0        0.5          0          0  #  SizeSpline_Code_PSLS(2)
        -0.001             1      0.617864             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradLo_PSLS(2)
            -1         0.001     -0.143373             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradHi_PSLS(2)
             1             1        23.125             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_1_PSLS(2)
             1             1       41.9035             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_2_PSLS(2)
             1             1       45.6322             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_3_PSLS(2)
             1             1       50.2975             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_4_PSLS(2)
             1             1       70.9228             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_5_PSLS(2)
            -9             7       -8.9974             0         0.001             1         -2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_1_PSLS(2)
            -9             7      -2.03165             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_2_PSLS(2)
            -9             7            -1             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_3_PSLS(2)
            -9             7      -1.21535             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_4_PSLS(2)
            -9             7      -3.30812             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_5_PSLS(2)
# 3   PSFS LenSelex
             0             0             0             0             0             0        -99          0          0          0          0        0.5          0          0  #  SizeSpline_Code_PSFS(3)
        -0.001             1       0.13267             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradLo_PSFS(3)
            -1         0.001     -0.321541             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradHi_PSFS(3)
             1             1       23.1313             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_1_PSFS(3)
             1             1       44.1442             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_2_PSFS(3)
             1             1       48.4634             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_3_PSFS(3)
             1             1       54.7779             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_4_PSFS(3)
             1             1       71.2972             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_5_PSFS(3)
            -9             7      -8.99994             0         0.001             1         -2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_1_PSFS(3)
            -9             7      -1.83675             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_2_PSFS(3)
            -9             7            -1             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_3_PSFS(3)
            -9             7      -1.47746             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_4_PSFS(3)
            -9             7      -2.19802             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_5_PSFS(3)
# 4   Other LenSelex
             0             0             0             0             0             0        -99          0          0          0          0        0.5          0          0  #  SizeSpline_Code_Other(4)
        -0.001             1       0.15554             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradLo_Other(4)
            -1         0.001     -0.170626             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradHi_Other(4)
             1             1       22.5552             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_1_Other(4)
             1             1       44.2844             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_2_Other(4)
             1             1       51.4468             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_3_Other(4)
             1             1       58.8149             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_4_Other(4)
             1             1       72.4351             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_5_Other(4)
            -9             7      -5.80882             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_1_Other(4)
            -9             7      -1.80299             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_2_Other(4)
            -9             7            -1             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_3_Other(4)
            -9             7     -0.871966             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_4_Other(4)
            -9             7     -0.924035             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_5_Other(4)
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
 -20 20 -1.79345  0 99 1 1 0 0 0 0 0 0 0 # TG_report_fleet:_1
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
#      1    21     1     0     0     0     0     1     1  1983  2015     5 -0.000216838 0.0458795 -0.00299621 0.0120078 0.0502723 0.0293746 0.146816 -0.0122205 0.249554 0.00450828 0.000788204 0.126732 -0.078051 -0.0317796 0.111355 -0.0299959 0.141951 0.070627 -0.230575 0.147506 -0.0336543 -0.231388 -0.0142694 0.124164 0.0956403 0.455828 -0.0217637 0.0194829 0.254703 0.0710463 0.0809343 0.0194005 -0.0382378
#      1    22     3     0     0     0     0     2     1  1983  2015     5 8.46886e-05 0.000967605 -0.00183626 -0.00719726 0.00651219 -0.00530731 0.0081316 0.0152333 -0.0290616 0.02216 0.00658378 -0.018599 0.0198114 -0.0122242 0.0158752 0.0585495 -0.00158319 0.00242084 0.0469152 -0.0481887 -0.00277654 0.0236224 -0.029814 -0.0225106 -0.00954844 -0.0335919 0.0398939 -0.0355271 -0.0389671 0.0263263 0.0228961 -0.0116939 0.0175247
#      1    23     5     0     0     0     0     3     1  1983  2015     5 -0.00779022 0.0424767 0.0112832 0.00539352 0.0305865 0.07875 0.0914833 -0.0911977 0.338706 -0.0269173 -0.0397814 0.248512 -0.153353 0.106262 0.143035 -0.172562 0.271097 -0.0388041 -0.210192 0.0988262 -0.0576838 -0.264025 0.114272 0.186423 0.122602 0.578561 -0.19506 0.0633343 0.210496 0.118699 -0.0307047 0.14013 0.0208172
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

