#V3.30.22.00;_safe;_compile_date:_Oct 30 2023;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_13.1
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-stock-synthesis/stock-synthesis

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
 -4 4 0.18422 0 0.1 6 5 0 1 1983 2015 5 0 0 # RecrDist_month_4
 -4 4 0.0147313 0 0.1 6 5 0 1 1983 2015 5 0 0 # RecrDist_month_7
 -4 4 -0.218966 0 0.1 6 5 0 1 1983 2015 5 0 0 # RecrDist_month_10
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
             0            35       13.5338            20            10             6          1          0          0          0          0          0          0          0 # SR_LN(R0)
         0.201          0.99           0.7           0.7            10             6         -2          0          0          0          0          0          0          0 # SR_BH_flat_steep
             0            10      0.276796           0.6            10             6          6          0          0          0          0          0          0          0 # SR_sigmaR
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
#  0.0859535 0.447952 -0.181181 -0.283969 0.525549 -0.344694 0.0887739 0.256186 0.136732 -0.0172274 0.210764 0.0284031 -0.110302 -0.223104 -0.150579 0.48856 0.0830244 -0.0942588 0.446192 -0.0234752 0.0510177 0.431399 0.0107124 -0.665964 0.00679455 0.119522 -0.0382415 -0.291694 -0.519551 -0.0714924 0.000180476 -0.401982 0 0 0 0 0 0 0 0 0 0 0 0
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
# PL 0.00930679 0.00935395 0.00935341 0.00932422 0.00934282 0.00938964 0.00938818 0.00935772 0.00937381 0.00941686 0.00941157 0.0093775 0.0105649 0.0106115 0.0106038 0.0105639 0.010578 0.0106237 0.0106153 0.0105745 0.0105876 0.0106323 0.0106229 0.0105816 0.0105946 0.0106392 0.0106299 0.0105884 0.0117796 0.0118304 0.0118208 0.0117755 0.0117899 0.0118388 0.0118272 0.0117799 0.011793 0.0118417 0.01183 0.0117823 0.0103325 0.0133417 0.0107826 0.00809311 0.0103042 0.0124462 0.00787089 0.00719203 0.0105694 0.0120286 0.00818763 0.00704152 0.010914 0.0114007 0.0083065 0.00724454 0.010929 0.0114158 0.00831707 0.00725353 0.019296 0.0201623 0.0146975 0.0128222 0.0231989 0.0242477 0.0176786 0.0154258 0.0260416 0.0272125 0.0198398 0.0173059 0.0241832 0.0252651 0.01841 0.0160579 0.027138 0.0283537 0.0206607 0.018017 0.02989 0.0176635 0.0431673 0.0420866 0.0306976 0.0305237 0.032429 0.0415259 0.0308841 0.0179279 0.0208755 0.014754 0.0288535 0.0154411 0.0216053 0.0285039 0.023084 0.0366374 0.0228158 0.0268295 0.0176379 0.0227713 0.0184026 0.013809 0.0269865 0.0310172 0.0152534 0.0172311 0.019739 0.0193884 0.0157193 0.0117426 0.0206055 0.0152908 0.0147348 0.0134475 0.0223031 0.0222743 0.0173204 0.022082 0.0308301 0.0264995 0.0247078 0.0260371 0.0275905 0.0224602 0.0243203 0.0216466 0.0180225 0.0239144 0.0194551 0.0135589 0.0285574 0.0292096 0.0168974 0.0200612 0.037608 0.0290818 0.0330776 0.0541271 0.0535403 0.0405589 0.0322654 0.0634182 0.0566806 0.040459 0.045649 0.0724201 0.0687135 0.0672398 0.0458507 0.0415578 0.0928863 0.0493476 0.0547375 0.0976974 0.0902672 0.0744354 0.0692114 0.0765573 0.0832866 0.0600189 0.0789955 0.118012 0.0551982 0.0885917 0.0866667 0.0857682 0.0760754 0.0924986 0.0496009 0.0954325 0.0762057 0.0807665 0.0808581 0.0928513 0.107725 0.101534 0.105017 0.0880522 0.116505 0.0920958 0.0729842 0.155159 0.120062 0.130678 0.0986336 0.104975 0.120718 0.12684 0.142358 0.142931 0.178052 0.132094 0.128987 0.195811 0.166464 0.179055 0.170237 0.13497 0.159101 0.123127 0.130966 0.118513 0.156965 0.119543 0.141883 0.184368 0.199433 0.172795 0.176863 0.205879 0.197909 0.187104 0.157345 0.205943 0.231321 0.138557 0.169279 0.215305 0.199897 0.237037 0.195501 0.265827 0.272084 0.343981 0.163882 0.270109 0.285485 0.248546 0.174691 0.304674 0.194868 0.212946 0.269182 0.30388 0.168235 0.166899 0.148735 0.217749 0.211336 0.168266 0.183581 0.200333 0.211714 0.120914 0.122931 0.163801 0.11754 0.165235 0.131417 0.278305 0.146818 0.206694 0.256048 0.365426 0.216401 0.33493 0.151094 0.203296 0.308148 0.273912 0.118816 0.262813 0.194564 0.213006 0.124137 0.362346 0.38397 0.334728 0.144293 0.327825 0.38106 0.331792 0.143013 0.324924 0.377667 0.328888 0.141823 0.322332 0.374745 0.326472 0.140859 0.320267 0.37244 0.324571 0.140101 0.318642 0.370623 0.323072 0.139503 0.317357 0.369187 0.321886 0.139029 0.316341 0.368051 0.320949 0.138655 0.315538 0.367153 0.320207 0.138359 0.314902 0.366442 0.319621 0.138124 0.3144
# PSLS 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000529562 0 0 0 0.00119399 0.000192827 0 0.00156234 0.0069185 0.00675111 0.00321725 0.0118934 0.00480261 0.01518 0.0377592 0.0448656 0.0129164 0.0209117 0.0559656 0.0737475 0.0228951 0.0402241 0.0646577 0.070405 0.0385895 0.0631401 0.0720528 0.0526847 0.0195638 0.0367513 0.111366 0.0753581 0.039053 0.0389346 0.116739 0.128419 0.0493739 0.0643031 0.1006 0.0859855 0.022827 0.0675783 0.0987876 0.14701 0.0587493 0.0996163 0.111223 0.136689 0.0687918 0.0976173 0.143905 0.140481 0.0644238 0.0881098 0.187912 0.174986 0.126771 0.139108 0.191423 0.18851 0.0857952 0.103961 0.172134 0.250376 0.146772 0.129881 0.193468 0.266934 0.227405 0.121808 0.182374 0.181013 0.101969 0.119316 0.242288 0.221354 0.118894 0.143382 0.248589 0.316782 0.130714 0.102959 0.316296 0.224447 0.146438 0.119509 0.351459 0.2705 0.217442 0.0884336 0.255536 0.36431 0.129637 0.078871 0.216987 0.266993 0.13354 0.109335 0.246479 0.233184 0.123485 0.078312 0.424311 0.561024 0.156671 0.144902 0.388628 0.241515 0.0763474 0.174221 0.317515 0.299511 0.252657 0.125897 0.335009 0.21067 0.26777 0.166593 0.32668 0.24269 0.298243 0.173466 0.239538 0.317137 0.282283 0.11993 0.195932 0.161034 0.29188 0.165132 0.216304 0.324843 0.322145 0.106376 0.33767 0.237314 0.328908 0.173831 0.298139 0.299523 0.366408 0.243474 0.443143 0.348144 0.387532 0.195246 0.335216 0.364787 0.385173 0.193638 0.33232 0.361792 0.382267 0.192335 0.330346 0.359801 0.380249 0.191378 0.328839 0.358252 0.378664 0.190623 0.327648 0.357026 0.377409 0.190025 0.326705 0.356056 0.376416 0.189553 0.325959 0.355288 0.375631 0.189179 0.325369 0.354681 0.37501 0.188883 0.324902 0.354201 0.374519 0.188649 0.324533 0.353821
# PSFS 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4.95044e-05 0 0 4.10287e-05 3.79591e-05 8.80881e-06 0 0.000199731 0.00101915 0.00012369 2.65538e-05 0.00354556 0.00551318 0.00303109 0.00308454 0.0154754 0.0102094 0.00683891 0.00226375 0.00690983 0.0102484 0.0285452 0.00904153 0.00647416 0.00429745 0.0148455 0.0276817 0.0377486 0.0111624 0.00926349 0.00320844 0.0358213 0.0671605 0.0560748 0.0242125 0.00542088 0.0360817 0.023031 0.00448861 0.00730209 0.00741171 0.0133149 0.0103697 0.00622956 0.0174216 0.0195108 0.00755796 0.0152091 0.0142008 0.0472871 0.016008 0.01541 0.0184027 0.056785 0.0148422 0.0388024 0.0351671 0.0309396 0.0167598 0.0175721 0.0473812 0.0483036 0.0114768 0.0172138 0.0249057 0.018326 0.0144702 0.0270724 0.0301108 0.0474469 0.0162547 0.0124142 0.0580789 0.0347149 0.00809892 0.0194748 0.0228316 0.0479435 0.0120977 0.0106271 0.0247928 0.0280996 0.0100654 0.0418881 0.0113348 0.0180587 0.00931839 0.0267939 0.0365334 0.0182933 0.0187714 0.0463985 0.0257898 0.0148679 0.0116289 0.0223221 0.0234473 0.0622689 0.0279165 0.0404445 0.0161965 0.0790849 0.0146622 0.0258894 0.0271685 0.0770823 0.0223915 0.019027 0.022333 0.0509509 0.00575846 0.0131032 0.0235347 0.0139974 0.00783527 0.00763378 0.0189115 0.0168092 0.00213776 0.01064 0.0156893 0.0246867 0.004448 0.0122606 0.0102218 0.00449261 0.00305715 0.00404463 0.00747415 0.0155537 0.00800287 0.0086579 0.0127052 0.0120057 0.00874031 0.0108384 0.018214 0.0112193 0.0152429 0.011311 0.0163705 0.0152355 0.00671422 0.00590534 0.0223742 0.0132141 0.0174639 0.0136038 0.0222244 0.013105 0.0173094 0.0134829 0.0220324 0.0129992 0.0171829 0.0133906 0.021888 0.0129187 0.0170854 0.0133189 0.0217751 0.0128555 0.0170087 0.0132623 0.0216859 0.0128056 0.016948 0.0132176 0.0216154 0.0127662 0.0169 0.0131822 0.0215596 0.0127349 0.016862 0.0131542 0.0215155 0.0127102 0.016832 0.013132 0.0214807 0.0126907 0.0168083 0.0131145
# Other 0.00189443 0.00189964 0.00190374 0.00190226 0.00380872 0.00381887 0.0038267 0.00382319 0.00366504 0.00367323 0.00367928 0.00372576 0.00358256 0.00357645 0.00358182 0.00365502 0.00403952 0.00426353 0.00408851 0.00403929 0.00416177 0.004302 0.00427268 0.00442559 0.00475552 0.00463463 0.00504984 0.00448516 0.00522582 0.00511436 0.00512168 0.00526846 0.00462482 0.00474418 0.00446823 0.00454756 0.00469356 0.00495383 0.00454243 0.00454032 0.00549746 0.00529905 0.00498319 0.00509599 0.00567324 0.00565661 0.00579919 0.00611613 0.00759926 0.00718699 0.00722164 0.00759979 0.00904586 0.00910963 0.00890657 0.00910997 0.00969761 0.00965371 0.00958401 0.00995746 0.00983963 0.00989988 0.00958399 0.00977831 0.0114185 0.0116558 0.0113338 0.0114704 0.0119408 0.0118503 0.0117126 0.0118829 0.0127155 0.0126961 0.0124895 0.0127683 0.0131614 0.012665 0.0129381 0.0132169 0.0108029 0.0108221 0.0130492 0.0115044 0.00953473 0.00977926 0.0112339 0.00978419 0.0121972 0.0127143 0.0145193 0.0131761 0.0179654 0.0187122 0.0200249 0.0181043 0.0237443 0.0235329 0.0247348 0.0233838 0.0195382 0.0205247 0.0224342 0.0203521 0.0213956 0.0230608 0.0261719 0.0236132 0.0225099 0.0242895 0.0286316 0.0253511 0.0214876 0.0198603 0.0240829 0.0245436 0.0186737 0.0314972 0.0198525 0.0201169 0.0230103 0.0214869 0.0253202 0.0237675 0.02239 0.0207252 0.043388 0.0229877 0.031746 0.0304338 0.0353147 0.032819 0.0286654 0.0266906 0.0333692 0.0299359 0.0283827 0.0252772 0.0321761 0.0331813 0.0298003 0.0257658 0.0293983 0.0304138 0.0251147 0.0321476 0.0388482 0.0359219 0.0446309 0.0441597 0.0449222 0.0495891 0.0506464 0.0398681 0.0442949 0.0531976 0.0806156 0.0415148 0.0526801 0.0564322 0.083512 0.0615505 0.0668163 0.0497456 0.0711656 0.0646646 0.0798882 0.0822273 0.104206 0.0969216 0.087634 0.0685435 0.11114 0.110841 0.114822 0.0919607 0.107938 0.103456 0.111196 0.111253 0.107728 0.0964035 0.105135 0.103288 0.113222 0.10271 0.122095 0.117849 0.138033 0.140884 0.15418 0.149757 0.165185 0.141846 0.147286 0.127227 0.181857 0.142077 0.141354 0.126762 0.158396 0.127664 0.142687 0.134008 0.156749 0.131283 0.158322 0.143581 0.17885 0.113919 0.14532 0.139984 0.191921 0.137216 0.160048 0.159136 0.249703 0.176264 0.196213 0.197241 0.25129 0.20765 0.20802 0.210792 0.268562 0.256795 0.269324 0.31548 0.331226 0.34759 0.373692 0.414698 0.38214 0.356186 0.356186 0.358043 0.363356 0.334402 0.334616 0.346188 0.32172 0.290232 0.291467 0.314632 0.355902 0.325418 0.323518 0.340294 0.390645 0.393848 0.398813 0.42147 0.455274 0.456764 0.455076 0.468535 0.53795 0.411269 0.38924 0.377797 0.445014 0.369273 0.414415 0.369642 0.40939 0.357316 0.353393 0.349427 0.559896 0.452244 0.491281 0.447357 0.556275 0.44875 0.487123 0.443362 0.551193 0.444738 0.483062 0.439854 0.546989 0.441514 0.479838 0.437081 0.543673 0.438971 0.477293 0.434891 0.541054 0.436962 0.475281 0.43316 0.538982 0.435372 0.473689 0.43179 0.537343 0.434116 0.47243 0.430707 0.536048 0.433122 0.471434 0.42985 0.535023 0.432336 0.470647 0.429172
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
           -25            25      -10.6539             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_PL_CPUE(5)
           -25            25      -11.1722             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_PSLS_CPUE_LONG(6)
           -25            25      -7.44202             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_OTHER_CPUE(7)
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
        -0.001             1      0.993524             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradLo_PL(1)
            -1         0.001     -0.517925             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradHi_PL(1)
             1             1       22.6447             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_1_PL(1)
             1             1       37.5977             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_2_PL(1)
             1             1       42.0377             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_3_PL(1)
             1             1        45.702             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_4_PL(1)
             1             1       51.7386             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_5_PL(1)
             1             1       59.9904             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_6_PL(1)
             1             1       71.3145             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_7_PL(1)
            -9             7      -7.56269             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_1_PL(1)
            -9             7      -2.24135             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_2_PL(1)
            -9             7      -1.45967             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_3_PL(1)
            -9             7            -1             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_4_PL(1)
            -9             7      -1.50823             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_5_PL(1)
            -9             7      -1.12819             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_6_PL(1)
            -9             7     -0.836324             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_7_PL(1)
