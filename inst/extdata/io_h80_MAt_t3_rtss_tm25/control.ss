#V3.30.15.09-trans;_2020_07_08;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_12.0
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
2 # recr_dist_method for parameters:  2=main effects for GP, Settle timing, Area; 3=each Settle entity; 4=none, only when N_GP*Nsettle*pop==1
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
 -3 3 4.97e-006 4.97e-006 100 6 -1 0 0 0 0 0.5 0 0 # Wtlen_1_Fem
 2 4 3.39292 3.39292 100 6 -1 0 0 0 0 0.5 0 0 # Wtlen_2_Fem
# Sex: 1  BioPattern: 1  Maturity&Fecundity
 1 150 38 38 100 6 -1 0 0 0 0 0.5 0 0 # Mat50%_Fem
 -8 1 -1.25 -1.25 100 6 -1 0 0 0 0 0.5 0 0 # Mat_slope_Fem
 0 2 1 1 100 6 -1 0 0 0 0 0.5 0 0 # Eggs/kg_inter_Fem
 -1 1 0 0 100 6 -1 0 0 0 0 0.5 0 0 # Eggs/kg_slope_wt_Fem
# Hermaphroditism
#  Recruitment Distribution  
 -4 4 0 0 99 0 -3 0 0 0 0 0.5 0 0 # RecrDist_GP_1
 -4 4 0 0 99 0 -3 0 0 0 0 0.5 0 0 # RecrDist_Area_1
 -4 4 0 0 99 0 -3 0 0 0 0 0.5 0 0 # RecrDist_timing_1
 -4 4 0.194387 0 0.1 6 5 0 1 1983 2015 5 0 0 # RecrDist_timing_2
 -4 4 0.00233274 0 0.1 6 5 0 1 1983 2015 5 0 0 # RecrDist_timing_3
 -4 4 -0.217533 0 0.1 6 5 0 1 1983 2015 5 0 0 # RecrDist_timing_4
#  Cohort growth dev base
 0.1 10 1 1 1 6 -1 0 0 0 0 0.5 0 0 # CohortGrowDev
#  Movement
#  Age Error from parameters
#  catch multiplier
#  fraction female, by GP
 0.000001 0.999999 0.5 0.5  0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_1