# 2   PSLS LenSelex
             0             0             0             0             0             0        -99          0          0          0          0        0.5          0          0  #  SizeSpline_Code_PSLS(2)
        -0.001             1      0.678172             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradLo_PSLS(2)
            -1         0.001     -0.169658             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradHi_PSLS(2)
             1             1        23.125             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_1_PSLS(2)
             1             1       41.9035             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_2_PSLS(2)
             1             1       45.6322             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_3_PSLS(2)
             1             1       50.2975             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_4_PSLS(2)
             1             1       70.9228             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_5_PSLS(2)
            -9             7       -8.9974             0         0.001             1         -2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_1_PSLS(2)
            -9             7      -2.00207             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_2_PSLS(2)
            -9             7            -1             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_3_PSLS(2)
            -9             7      -1.21554             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_4_PSLS(2)
            -9             7      -3.33142             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_5_PSLS(2)
# 3   PSFS LenSelex
             0             0             0             0             0             0        -99          0          0          0          0        0.5          0          0  #  SizeSpline_Code_PSFS(3)
        -0.001             1      0.124887             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradLo_PSFS(3)
            -1         0.001     -0.338698             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradHi_PSFS(3)
             1             1       23.1313             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_1_PSFS(3)
             1             1       44.1442             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_2_PSFS(3)
             1             1       48.4634             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_3_PSFS(3)
             1             1       54.7779             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_4_PSFS(3)
             1             1       71.2972             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_5_PSFS(3)
            -9             7      -8.99994             0         0.001             1         -2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_1_PSFS(3)
            -9             7      -1.80697             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_2_PSFS(3)
            -9             7            -1             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_3_PSFS(3)
            -9             7      -1.44411             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_4_PSFS(3)
            -9             7      -2.21041             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_5_PSFS(3)
# 4   Other LenSelex
             0             0             0             0             0             0        -99          0          0          0          0        0.5          0          0  #  SizeSpline_Code_Other(4)
        -0.001             1      0.127253             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradLo_Other(4)
            -1         0.001     -0.177681             0         0.001             1          3          0          0          0          0        0.5          0          0  #  SizeSpline_GradHi_Other(4)
             1             1       22.5552             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_1_Other(4)
             1             1       44.2844             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_2_Other(4)
             1             1       51.4468             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_3_Other(4)
             1             1       58.8149             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_4_Other(4)
             1             1       72.4351             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Knot_5_Other(4)
            -9             7      -5.29627             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_1_Other(4)
            -9             7      -1.79726             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_2_Other(4)
            -9             7            -1             0             0             0        -99          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_3_Other(4)
            -9             7     -0.822423             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_4_Other(4)
            -9             7     -0.891891             0         0.001             1          2          0          1       2004       2008         -4          0          0  #  SizeSpline_Val_5_Other(4)
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
 -20 20 -1.78708  0 99 1 1 0 0 0 0 0 0 0 # TG_report_fleet:_1
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
#      1    21     1     0     0     0     0     1     1  1983  2015     5 0.00140362 0.0362425 -0.00433623 0.00168922 0.0300173 0.032647 0.127325 -0.0165464 0.198305 0.0112942 -0.00346475 0.0962458 -0.0694639 -0.0221936 0.11272 -0.0106793 0.121483 0.0483441 -0.188103 0.0840625 -0.033095 -0.191932 -0.0177695 0.0396298 0.0672564 0.375032 -0.0779169 -0.0204193 0.165754 0.0804789 0.0631648 0.00448791 -0.00810419
#      1    22     3     0     0     0     0     2     1  1983  2015     5 -0.000231323 0.000518648 -0.000603725 -0.00306884 0.00197946 -0.00288436 0.00189383 0.00464869 -0.0115755 0.00761105 0.00141215 -0.00648275 0.00681762 -0.0038005 0.00460371 0.0193182 -0.0012872 0.000770405 0.0183353 -0.0167657 -0.000178104 0.00432888 -0.00888534 -0.00179318 -0.00511091 -0.0129843 0.012815 -0.0114571 -0.014319 0.00719153 0.00617686 -0.00387325 0.00510674
#      1    23     5     0     0     0     0     3     1  1983  2015     5 -0.00362084 0.0381617 0.00353471 0.00413317 0.0121846 0.0869655 0.103985 -0.0992849 0.324791 -0.0146261 -0.0485192 0.236167 -0.151398 0.106177 0.153105 -0.144452 0.245682 -0.0140668 -0.235535 0.0896457 -0.0473291 -0.293319 0.0508178 0.0869067 0.098895 0.61592 -0.182807 0.0262834 0.185183 0.148138 -0.0375991 0.117632 0.0387213
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