#
# timevary MG parameters 
#_ LO HI INIT PRIOR PR_SD PR_type  PHASE
 0.0001 2 0.3 0.3 0.5 6 -5 # RecrDist_timing_2_dev_se
 -0.99 0.99 0 0 0.5 6 -6 # RecrDist_timing_2_dev_autocorr
 0.0001 2 0.3 0.3 0.5 6 -5 # RecrDist_timing_3_dev_se
 -0.99 0.99 0 0 0.5 6 -6 # RecrDist_timing_3_dev_autocorr
 0.0001 2 0.3 0.3 0.5 6 -5 # RecrDist_timing_4_dev_se
 -0.99 0.99 0 0 0.5 6 -6 # RecrDist_timing_4_dev_autocorr
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
             0            35       13.4567            20            10             6          1          0          0          0          0          0          0          0 # SR_LN(R0)
         0.201          0.99           0.8           0.8            10             6         -2          0          0          0          0          0          0          0 # SR_BH_flat_steep
             0            10      0.283597           0.6            10             6          6          0          0          0          0          0          0          0 # SR_sigmaR
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
#  0.0609366 0.467461 -0.173356 -0.281634 0.539392 -0.344689 0.102424 0.260796 0.150187 -0.00666501 0.221929 0.0408491 -0.100999 -0.218539 -0.152502 0.476791 0.0944913 -0.0867021 0.450553 -0.0170684 0.0617593 0.451262 0.0582453 -0.7294 0.0013485 0.122812 -0.0493961 -0.307725 -0.528549 -0.0962654 -0.0202663 -0.447481 0 0 0 0 0 0 0 0 0 0 0 0
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
#2026 2301
# F rates by fleet
# Yr:  1950 1950 1950 1950 1951 1951 1951 1951 1952 1952 1952 1952 1953 1953 1953 1953 1954 1954 1954 1954 1955 1955 1955 1955 1956 1956 1956 1956 1957 1957 1957 1957 1958 1958 1958 1958 1959 1959 1959 1959 1960 1960 1960 1960 1961 1961 1961 1961 1962 1962 1962 1962 1963 1963 1963 1963 1964 1964 1964 1964 1965 1965 1965 1965 1966 1966 1966 1966 1967 1967 1967 1967 1968 1968 1968 1968 1969 1969 1969 1969 1970 1970 1970 1970 1971 1971 1971 1971 1972 1972 1972 1972 1973 1973 1973 1973 1974 1974 1974 1974 1975 1975 1975 1975 1976 1976 1976 1976 1977 1977 1977 1977 1978 1978 1978 1978 1979 1979 1979 1979 1980 1980 1980 1980 1981 1981 1981 1981 1982 1982 1982 1982 1983 1983 1983 1983 1984 1984 1984 1984 1985 1985 1985 1985 1986 1986 1986 1986 1987 1987 1987 1987 1988 1988 1988 1988 1989 1989 1989 1989 1990 1990 1990 1990 1991 1991 1991 1991 1992 1992 1992 1992 1993 1993 1993 1993 1994 1994 1994 1994 1995 1995 1995 1995 1996 1996 1996 1996 1997 1997 1997 1997 1998 1998 1998 1998 1999 1999 1999 1999 2000 2000 2000 2000 2001 2001 2001 2001 2002 2002 2002 2002 2003 2003 2003 2003 2004 2004 2004 2004 2005 2005 2005 2005 2006 2006 2006 2006 2007 2007 2007 2007 2008 2008 2008 2008 2009 2009 2009 2009 2010 2010 2010 2010 2011 2011 2011 2011 2012 2012 2012 2012 2013 2013 2013 2013 2014 2014 2014 2014 2015 2015 2015 2015 2016 2016 2016 2016 2017 2017 2017 2017 2018 2018 2018 2018 2019 2019 2019 2019 2020 2020 2020 2020 2021 2021 2021 2021 2022 2022 2022 2022 2023 2023 2023 2023 2024 2024 2024 2024 2025 2025 2025 2025 2026 2026 2026 2026
# seas:  1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4
# PL 0.0102339 0.0102843 0.0102838 0.0102551 0.0102772 0.0103272 0.0103257 0.0102957 0.0103149 0.0103606 0.0103547 0.0103206 0.011629 0.0116784 0.0116697 0.0116294 0.0116463 0.0116946 0.0116849 0.0116434 0.0116591 0.0117059 0.0116949 0.0116527 0.011668 0.0117147 0.0117037 0.0116611 0.012974 0.0130273 0.0130158 0.0129695 0.0129863 0.0130372 0.0130234 0.0129746 0.0129899 0.0130405 0.0130264 0.0129771 0.011381 0.0146923 0.0118732 0.00891374 0.0113497 0.0137059 0.00866679 0.00792113 0.0116417 0.0132464 0.00901597 0.00775587 0.0120223 0.0125562 0.00914793 0.00798052 0.0120404 0.0125745 0.00916068 0.00799135 0.0212614 0.0222129 0.016192 0.0141299 0.0255684 0.0267214 0.0194819 0.0170041 0.0287101 0.0299971 0.0218694 0.0190812 0.0266667 0.0278549 0.0202957 0.0177067 0.0299272 0.0312625 0.0227788 0.0198686 0.0329642 0.0194753 0.0475929 0.0464193 0.0338619 0.0336617 0.0357596 0.0458038 0.0340692 0.0197712 0.0230182 0.0162712 0.0318223 0.0170264 0.0238218 0.0314381 0.0254645 0.0404127 0.0251683 0.0296061 0.0194653 0.0251243 0.0203023 0.0152375 0.0297798 0.0342221 0.0168287 0.0190151 0.0217839 0.0213919 0.0173424 0.0129582 0.0227396 0.0168696 0.0162537 0.0148369 0.0246083 0.0245721 0.0191062 0.0243637 0.0340194 0.0292358 0.0272578 0.0287331 0.0304509 0.0247831 0.0268366 0.0238955 0.0198968 0.0263975 0.0214752 0.0149714 0.0315381 0.0322719 0.018694 0.0222414 0.041782 0.032357 0.0368454 0.0603767 0.0597608 0.0452202 0.0358911 0.0703801 0.0627497 0.0446829 0.0503335 0.0797994 0.0757012 0.0741407 0.05068 0.0460787 0.103223 0.054836 0.060727 0.108219 0.099877 0.0822943 0.0765191 0.0847381 0.0923151 0.0665986 0.0877572 0.131299 0.0614537 0.0985953 0.0964085 0.0954044 0.0846084 0.102817 0.0550994 0.105981 0.0846271 0.0897212 0.0899256 0.103421 0.120118 0.113257 0.117174 0.0982973 0.130104 0.102811 0.0814392 0.173195 0.134082 0.145927 0.110138 0.117299 0.135027 0.141959 0.159477 0.160441 0.200362 0.148981 0.145794 0.221893 0.189001 0.203243 0.192859 0.152593 0.179483 0.138581 0.147169 0.133144 0.176362 0.134291 0.159589 0.207974 0.225426 0.195258 0.199681 0.2325 0.223609 0.211311 0.177582 0.232813 0.262113 0.156974 0.191483 0.243439 0.225865 0.267114 0.219361 0.297014 0.3028 0.381752 0.18193 0.301317 0.320789 0.281248 0.199237 0.350349 0.225276 0.246398 0.310826 0.349788 0.192938 0.190476 0.168999 0.246781 0.239137 0.190103 0.207177 0.226218 0.239512 0.13697 0.13924 0.185693 0.133497 0.18789 0.149476 0.31684 0.167364 0.235655 0.291583 0.416122 0.246683 0.381799 0.172184 0.231914 0.352616 0.314032 0.135911 0.299781 0.2213 0.241178 0.13969 0.40564 0.298114 0.248975 0.103466 0.22862 0.2562 0.216259 0.0911547 0.203609 0.230373 0.196512 0.0837763 0.188703 0.215018 0.18474 0.0793484 0.179719 0.205734 0.177592 0.0766454 0.174218 0.200037 0.173194 0.0749767 0.170816 0.196508 0.170465 0.0739392 0.168697 0.194309 0.168763 0.0732913 0.167373 0.192934 0.167698 0.0728853 0.166543 0.192072 0.16703 0.0726306 0.166022
# PSLS 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000566834 0 0 0 0.00127818 0.000206466 0 0.00167218 0.00740731 0.0072353 0.00345712 0.0128278 0.00520122 0.0164717 0.0408667 0.0483252 0.0138591 0.0223678 0.0597365 0.078637 0.0244106 0.0428943 0.068992 0.0751907 0.0412683 0.067583 0.0770433 0.0562098 0.0208469 0.0391176 0.118498 0.0802496 0.0416678 0.0416105 0.124799 0.137203 0.0527468 0.0686878 0.107432 0.091803 0.0243773 0.0721643 0.105429 0.156759 0.062635 0.106203 0.118572 0.145717 0.0733891 0.104229 0.153701 0.149982 0.0687845 0.0940798 0.200634 0.186794 0.135377 0.148584 0.204455 0.201354 0.0916951 0.111146 0.184026 0.267703 0.157072 0.139066 0.207159 0.28588 0.243893 0.130757 0.195644 0.193994 0.109346 0.127974 0.259623 0.236808 0.127043 0.153083 0.265392 0.338436 0.13983 0.110173 0.338365 0.240044 0.156663 0.127816 0.376044 0.289801 0.233399 0.0949903 0.274285 0.391072 0.139291 0.0846113 0.231725 0.283875 0.14164 0.115685 0.259843 0.244774 0.129146 0.0817781 0.445508 0.596937 0.169418 0.15857 0.426202 0.263589 0.0829174 0.188378 0.341218 0.319564 0.268367 0.133347 0.354551 0.223099 0.28412 0.177098 0.347902 0.258993 0.319274 0.186115 0.256921 0.339807 0.302553 0.128493 0.209373 0.171592 0.310983 0.176008 0.230227 0.345267 0.342705 0.113295 0.360617 0.254554 0.35506 0.188205 0.320381 0.318323 0.386553 0.2555 0.462627 0.361869 0.28139 0.136671 0.228771 0.245066 0.252678 0.124487 0.211307 0.228409 0.2371 0.11766 0.201238 0.218649 0.22789 0.113592 0.195192 0.212759 0.222316 0.111121 0.191502 0.209154 0.218896 0.109601 0.189225 0.206925 0.21678 0.108659 0.187811 0.205539 0.215462 0.108072 0.186929 0.204673 0.214638 0.107704 0.186376 0.20413 0.214121 0.107474 0.186029 0.203789
# PSFS 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 5.34361e-005 0 0 4.42906e-005 4.09806e-005 9.51223e-006 0 0.000215636 0.00110046 0.000133638 2.87344e-005 0.00384604 0.00599934 0.00330634 0.00336346 0.0168293 0.0110708 0.0073967 0.00244404 0.00745343 0.011052 0.030786 0.00975627 0.00699049 0.00464474 0.0160583 0.0299227 0.0407103 0.0120155 0.00995712 0.00344748 0.0385223 0.0723601 0.0605275 0.0261569 0.00585535 0.0389705 0.024871 0.00484518 0.00787711 0.00799243 0.0143558 0.0111787 0.00671271 0.0187714 0.0210263 0.00814675 0.0163945 0.0153161 0.0510461 0.017291 0.0166393 0.0198656 0.0613038 0.016029 0.0419106 0.0379996 0.0334447 0.0181223 0.0190061 0.0512752 0.0522966 0.0124296 0.0186492 0.0270049 0.0198827 0.0157052 0.0293931 0.0327308 0.0516069 0.0176582 0.0134586 0.0629308 0.0376157 0.00877393 0.0210824 0.0246986 0.0518424 0.0130851 0.0115039 0.0268684 0.0304584 0.0109069 0.0453589 0.0122683 0.0195343 0.0100859 0.02905 0.0396938 0.0198999 0.0204213 0.0505127 0.0281085 0.016187 0.0126139 0.0241073 0.0252399 0.0668488 0.029883 0.0431473 0.0172234 0.0839344 0.0156092 0.0278323 0.0295895 0.0849318 0.0248383 0.0211057 0.0246893 0.0561076 0.00630973 0.0142585 0.0254656 0.015082 0.00842416 0.00820203 0.020334 0.0180964 0.0023053 0.0114983 0.017008 0.0268378 0.00484034 0.0133467 0.0111387 0.00489661 0.00332464 0.00438347 0.00808854 0.0168268 0.00864599 0.00933915 0.0137095 0.0129624 0.00945493 0.0117668 0.0198911 0.012309 0.0166649 0.0122575 0.0176039 0.0162831 0.00713327 0.00623947 0.0164654 0.00932914 0.0119307 0.00910466 0.0144326 0.00829291 0.0107751 0.00830847 0.0132844 0.00770181 0.0101047 0.00784208 0.0126072 0.00735055 0.00970278 0.00756105 0.0121976 0.00713723 0.00945742 0.00738899 0.0119462 0.007006 0.00930599 0.0072826 0.0117906 0.00692462 0.00921188 0.0072164 0.0116937 0.00687387 0.00915312 0.00717503 0.0116331 0.00684211 0.00911631 0.0071491 0.0115951 0.00682219 0.00909321 0.00713283
# Other 0.00206587 0.00207181 0.00207634 0.00207475 0.00415458 0.00416616 0.00417479 0.00417105 0.00399898 0.00400834 0.004015 0.00406576 0.00390993 0.00390368 0.00390958 0.00398949 0.00440961 0.0046546 0.0044635 0.0044097 0.00454377 0.00469723 0.00466508 0.00483188 0.00519246 0.0050608 0.00551399 0.00489722 0.00570629 0.00558496 0.00559277 0.00575282 0.00505031 0.00518092 0.00487932 0.00496568 0.00512535 0.00540983 0.0049603 0.00495772 0.00600313 0.00578678 0.0054416 0.0055644 0.00619496 0.00617715 0.00633254 0.00667818 0.0082981 0.00784854 0.00788613 0.00829866 0.00987844 0.00994901 0.00972704 0.00994877 0.0105913 0.0105443 0.0104679 0.0108752 0.0107476 0.0108148 0.0104697 0.0106816 0.0124745 0.0127357 0.012384 0.0125328 0.013048 0.0129508 0.0128003 0.0129856 0.0138963 0.0138765 0.0136501 0.0139536 0.0143841 0.0138429 0.0141408 0.0144444 0.0118067 0.011828 0.0142619 0.0125742 0.0104223 0.0106898 0.0122791 0.0106942 0.0133325 0.0138978 0.0158689 0.014399 0.0196336 0.0204513 0.0218853 0.0197862 0.0259537 0.0257274 0.0270434 0.0255668 0.0213635 0.0224427 0.0245292 0.0222504 0.0233918 0.025215 0.0286161 0.0258166 0.0246111 0.026558 0.0313047 0.0277162 0.0234926 0.0217135 0.0263274 0.0268288 0.0204128 0.034434 0.0217032 0.0219901 0.0251549 0.023492 0.0276827 0.0259849 0.0244809 0.0226618 0.0474454 0.0251387 0.0347187 0.0332875 0.0386271 0.0358968 0.0313578 0.0292103 0.0365548 0.0328504 0.0312186 0.0278587 0.0354915 0.0365931 0.0328321 0.0283412 0.0322828 0.0333574 0.0275186 0.0351966 0.0425183 0.0393181 0.0488681 0.0483728 0.0492146 0.0543102 0.0554398 0.0436067 0.0484219 0.0581673 0.0882284 0.0454747 0.0577324 0.0618706 0.0916012 0.0675251 0.0732962 0.054571 0.0780556 0.0709079 0.0875951 0.0901628 0.114267 0.106284 0.0960967 0.0751616 0.121909 0.121653 0.126112 0.101042 0.118617 0.113716 0.122282 0.122411 0.11859 0.106148 0.115776 0.113795 0.124807 0.113253 0.134665 0.13006 0.152476 0.155717 0.170514 0.165802 0.18318 0.157423 0.163367 0.141011 0.201525 0.15742 0.156561 0.140326 0.175196 0.141083 0.157634 0.148123 0.173376 0.145175 0.175064 0.158842 0.197887 0.125976 0.160742 0.155076 0.212985 0.152396 0.177754 0.176987 0.278177 0.196202 0.217814 0.218378 0.277501 0.228657 0.22837 0.23071 0.293024 0.279574 0.293535 0.346074 0.366833 0.388548 0.421239 0.46999 0.43346 0.403136 0.401703 0.401807 0.405616 0.371341 0.370171 0.382249 0.355011 0.32026 0.32181 0.347971 0.394674 0.361772 0.360047 0.379189 0.43603 0.439846 0.444788 0.469201 0.506328 0.507621 0.505011 0.519506 0.596712 0.456271 0.432124 0.420413 0.497524 0.414457 0.464473 0.41224 0.45388 0.393684 0.386797 0.380271 0.423135 0.327018 0.341971 0.303488 0.364121 0.284856 0.302708 0.271648 0.329096 0.260061 0.27951 0.25279 0.308295 0.245262 0.265553 0.241396 0.295686 0.236259 0.257015 0.234407 0.287937 0.230712 0.251738 0.23008 0.28313 0.227266 0.248452 0.227383 0.280132 0.225115 0.246399 0.225696 0.278256 0.223767 0.245111 0.224638 0.27708 0.222922 0.244303 0.223973
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
           -25            25      -10.5284             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_PL_CPUE(5)
           -25            25      -11.1065             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_PSLS_CPUE_LONG(6)
           -25            25      -7.33728             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_OTHER_CPUE(7)
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
        -0.001             1       0.99349             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradLo_PL(1)
            -1         0.001     -0.483097             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradHi_PL(1)
             1             1       22.6447             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_1_PL(1)
             1             1       37.5977             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_2_PL(1)
             1             1       42.0377             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_3_PL(1)
             1             1        45.702             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_4_PL(1)
             1             1       51.7386             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_5_PL(1)
             1             1       59.9904             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_6_PL(1)
             1             1       71.3145             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_7_PL(1)
            -9             7      -7.55908             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_1_PL(1)
            -9             7      -2.24159             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_2_PL(1)
            -9             7      -1.46377             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_3_PL(1)
            -9             7            -1             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_4_PL(1)
            -9             7      -1.49839             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_5_PL(1)
            -9             7      -1.06674             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_6_PL(1)
            -9             7     -0.640054             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_7_PL(1)
# 2   PSLS LenSelex
             0             0             0             0             0             0        -99          0          0          0          0        0.5          0          0  #  SizeSpline_Code_PSLS(2)
        -0.001             1      0.675261             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradLo_PSLS(2)
            -1         0.001      -0.16772             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradHi_PSLS(2)
             1             1        23.125             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_1_PSLS(2)
             1             1       41.9035             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_2_PSLS(2)
             1             1       45.6322             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_3_PSLS(2)
             1             1       50.2975             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_4_PSLS(2)
             1             1       70.9228             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_5_PSLS(2)
            -9             7       -8.9974             0         0.001             1         -2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_1_PSLS(2)
            -9             7      -2.00623             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_2_PSLS(2)
            -9             7            -1             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_3_PSLS(2)
            -9             7      -1.20682             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_4_PSLS(2)
            -9             7      -3.27859             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_5_PSLS(2)
# 3   PSFS LenSelex
             0             0             0             0             0             0        -99          0          0          0          0        0.5          0          0  #  SizeSpline_Code_PSFS(3)
        -0.001             1      0.124872             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradLo_PSFS(3)
            -1         0.001     -0.343315             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradHi_PSFS(3)
             1             1       23.1313             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_1_PSFS(3)
             1             1       44.1442             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_2_PSFS(3)
             1             1       48.4634             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_3_PSFS(3)
             1             1       54.7779             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_4_PSFS(3)
             1             1       71.2972             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_5_PSFS(3)
            -9             7      -8.99994             0         0.001             1         -2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_1_PSFS(3)
            -9             7      -1.81209             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_2_PSFS(3)
            -9             7            -1             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_3_PSFS(3)
            -9             7      -1.44276             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_4_PSFS(3)
            -9             7      -2.21711             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_5_PSFS(3)
# 4   Other LenSelex
             0             0             0             0             0             0        -99          0          0          0          0        0.5          0          0  #  SizeSpline_Code_Other(4)
        -0.001             1      0.123929             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradLo_Other(4)
            -1         0.001     -0.170512             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradHi_Other(4)
             1             1       22.5552             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_1_Other(4)
             1             1       44.2844             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_2_Other(4)
             1             1       51.4468             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_3_Other(4)
             1             1       58.8149             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_4_Other(4)
             1             1       72.4351             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_5_Other(4)
            -9             7      -5.26748             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_1_Other(4)
            -9             7      -1.79559             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_2_Other(4)
            -9             7            -1             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_3_Other(4)
            -9             7     -0.814021             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_4_Other(4)
            -9             7     -0.832918             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_5_Other(4)
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
             0             8             0             5            99             0         -1          0          0          0          0          0          0          0  #  AgeSel_P1_PL(1)
             0             8             8             5            99             0         -1          0          0          0          0          0          0          0  #  AgeSel_P2_PL(1)
# 2   PSLS AgeSelex
             0             8             0             5            99             0         -1          0          0          0          0          0          0          0  #  AgeSel_P1_PSLS(2)
             0             8             8             5            99             0         -1          0          0          0          0          0          0          0  #  AgeSel_P2_PSLS(2)
# 3   PSFS AgeSelex
             0             8             0             5            99             0         -1          0          0          0          0          0          0          0  #  AgeSel_P1_PSFS(3)
             0             8             8             5            99             0         -1          0          0          0          0          0          0          0  #  AgeSel_P2_PSFS(3)
# 4   Other AgeSelex
             0             8             0             5            99             0         -1          0          0          0          0          0          0          0  #  AgeSel_P1_Other(4)
             0             8             8             5            99             0         -1          0          0          0          0          0          0          0  #  AgeSel_P2_Other(4)
# 5   PL_CPUE AgeSelex
             0             8             0             5            99             0         -1          0          0          0          0          0          0          0  #  AgeSel_P1_PL_CPUE(5)
             0             8             8             5            99             0         -1          0          0          0          0          0          0          0  #  AgeSel_P2_PL_CPUE(5)
# 6   PSLS_CPUE_LONG AgeSelex
             0             8             0             5            99             0         -1          0          0          0          0          0          0          0  #  AgeSel_P1_PSLS_CPUE_LONG(6)
             0             8             8             5            99             0         -1          0          0          0          0          0          0          0  #  AgeSel_P2_PSLS_CPUE_LONG(6)
# 7   OTHER_CPUE AgeSelex
             0             8             0             5            99             0         -1          0          0          0          0          0          0          0  #  AgeSel_P1_OTHER_CPUE(7)
             0             8             8             5            99             0         -1          0          0          0          0          0          0          0  #  AgeSel_P2_OTHER_CPUE(7)
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
 -20 20 -2.25306  0 99 1 1 0 0 0 0 0 0 0 # TG_report_fleet:_1
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
#      1    21     1     0     0     2     0     1     1  1983  2015     5 0.0013112 0.0371082 -0.00471271 0.00265326 0.0302629 0.0343344 0.13633 -0.0180566 0.211122 0.0120125 -0.00431992 0.101624 -0.0746494 -0.0239857 0.121223 -0.0123207 0.127457 0.0517921 -0.203808 0.0891465 -0.0359679 -0.206716 -0.0672382 0.0725473 0.122653 0.425841 -0.0676416 -0.0250927 0.179011 0.0866578 0.0633515 0.0160238 -0.0200064
#      1    22     3     0     0     2     0     2     1  1983  2015     5 -3.06768e-005 9.14696e-005 -8.43992e-005 -0.000480206 0.000287087 -0.000420567 0.000287556 0.00073467 -0.00181939 0.00120698 0.000218871 -0.00100418 0.00108501 -0.000590581 0.000731919 0.00301542 -0.000161159 0.000118444 0.00291503 -0.00265524 5.73987e-006 0.000771664 -0.0011976 -0.00105714 -0.00127606 -0.00231909 0.00193663 -0.00167487 -0.00228629 0.0011507 0.00101051 -0.000624988 0.000694561
#      1    23     5     0     0     2     0     3     1  1983  2015     5 -0.00396148 0.0346227 0.00232926 0.00627286 0.0110408 0.0848665 0.105582 -0.0993101 0.323614 -0.015244 -0.0480311 0.234262 -0.152754 0.10664 0.154311 -0.144654 0.240444 -0.0112798 -0.24278 0.0922873 -0.0476878 -0.287833 -0.041108 0.0874589 0.161805 0.638778 -0.160602 0.014639 0.19136 0.149665 -0.0465697 0.140711 0.0327539
#      5     4     7     0     0     2     0     4     1  2004  2008    -4      0      0      0      0      0
#      5     5     9     0     0     2     0     5     1  2004  2008    -4      0      0      0      0      0
#      5     6    11     0     0     2     0     6     1  2004  2008    -4      0      0      0      0      0
#      5     7    13     0     0     2     0     7     1  2004  2008    -4      0      0      0      0      0
#      5     8    15     0     0     2     0     8     1  2004  2008    -4      0      0      0      0      0
#      5     9    17     0     0     2     0     9     1  2004  2008    -4      0      0      0      0      0
#      5    10    19     0     0     2     0    10     1  2004  2008    -4      0      0      0      0      0
#      5    11    21     0     0     2     0    11     1  2004  2008    -4      0      0      0      0      0
#      5    12    23     0     0     2     0    12     1  2004  2008    -4      0      0      0      0      0
#      5    13    25     0     0     2     0    13     1  2004  2008    -4      0      0      0      0      0
#      5    14    27     0     0     2     0    14     1  2004  2008    -4      0      0      0      0      0
#      5    15    29     0     0     2     0    15     1  2004  2008    -4      0      0      0      0      0
#      5    16    31     0     0     2     0    16     1  2004  2008    -4      0      0      0      0      0
#      5    17    33     0     0     2     0    17     1  2004  2008    -4      0      0      0      0      0
#      5    21    35     0     0     2     0    18     1  2004  2008    -4      0      0      0      0      0
#      5    22    37     0     0     2     0    19     1  2004  2008    -4      0      0      0      0      0
#      5    23    39     0     0     2     0    20     1  2004  2008    -4      0      0      0      0      0
#      5    24    41     0     0     2     0    21     1  2004  2008    -4      0      0      0      0      0
#      5    25    43     0     0     2     0    22     1  2004  2008    -4      0      0      0      0      0
#      5    26    45     0     0     2     0    23     1  2004  2008    -4      0      0      0      0      0
#      5    27    47     0     0     2     0    24     1  2004  2008    -4      0      0      0      0      0
#      5    28    49     0     0     2     0    25     1  2004  2008    -4      0      0      0      0      0
#      5    29    51     0     0     2     0    26     1  2004  2008    -4      0      0      0      0      0
#      5    30    53     0     0     2     0    27     1  2004  2008    -4      0      0      0      0      0
#      5    34    55     0     0     2     0    28     1  2004  2008    -4      0      0      0      0      0
#      5    35    57     0     0     2     0    29     1  2004  2008    -4      0      0      0      0      0
#      5    36    59     0     0     2     0    30     1  2004  2008    -4      0      0      0      0      0
#      5    37    61     0     0     2     0    31     1  2004  2008    -4      0      0      0      0      0
#      5    38    63     0     0     2     0    32     1  2004  2008    -4      0      0      0      0      0
#      5    39    65     0     0     2     0    33     1  2004  2008    -4      0      0      0      0      0
#      5    40    67     0     0     2     0    34     1  2004  2008    -4      0      0      0      0      0
#      5    41    69     0     0     2     0    35     1  2004  2008    -4      0      0      0      0      0
#      5    42    71     0     0     2     0    36     1  2004  2008    -4      0      0      0      0      0
#      5    43    73     0     0     2     0    37     1  2004  2008    -4      0      0      0      0      0
#      5    47    75     0     0     2     0    38     1  2004  2008    -4      0      0      0      0      0
#      5    48    77     0     0     2     0    39     1  2004  2008    -4      0      0      0      0      0
#      5    49    79     0     0     2     0    40     1  2004  2008    -4      0      0      0      0      0
#      5    50    81     0     0     2     0    41     1  2004  2008    -4      0      0      0      0      0
#      5    51    83     0     0     2     0    42     1  2004  2008    -4      0      0      0      0      0
#      5    52    85     0     0     2     0    43     1  2004  2008    -4      0      0      0      0      0
#      5    53    87     0     0     2     0    44     1  2004  2008    -4      0      0      0      0      0
#      5    54    89     0     0     2     0    45     1  2004  2008    -4      0      0      0      0      0
#      5    55    91     0     0     2     0    46     1  2004  2008    -4      0      0      0      0      0
#      5    56    93     0     0     2     0    47     1  2004  2008    -4      0      0      0      0      0
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

