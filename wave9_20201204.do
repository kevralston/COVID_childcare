 
STOP 
 
*** UKRI Childcare and Wellbeing in Times of Covid-19: Developing crisis-resilient care solutions.

*** Kevin Ralston 31/10/2020

*** Sean Connery died today, aged 90 years old. James Bond, 007. 
*** 08/11/2020 Joe Biden was called in the US election yesterday

*** cd_indresp_w = July [understanding society]caring module

*** C:\Users\kralsto2\OneDrive - University of Edinburgh\Datasets\Covid_Childcare\8644stata_9C4C43CB8B3E0A356D3B6C3E074258AD_V1\UKDA-8644-stata\stata\stata13_se

clear

global path1 "M:\Data_analysis\Covid_Childcare\8644stata_9C4C43CB8B3E0A356D3B6C3E074258AD_V1\UKDA-8644-stata\stata\stata13_se"
 /*path to the main extract */

*** The M:/ drive has dissapeared. need an alternative path to the data

global path1temp "C:\DataTemp_20201108\stata13_se" 

***

global path2temp "C:\DataTemp_20201108\ukhls_w9"

*** path to wave 9 data

*******************************************************************************

* https://www.mentalhealth.org.uk/our-work/research/coronavirus-mental-health-pandemic
* average mental health may not be getting too worse 

* I think I want to begin with a dataset of 'protected characteristics' from wave 9
* The main dataset
* That can be the baseline

* Ethnicity - single parent - Underlying health issues (parents or children ADHD
* Socioeconomics - dual earner families - keyworkers - urban-rural

* Maybe use the Ethnic Minority Boost * 6,000 adults from all ethnic minority groups

/*

* ethn_dv	Ethnic group (derived from multiple sources)	indresp, indall, youth, xwavedat	1, 2, 3, 4, 5, 6, 7, 8, 9
* plbornc_all	country of birth	indresp, xwavedat	1, 2, 3, 4, 5, 6, 7, 8, 9
* racel	ethnic group	indresp	1, 2, 3, 4, 5, 6, 7, 8, 9
racelat	asian ethnic group ti	indresp	3, 4, 5, 6, 7, 8, 9
racelbt	black ethnic group ti	indresp	3, 4, 5, 6, 7, 8, 9
racelmt	mixed ethnic group ti	indresp	3, 4, 5, 6, 7, 8, 9
racelo_code	specific code for generic ethnic groups	indresp	1, 2, 3, 4, 5, 6, 7, 8, 9
racelot_code	specific code for other ethnic groups	indresp	3, 4, 5, 6, 7, 8, 9
racelt	ethnic group ti	indresp	3, 4, 5, 6, 7, 8, 9


* single parent 
* absparnam	Absent parent identifier	chmain	5, 7, 9
* exsame	whether all children have same absent parent	indresp	3, 5, 7, 9
* marstat_dv	Harmonised de facto marital status	indresp, indall, child	1, 2, 3, 4, 5, 6, 7, 8, 9
* mastat_dv	De facto marital status	indresp, indall	1, 2, 3, 4, 5, 6, 7, 8, 9
* ndepchl_dv	Number of own dependent children in household	indall, indresp	1, 2, 3, 4, 5, 6, 7, 8, 9

	** UNDERLYING HEALTH ISSUES **

* health	long-standing illness or impairment	indresp	1, 2, 3, 4, 5, 6, 7, 8, 9
sf1	general health	indresp	9, 8, 7, 6, 5, 4, 3, 2, 1, BH14, BH09
scsf1	general health	indresp	9, 8, 7, 6, 5, 4, 3, 2
hcondno1	health cond no. 1: health condition number	indresp	2, 3, 4, 5, 6, 7, 8, 9
hconds01	still have health conditions	indresp	1, 3, 4, 5, 6, 7, 8, 9
sclfsat1	Satisfaction with health	indresp	1, 2, 3, 4, 5, 6, 7, 8, 9

* 	Urban Rural 

urban_dv	Urban or rural area, derived	indall, hhresp, indresp, child, hhsamp, youth	1, 2, 3, 4, 5, 6, 7, 8, 9

* Employment status

jbstat	Current labour force status	indresp	1, 2, 3, 4, 5, 6, 7, 8, 9, 10,


*/

** hh composition
* https://www.understandingsociety.ac.uk/documentation/mainstage/dataset-documentation/search/term/household-composition

*****  things we want to know ******
* what group is most affected?
* How are parents' organising childcare? How has this changed?
* Typology of childcare

*************************************

* Wave 9

use $path2temp\i_indresp, clear


keep i_ethn_dv i_ppno i_ndepchl_dv i_marstat_dv i_health i_sclfsat1  i_scsf1 ///
		i_urban_dv i_jbiindb_dv i_jbnssec8_dv pidp i_scghq1_dv i_scghq2_dv i_jbstat
 
*************************************
* Ethnic Group

tab i_ethn_dv 

*************************************
* Marital Status - to derive single parents

tab i_ppno

tab i_ndepchl_dv

numlabel i_marstat_dv, add

tab i_marstat_dv

tab i_ndepchl_dv if i_marstat_dv>=3 & i_ndepchl_dv>0

tab i_marstat_dv i_ndepchl_dv if i_marstat_dv>=3 & i_ndepchl_dv>0

** 1237 children in 'single' households.
** need to check this on the household grid

*************************************
* Health

* longstanding illness or disability
tab i_health


* satisfaction with health 
tab i_sclfsat1

* general health 
tab i_scsf1

*************************************
* 	Urban Rural 

tab i_urban_dv

***** Dual earner families **********

* employ	in paid employment	indresp, indall	1, 2, 3, 4, 5, 6, 7, 8, 9
* ff_emplw	whether in paid employment at previous wave	indresp	2, 3, 4, 5, 6, 7, 8, 9
* jbsemp	employee or self-employed	indresp	1, 2, 3, 4, 5, 6, 7, 8, 9, 
* jbsempchk	employed or self-employed check	indresp	2, 3, 4, 5, 6, 7, 8, 9
* jbstat	Current labour force status	indresp	1, 2, 3, 4, 5, 6, 7, 8, 9,

******************** Keyworkers ********************

/*

https://www.gov.scot/publications/coronavirus-covid-19---key-workers-definition-and-status-letter-from-cabinet-secretary-and-cosla/
https://www.gov.uk/government/publications/coronavirus-covid-19-maintaining-educational-provision/guidance-for-schools-colleges-and-local-authorities-on-maintaining-educational-provision
https://www.gov.uk/government/statistics/key-workers-population-and-characteristics-2019
https://www.ons.gov.uk/employmentandlabourmarket/peopleinwork/earningsandworkinghours/articles/coronavirusandkeyworkersintheuk/2020-05-15

special license 4 digit SOC

j2soc00	Second current job: SOC 2000	indresp	1, 2, 3, 4, 5, 6, 7, 8, 9,

j2soc10	2nd current job: SOC 2010	indresp	1, 2, 3, 4, 5, 6, 7, 8, 9

****** NS-SEC

jbiindb_dv	Current job: Industrial classification (CNEF), two digits	indresp	1, 2, 3, 4, 5, 6, 7, 8, 9

jbnssec8_dv	Current job: Eight Class NS-SEC	indresp	1, 2, 3, 4, 5, 6, 7, 8, 9,

jbnssec_dv Current job: NS-SEC (detailed)	indresp	1, 2, 3, 4, 5, 6, 7, 8, 9,

I think this is as good as we can do with these data at the moment. Need the SOCs

*/


numlabel i_jbiindb_dv, add

tab i_jbiindb_dv

* key worker      - 
* non key worker  - 1 

tab i_jbnssec8_dv

save $path1temp\mergefile1, replace

*					Documented syntax to match individuals 

/*****************************************************************************************
* MATCHING INDIVIDUALS WITHIN A HOUSEHOLD                                                *
* In this example we will match the information of respondents living with               *
* partners/spouses onto that of their partners/spouses.                                  *
*****************************************************************************************/


// Open data file for all enumerated individuals and select the 
// variables for which you want to create a spouse/partner version

* use a_hidp a_pno a_ppno a_sex_dv a_age_dv using "$ukhls/ukhls_w1/a_indall", clear

use $path2temp\i_indresp, clear

keep i_hidp i_pno i_ppno i_employ 


// Restrict to individuals who have a spouse/partner in the household
// If an individual does not have a partner then a_ppno will be 0,
// if they do have a partner then a_ppno is the pno of their partner
keep if i_ppno>0

// rename all individual characteristics to something that would indicate
// the characteristics refer to the spouse/partner. Here the prefix sp_
// before the variable stem name and preserve the wave prefix
rename i_* i_sp_*

// rename the spouse/partner pno variable to respondent pno for matching to their partner
rename i_sp_ppno i_pno

// rename the hidp back to a_hidp  
rename i_sp_hidp i_hidp

// drop the variable a_sp_pno as it is no longer needed
drop i_sp_pno 

// save the file temporarily
save $path1temp\tmp_spinfo, replace


	*/

********************************************************************************


// reopen data file for all enumerated individuals and keep the same set of variables

use $path2temp\i_indresp, clear

keep i_hidp i_pno i_ppno i_employ pidp

// restrict the variables to individuals who have a spoise/partner in the household
keep if i_ppno>0

// merge the data with the data relating to the spouse/partner, using
// a_hidp and a_pno as linking variables. Note that there SHOULD NOT BE
// any non-matching records, that is, the value of _merge=3 

merge 1:1 i_hidp i_pno using $path1temp\tmp_spinfo

// drop the merge variable otherwise future merges will not work

tab _merge

keep if _merge==3

drop _merge

// save the data file
save $path1temp\spinfo, replace 

// clean up unwanted files
erase $path1temp\tmp_spinfo.dta

numlabel i_employ, add

*** dual earner variable 

tab i_employ i_sp_employ

/* 1 dual worker household 2 single worker household 3 no worker household */

capture drop dual_wrk
gen dual_wrk=.
replace dual_wrk=1 if i_employ==1 & i_sp_employ==1 									/* two earners */
replace dual_wrk=2 if i_employ==1 & i_sp_employ==2 | (i_employ==2 & i_sp_employ==1) /* single earners */
replace dual_wrk=3 if i_employ==2 & i_sp_employ==2  								/* no worker */


tab dual_wrk, miss

merge 1:1 pidp  using "$path1temp\mergefile1"

* save wave9 data

drop _merge



save $path1temp\wave9_1.dta, replace 


********************************************************************************

*********************** COVID 19 Data Waves ************************************

********************************************************************************

				***	*** *** *** *** *** *** *** *** *** 	

use $path1temp\cd_indresp_w, clear

keep pidp cd_scghq1_dv cd_scghq2_dv cd_parent015 cd_betaindin_xw psu cd_age ///
	cd_carehhwho1 cd_aidnum cd_aidhrs_cv cd_hungry_cv cd_foodbank_cv cd_blfoodbank ///
	cd_sclfsato_cv  cd_hungrywhy1  cd_hungrywhy2  cd_hungrywhy3  cd_hungrywhy4  cd_cutmeals ///
	cd_ff_furlough cd_sex_cv cd_parent0plus cd_parent5plus cd_parent015 cd_parent1619 cd_parent511 ///
	cd_parent1217 cd_parent015 ///
	cd_carehhnow1  cd_carehhnow2  cd_carehhnow3  cd_carehhnow4  cd_carehhnow5  cd_carehhnow6  cd_carehhnow7  cd_carehhnow8 ///
	cd_wah cd_blbenefitsb651 ///
	cd_chsdpf_cv_childa cd_chsdpf_cv_childb cd_chsdpf_cv_childc cd_chsdpf_cv_childd  cd_chsdpf_cv_childe ///
	cd_chsdtt_cv_childa cd_chsdtt_cv_childb cd_chsdtt_cv_childc cd_chsdtt_cv_childd  cd_blwork cd_sempgovt cd_ff_furlough
	

merge 1:1 pidp  using "$path1temp\wave9_1"	

keep if _merge==3

drop _merge

save $path1temp\covid_2.dta, replace 

										***	

******************** ******************** ******************** ********************


	******************** ******************** ******************** ********************
	******************** ******************** ******************** ********************
	******************** ******************** ******************** ********************
	******************** ******************** ******************** ********************
	******************** ******************** ******************** ********************

	
*								ANALYSIS	
	
	
use $path1temp\covid_2, clear
	

*** is the strata the psu var, or the strata variable?

*** with strata
* svyset psu [pweight = cd_betaindin_xw], strata(strata)

*** without strata
svyset psu [pweight = cd_betaindin_xw]


*** individual person weight

* cd_betaindin_xw

numlabel _all, add 

tab cd_scghq2_dv
tab cd_scghq1_dv, miss

mvdecode cd_scghq1_dv, mv(-9)

mvdecode i_scghq1_dv, mv(-9 -8 -7)

tab i_scghq1_dv


* General Health Questionnaire
* https://www.gl-assessment.co.uk/products/general-health-questionnaire-ghq/


** HIGH GHQ = BAD


* wave 9 GHQ compared to COVID wave d (july) GHQ

twoway (scatter i_scghq1_dv cd_scghq1_dv if cd_scghq1_dv>=0) (lfitci i_scghq1_dv cd_scghq1_dv if cd_scghq1_dv>=0) ,

twoway (scatter i_scghq1_dv cd_scghq1_dv if cd_scghq1_dv>=0) ///
			(lfitci i_scghq1_dv cd_scghq1_dv if cd_scghq1_dv>=0 & cd_parent015==1) /// 
			(lfitci i_scghq1_dv cd_scghq1_dv if cd_scghq1_dv>=0 & cd_parent015==2)
			



	******************** ******************** ******************** ********************
	******************** ******************** ******************** ********************
	******************** ******************** ******************** ********************
	******************** ******************** ******************** ********************
	******************** ******************** ******************** ********************
		
	
*** https://www3.uef.fi/documents/276286/457404/PaananenDataAnalysisInLongitudinalStudies/20b11c4e-fbc6-4547-a8b1-1624bf9da2a1	

/* 

Possible solutions:
• Use a statistical model that allows for adjustment of covariates, and add
baseline value as a covariate in the model
• Instead of deltas, use percentage changes (e.g. 9% and 22% instead of 10 kg)

	*/

* generate Delta: end measurement - start measurement

* on GHS low is good high is bad

* so on Delta a minus score is GOOD becuase you're scoring lower in July 2020
* than you were in wave 9 during 2019

* e.g.    10 - 11 = -1  **** 10 in july 2020 - 11 in 2019
	
* Therefore positive score is BAD because you're scoring higher in July 2020
* Than you were in wave 9 2019
 
* e.g. 20 - 15 = 5 **** 20 in july 2020 - 15 in 2019
	
* a score close to zero is NEUTRAL between time points
* a score lower than zero is GOOD
* a score above zero is BAD

gen delta = cd_scghq1_dv - i_scghq1_dv

hist delta, note("n=12,347, mean=0.63, sd=5.5, range -30 to 30" "Source: UKHLS, cross-sectional weight applied") title("Delta") ///
			scheme(s1mono)

tab delta
svy: mean delta
summ delta

asdoc svy: ttest delta, by(cd_parent015) save(C:\Users\kralsto2\Stata_outputs_temp\table1_20201207.doc) append

*** it can be seen people are scoring slightly lower on average in 2020 
*** the mean is 0.56, slightly above zero (i.e. worse)
*** the SD is 5.5


*** this var codes anyone scoring at leat 5 higher on Delta as scoring 1 rest=0

capture drop SDworse    /* ~ 1 standard deviation above the mean */

gen SDworse=.
replace SDworse=0 if delta<=4
replace SDworse=1 if delta>=5

label define SDworsel 0 "OK" 1"5|> Worse than 2019" 
label values SDworse SDworsel	

asdoc tab SDworse, save(C:\Users\kralsto2\Stata_outputs_temp\table1_20201207.doc) append

svy: tab SDworse 

***************************************************************************************

*** This var codes up anyone scoring worse at all than 2019 as scoring 1 rest=0

capture drop worse anyone doing worse than 2019 coded 1
gen worse=.
replace worse=0 if delta<=1
replace worse=1 if delta==0
replace worse=2 if delta>=1

label define worsea 0"Better than 2019" 1"neutral" 2"Worse than 2019" 
label values worse worsea	

tab worse

***************************** percentage change ***************************************

*  (((2020GHQ / 2019GHQ)-1)*100)

*  (((cd_scghq1_dv / i_scghq1_dv)-1)*100)


* +ve percent is a percentage incease = BAD
* -ve percent is a percentage decrease = GOOD


*** there is a large right skew in this 
*** possible transformations http://fmwww.bc.edu/repec/bocode/t/transint.html


capture drop percent1
gen percent1 = (((cd_scghq1_dv / i_scghq1_dv)-1))

hist percent1

tab percent1
mean percent1
summ percent1

*** the average person is scoring 17% worse (higher on GHQ in July 2020) compared to 2019

hist percent1

list pidp percent1 delta i_scghq1_dv cd_scghq1_dv percent1 if percent1>499 & percent1!=.

* this is hideously right skewed

**********************************  Cube root

* try a cube root transformation x^(1/3)

gen cube_root=percent1^(1/3)

hist cube_root

* looks like a zero inflated Poisson.  https://stats.idre.ucla.edu/stata/dae/zero-inflated-poisson-regression/
* still supstantially right skewed

**********************************  Square root

gen sq_root=percent1^(1/2)

hist sq_root

* still right skewed
* inevitibly zero inflates


**********************************  

gen percent2 = sqrt(percent1) - sqrt(100-percent1)  


hist percent2

mean percent2
summ percent2

***************************************************************************************

	******************** ******************** ******************** ********************
	******************** ******************** ******************** ********************
	******************** ******************** ******************** ********************
	******************** ******************** ******************** ********************
	******************** ******************** ******************** ********************

	***** ***** ***** ***** ***** *****  Analysis
	
* Ethnicity - single parent - Underlying health issues (parents or children ADHD
* Socioeconomics - dual earner families - keyworkers - urban-rural	
	
* urban-rural
	
mvdecode i_urban_dv, mv(-9)
	
tab i_urban_dv

tab i_urban_dv SDworse, row chi V

asdoc svy: tab i_urban_dv SDworse, row save(C:\Users\kralsto2\Stata_outputs_temp\table1_20201207.doc) append
svy: tab i_urban_dv SDworse, row    /* svy doesn't seem to work with ASDOC */

**** No differences in Delta change in wellbeing by Urban Rural 	

tab cd_parent015

tab i_urban_dv SDworse if cd_parent015==1, row chi V
tab i_urban_dv SDworse if cd_parent015==2, row chi V


*** small difference in GHQ
ttest cd_scghq1_dv, by(i_urban_dv)


*** no difference on delta
ttest delta, by(i_urban_dv)

ttest delta if cd_parent015==1, by(i_urban_dv)
ttest delta if cd_parent015==2, by(i_urban_dv)


	******************** ******************** ******************** ********************	

	* ANOVA
* https://www.stata.com/support/faqs/statistics/compare-levels-of-categorical-variable/	
	
* occupational position

tab i_jbiindb_dv , miss
tab i_jbnssec8_dv , miss	

* NS-SEC

mvdecode i_jbnssec8_dv, mv(-9 -8)
table i_jbnssec8_dv, contents(mean delta)

anova delta i_jbnssec8_dv
	
* regress

* not much going on here. The Lower Supervisory Category is a stand out *

regress delta ibn.i_jbnssec8_dv, noconstant

svy: regress delta ib6.i_jbnssec8_dv, 
svy: regress delta ib1.i_jbnssec8_dv, 

********************************

tab i_jbiindb_dv , miss

mvdecode i_jbiindb_dv, mv(-9 -1)
table i_jbiindb_dv, contents(mean delta)

anova delta i_jbiindb_dv

svy: regress delta ibn.i_jbiindb_dv, noconstant
svy: regress delta ib0.i_jbiindb_dv, 

** nothing much going on but some small differences

* lets check the any influence of furlough

tab cd_ff_furlough, miss
mvdecode cd_ff_furlough, mv(-8)

ttest delta, by(cd_ff_furlough)

** delta

ttest delta if cd_parent015==1, by(cd_ff_furlough)
ttest delta if cd_parent015==2, by(cd_ff_furlough)

** GHQ july 2020

ttest cd_scghq1_dv if cd_parent015==1, by(cd_ff_furlough)
ttest cd_scghq1_dv if cd_parent015==2, by(cd_ff_furlough)

** nearly nothing in terms  of well being on furlough

svy: regress delta i.cd_ff_furlough ib1.i_jbnssec8_dv i.cd_parent015 i.i_urban_dv cd_age i.cd_sex, 
svy: regress delta i.cd_ff_furlough i.cd_parent015##c.cd_age i.i_urban_dv  , 
svy: regress delta i.cd_ff_furlough i.i_urban_dv if cd_parent015==1, 

svy: logit SDworse i.cd_ff_furlough ib2.cd_parent015#i.cd_sex i.i_urban_dv cd_age i.cd_sex, or

svy: logit SDworse i.cd_ff_furlough ib2.cd_parent015 i.i_urban_dv c.cd_age if (cd_age>=30& cd_age<=55), or

asdoc svy: logit SDworse i.cd_ff_furlough ib2.cd_parent015 i.i_urban_dv, ///
			save(C:\Users\kralsto2\Stata_outputs_temp\table1_20201207.doc) append

svy: logit SDworse i.cd_ff_furlough  i.i_urban_dv ib1.i_jbnssec8_dv if cd_parent015==1, 

	******************** ******************** ******************** ********************	

** ANOVA Analysis DELTA

label define dual_wrkl 1 "Dual" 2"Single" 3"None"
label values dual_wrk dual_wrkl	
	
tab dual_wrk		

anova cd_scghq1_dv dual_wrk

table dual_wrk, contents(mean cd_scghq1_dv)
	
anova delta dual_wrk

 table dual_wrk, contents(mean delta)

** ANOVA Analysis Percentage change +ve percentage = BAD

anova percent1 dual_wrk

table dual_wrk, contents(mean percent1)


** Chi-square Analysis

table dual_wrk, contents(mean i_scghq1_dv)
tab dual_wrk SDworse, row chi V gamma


svy: logit SDworse i.cd_ff_furlough ib2.cd_parent015 i.i_urban_dv cd_age i.dual_wrk, 

********************************************************************************

table cd_sex_cv, contents(mean delta)



********************************************************************************

*		WAVE 9 Variables

* 		i_ethn_dv i_ppno i_ndepchl_dv i_marstat_dv i_health i_sclfsat1  i_scsf1 ///
*		i_urban_dv i_jbiindb_dv i_jbnssec8_dv pidp i_scghq1_dv i_scghq2_dv

***** ***** ***** ***** ***** ***** ********** ***** ***** ***** ***** ***** *****
***** ***** ***** ***** ***** ***** ********** ***** ***** ***** ***** ***** *****
***** ***** ***** ***** ***** ***** ********** ***** ***** ***** ***** ***** *****

* Ethnicity - i_ethn_dv

tab i_ethn_dv, miss
mvdecode i_ethn_dv, mv(-9)
asdoc svy: table i_ethn_dv, contents(mean delta) save(C:\Users\kralsto2\Stata_outputs_temp\table1_20201207.doc) append

asdoc table i_marstat_dv, contents(mean delta) save(C:\Users\kralsto2\Stata_outputs_temp\table1_20201207.doc)
asdoc svy: regress delta ibn.i_ethn_dv, noconstant save(C:\Users\kralsto2\Stata_outputs_temp\table1_20201207.doc) append
svy: regress delta ib9.i_ethn_dv, /* setting the Indian group as refernce category */

tab i_ethn_dv SDworse, chi row V
svy: tab i_ethn_dv SDworse, 

anova delta i_ethn_dv

***** ***** ***** ***** ***** ***** ***** 

**** SDworse 1 SD difference
**** this looks like the outcome

svy: logit SDworse i.cd_ff_furlough ib2.cd_parent015 i.i_urban_dv cd_age i.dual_wrk i.i_ethn_dv, 

/* setting the Indian group as refernce category */
svy: logit SDworse i.cd_ff_furlough ib2.cd_parent015 i.i_urban_dv cd_age i.dual_wrk ib19.i_ethn_dv, 

***** ***** ***** ***** ***** ***** *****

*** No significant differences on Delta
svy: regress delta i.cd_ff_furlough ib2.cd_parent015 i.i_urban_dv cd_age i.dual_wrk i.i_ethn_dv,

/* setting the Indian group as refernce category */
svy: regress delta i.cd_ff_furlough ib2.cd_parent015 i.i_urban_dv cd_age i.dual_wrk ib19.i_ethn_dv, 


***** ***** ***** ***** ***** ***** ********** ***** ***** ***** ***** ***** *****
***** ***** ***** ***** ***** ***** ********** ***** ***** ***** ***** ***** *****
***** ***** ***** ***** ***** ***** ********** ***** ***** ***** ***** ***** *****

*- single parent - i_marstat_dv

tab i_marstat_dv, miss
mvdecode i_marstat_dv, mv(-9)
asdoc table i_marstat_dv, contents(mean delta) save(C:\Users\kralsto2\Stata_outputs_temp\table1_20201207.doc)
anova delta i_marstat_dv

svy: regress delta ibn.i_marstat_dv, noconstant
svy: regress delta ib6.i_marstat_dv, 

tab i_marstat_dv SDworse, chi row V
svy: tab i_marstat_dv SDworse, 

***** ***** ***** ***** ***** ***** ***** 

***** ***** ***** ***** ***** ***** ********** ***** ***** ***** ***** ***** *****
***** ***** ***** ***** ***** ***** ********** ***** ***** ***** ***** ***** *****
***** ***** ***** ***** ***** ***** ********** ***** ***** ***** ***** ***** *****

**** SDworse 1 SD difference
**** this looks like the outcome

svy: logit SDworse i.cd_ff_furlough ib2.cd_parent015 i.i_urban_dv cd_age i.i_ethn_dv i.i_marstat_dv i.cd_sex, 

/* setting the Indian group as refernce category */
svy: logit SDworse i.cd_ff_furlough ib2.cd_parent015 i.i_urban_dv cd_age ib9.i_ethn_dv i.i_marstat_dv i.cd_sex, 

***** ***** ***** ***** ***** ***** *****

*** No significant differences on Delta
svy: regress delta i.cd_ff_furlough ib2.cd_parent015 i.i_urban_dv cd_age i.i_ethn_dv i.i_marstat_dv i.cd_sex,

/* setting the Indian group as refernce category */
svy: regress delta i.cd_ff_furlough ib2.cd_parent015 i.i_urban_dv cd_age ib9.i_ethn_dv i.i_marstat_dv i.cd_sex,


*- Underlying health issues (parents or children ADHD - i_health i_sclfsat1
	
tab i_health, miss
mvdecode i_health, mv(-2 -1)
table i_health, contents(mean delta)

**** those with a health issue, same GHQ
**** those without, higher (worse) GHQ

asdoc svy: ttest delta, by(i_health),  save(C:\Users\kralsto2\Stata_outputs_temp\table1_20201207.doc)

svy: regress delta ibn.i_health, noconstant
svy: regress delta i.i_health, 

***** But equally likely to be in the category scoring 5+ worse on GHQ!!!!

tab i_health SDworse, chi row V
svy: tab i_health SDworse, 

**** SDworse 1 SD difference
**** this looks like the outcome

svy: logit SDworse i.cd_ff_furlough ib2.cd_parent015 i.i_urban_dv cd_age i.i_ethn_dv i.i_marstat_dv i.cd_sex i.i_health, 

/* setting the Indian group as refernce category */
svy: logit SDworse i.cd_ff_furlough ib2.cd_parent015 i.i_urban_dv cd_age ib9.i_ethn_dv i.i_marstat_dv i.cd_sex i_health, 

********************************** Satisfaction with health, alternative

tab i_sclfsat1
mvdecode i_sclfsat1, mv(-9 -8 -7 -2 -1)
	
* clear linear effect	
asdoc svy: table i_sclfsat1, contents(mean delta) save(C:\Users\kralsto2\Stata_outputs_temp\table1_20201207.doc)

anova delta i_sclfsat1
	
svy: regress delta ibn.i_sclfsat1, noconstant

** WOW ** check this out
svy: regress delta i.i_sclfsat1,	

********************************

**** differences in health more clear using Delta than the 
	
tab i_sclfsat1 SDworse, chi row V
svy: tab i_sclfsat1 SDworse, 
	
svy: logit SDworse i.cd_ff_furlough ib2.cd_parent015 i.i_urban_dv cd_age i.i_ethn_dv i.i_marstat_dv i.cd_sex i.i_health i.i_sclfsat1, 

/* setting the Indian group as refernce category */
svy: logit SDworse i.cd_ff_furlough ib2.cd_parent015 i.i_urban_dv cd_age ib9.i_ethn_dv i.i_marstat_dv i.cd_sex i_health i.i_sclfsat1, 
	

********************************************************************************
********************************************************************************
	
* Full model so far	
	
asdoc svy: logit SDworse i.cd_ff_furlough ib2.cd_parent015 i.i_urban_dv cd_age i.i_ethn_dv i.i_marstat_dv i.cd_sex i.i_health i.i_sclfsat1, ///
					save(C:\Users\kralsto2\Stata_outputs_temp\table1_20201207.doc) append

svy: logit SDworse i.cd_ff_furlough ib2.cd_parent015 i.i_urban_dv cd_age i.i_ethn_dv i.i_marstat_dv i.cd_sex i.i_health i.i_sclfsat1, or
	
	
********************************************************************************
********************************************************************************

* Employment status

tab i_jbstat, miss

mvdecode i_jbstat, mv(-9 -2 9)
	
tab i_jbstat, miss

** delta

table i_jbstat, contents(mean delta)

anova delta i_jbstat

** delta 2

tab i_jbstat SDworse, chi row V
svy: tab i_jbstat SDworse, 

********************************************************************************
********************************************************************************

tab i_jbstat, miss

capture drop 
gen EA=.
replace EA=1 if i_jbstat==1
replace EA=2 if i_jbstat==2
replace EA=3 if i_jbstat==3
replace EA=4 if i_jbstat==4
replace EA=5 if i_jbstat==5
replace EA=6 if i_jbstat==6
replace EA=7 if i_jbstat==7
replace EA=8 if i_jbstat==8
replace EA=9 if i_jbstat>=9

label define EAa 1"Self Employed" 2"Paid-employment" 3"Unemployed" 4"Retired" ///
			5"On Maternity Leave" 6"Family care or home" 7"FT Student" ///
			8"LT Sick disabled" 9"Something else"
label values EA EAa	

label var EA"Economic Activity"

tab EA

** delta

table EA, contents(mean delta)

anova EA i_jbstat

** delta 2

tab EA SDworse, chi row V
svy: tab EA SDworse, 


* Full model
	
asdoc svy: logit SDworse i.cd_ff_furlough ib2.cd_parent015 i.i_urban_dv cd_age i.i_ethn_dv i.i_marstat_dv i.cd_sex i.i_health i.i_sclfsat1 ///
					i.EA if cd_sex<=2,
					
asdoc svy: regress delta i.cd_ff_furlough ib2.cd_parent015 i.i_urban_dv cd_age i.i_ethn_dv i.i_marstat_dv i.cd_sex i.i_health i.i_sclfsat1 ///
					i.EA
	
**************** interact sex and parent ***************
	
asdoc svy: logit SDworse i.cd_ff_furlough ib2.cd_parent015#i.cd_sex i.i_urban_dv cd_age i.i_ethn_dv i.i_marstat_dv i.i_health i.i_sclfsat1 ///
					i.EA if cd_sex<=2, or
							margins ib2.cd_parent015#i.cd_sex
							marginsplot, scheme(s1mono)
							
							
					
asdoc svy: regress delta i.cd_ff_furlough i.cd_sex#cd_parent015 i.i_urban_dv cd_age i.i_ethn_dv i.i_marstat_dv i.i_health i.i_sclfsat1 ///
					i.EA
					
*** looks like there are substantial gender effects in the logit model
	
	
	
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
	
*** analysis of parents only

tab cd_parent015
	
asdoc svy: logit SDworse i.cd_ff_furlough i.i_urban_dv cd_age i.cd_parent0plus i.cd_parent511 i.i_ethn_dv i.i_marstat_dv i.cd_sex i.i_health i.i_sclfsat1 ///
					i.EA if cd_parent015==1
					
asdoc svy: regress delta i.cd_ff_furlough i.i_urban_dv cd_age i.i_ethn_dv i.i_marstat_dv i.cd_sex i.i_health i.i_sclfsat1 ///
					i.EA if cd_parent015==1	
					

*** kid 0-4

tab cd_parent0plus	

*** some differences by relationship status
	
asdoc svy: logit SDworse i.cd_ff_furlough i.i_urban_dv cd_age i.i_ethn_dv i.i_marstat_dv i.cd_sex i.i_health i.i_sclfsat1 ///
					i.EA if cd_parent0plus==1	
	
	
	
	
	
	
	
	
twoway (scatter ghq_scale cd_scghq1_dv if cd_scghq1_dv>=0) (lfitci ghq_scale cd_scghq1_dv if cd_scghq1_dv>=0) ,

twoway (scatter ghq_scale cd_scghq1_dv if cd_scghq1_dv>=0) ///
			(lfitci ghq_scale cd_scghq1_dv if cd_scghq1_dv>=0 & cd_parent015==1) /// 
			(lfitci ghq_scale cd_scghq1_dv if cd_scghq1_dv>=0 & cd_parent015==2)
			

asdoc regress cd_scghq1_dv i.cd_parent015 ghq_scale if cd_scghq1_dv>=0 & cd_age<60 ///
				, save(M:\Data_analysis\Covid_Childcare\Outputs\reg1_20201111.doc) replace

asdoc svy: regress cd_scghq1_dv cd_age i.cd_sex_cv cd_parent015##c.ghq_scale if cd_scghq1_dv>=0 ///
				, save(M:\Data_analysis\Covid_Childcare\Outputs\reg2_20201111.doc) replace
					
				
*******

* GHQ - high bad low good 

* margins, dydx(read) at(honors=(0 1)) vsquish
* https://stats.idre.ucla.edu/stata/faq/how-can-i-use-the-margins-command-to-understand-multiple-interactions-in-regression-and-anova-stata-11/

tab cd_parent015

mean cd_scghq1_dv if cd_scghq1_dv>=0

summarize cd_scghq1_dv if cd_scghq1_dv>=0, detail

hist cd_scghq1_dv if cd_scghq1_dv>=0, ///
	title("GHQ - July 2020") ///
	note("High score is worse")
	

svy: regress cd_scghq1_dv cd_parent015##c.ghq_scale if cd_scghq1_dv>=0
					margins, dydx(ghq_scale) at(cd_parent015=(1 2)) vsquish	
					margins cd_parent015, at(ghq_scale=(5(5)35)) vsquish
					marginsplot,
					
asdoc svy: regress cd_scghq1_dv cd_age i.cd_sex_cv cd_parent015##c.ghq_scale if cd_scghq1_dv>=0
					margins, dydx(ghq_scale) at(cd_parent015=(1 2)) vsquish	
					margins cd_parent015, at(ghq_scale=(5(5)35)) vsquish
					marginsplot,

					

regress cd_scghq1_dv i.cd_parent015 c.ghq_scale i.cd_parent015#c.ghq_scale if cd_scghq1_dv>=0


********************************************************************************

svy: regress cd_scghq1_dv i.cd_parent015 i.cd_sex_cv if cd_scghq1_dv>=0
					coefplot 

svy: regress cd_scghq1_dv cd_parent015##cd_sex_cv if cd_scghq1_dv>=0					

corr ghq_scale cd_scghq1_dv
mean ghq_scale
mean cd_scghq1_dv if cd_scghq1_dv>=0

tab cd_parent015

mean ghq_scale if cd_parent015==1
mean ghq_scale if cd_parent015==2 

svy: mean cd_scghq1_dv if cd_parent015==1 & cd_scghq1_dv>=0
svy: mean cd_scghq1_dv if cd_parent015==2 & cd_scghq1_dv>=0

ttest cd_scghq1_dv if cd_scghq1_dv>=0, by(cd_parent015)

ttest ghq_scale if cd_scghq1_dv>=0, by(cd_parent015)


* carehhwho [Who caring for inside the household]

tab cd_carehhwho1
tab cd_carehhwho2

* aidhrs_cv [Hours per week spent caring]

tab cd_aidnum

* aidhrs_cv [Hours per week spent caring]

tab cd_aidhrs_cv

* carehhnow [How has care giving changed in household]

tab 

********************

* hungry but didn't eat

tab cd_hungry_cv 

tab1 parent511 parent1217

* 

/*  Never |     13,303       96.72       98.97
Less than four times |         94        0.68       99.66
  Four times or more |         47        0.34      100.00
*/

tab cd_foodbank_cv

* baseline foodbank use

tab cd_blfoodbank

* satifisfaction with life

tab cd_sclfsato_cv

tab cd_hungrywhy1 
tab cd_hungrywhy2 
tab cd_hungrywhy3 
tab cd_hungrywhy4 
tab cd_cutmeals

***********************

* ever on furlough

tab cd_ff_furlough 

***********************

* sex

tab cd_sex_cv

***********************

* Parent 

tab cd_parent0plus 
tab cd_parent5plus 
tab cd_parent015 
tab cd_parent1619 tab cd_parent511 
tab cd_parent1217

* partent of a kid 0-15

tab cd_parent015 

***********************

* some descriptive analysis

* are parents more likely to be hungry and not eat?

tab cd_parent015 cd_hungry_cv if cd_hungry_cv>0, row chi V

* are parents more likely to be cut meals?

tab cd_parent015 cd_cutmeals if cd_cutmeals>0, row chi V

*** no difference 

* are parents more likely to be visit foodbanks?

tab cd_parent015 cd_blfoodbank if cd_blfoodbank >0, row chi V

* on the surface no evidence of parents experiencing more adversity in food than non-parents


**** change in care

tab cd_carehhnow1 
tab cd_carehhnow2 
tab cd_carehhnow3 
tab cd_carehhnow4 
tab cd_carehhnow5 
tab cd_carehhnow6 
tab cd_carehhnow7 
tab cd_carehhnow8 

*** more help

svy: tab cd_parent015 cd_carehhnow3 if cd_carehhnow3 >=0, row 

* of those doing more care, parents not provideing more additional care than non-parents

* what about women?

tab cd_sex_cv cd_carehhnow3 if cd_carehhnow3 >=0, row chi V

* yep, its women. 

tab cd_parent015 cd_carehhnow3 if (cd_carehhnow3 >=0 & cd_sex_cv==2), row chi V 

*** base line trade giving tab cd_blcarehh


**********************************************

* working at home

tab cd_wah

* variables on benefit look poor

tab cd_blbenefitsb651

**********************************************

* child behaviour we don't know what behaviour was like before the pandemic

tab cd_chsdpf_cv_childa 
tab cd_chsdpf_cv_childb 
tab cd_chsdpf_cv_childc 
tab cd_chsdpf_cv_childd 
tab cd_chsdpf_cv_childe

* subjective wellbeing

/* 0 least distressed, 36, most distressed 

Subjective wellbeing (GHQ): Likert  */

tab cd_parent015

tab cd_scghq1_dv 
tab cd_scghq2_dv

ttest cd_scghq1_dv if cd_scghq1_dv>=0 , by(cd_parent015)

ttest cd_scghq2_dv if cd_scghq1_dv>=0 , by(cd_parent015)

* parents more stressed than non-parents. Need to check if this is exasserbated by pandemic, or not

***********************

*** WORK AND FURLOUGH

* BASELINE WORK  or self emloyed - blwork

tab cd_blwork

** furlough

tab cd_parent015 cd_ff_furlough if cd_ff_furlough >=0 & cd_age<=60, row chi V
svy: tab cd_parent015 cd_ff_furlough if cd_ff_furlough >=0 & cd_age<=60, row 

** no divide in gender of furloughed workers

tab cd_sex_cv cd_ff_furlough if cd_ff_furlough >=0, row chi V

* parents are MORE likely to have been furloughed

*\ does this mean parents found it necessary to take furlough or just reflect that parents more likely to have jobs? \* 

** self-employed

tab cd_sempgovt

********************************************************************************

** what predicts parents mental health?

*** subjective wellbeing - low is good, high is BAD. 

tab cd_ff_furlough 
mvdecode cd_ff_furlough, mv(-8)
tab cd_ff_furlough 

gen furlough = cd_ff_furlough + 1
tab furlough


svy: regress cd_scghq1_dv cd_age i.cd_sex if cd_scghq1_dv>=0 & cd_parent015==1

svy: regress cd_scghq1_dv cd_age i.cd_sex i.cd_parent015 if cd_scghq1_dv>=0 
svy: regress cd_scghq1_dv cd_age cd_sex##cd_parent015 if cd_scghq1_dv>=0 

svy: regress cd_scghq1_dv cd_age i.cd_sex i.cd_ff_furlough if (cd_scghq1_dv>=0 & cd_parent015==1 & cd_ff_furlough>=0)
svy: regress cd_scghq1_dv cd_age i.cd_sex i.cd_ff_furlough if (cd_scghq1_dv>=0 & cd_parent015==2 & cd_ff_furlough>=0)

******************************************************************************************** 

*** do you have a kid who has tantrums?

tab cd_chsdtt_cv_childa 
tab cd_chsdtt_cv_childb 
tab cd_chsdtt_cv_childc 
tab cd_chsdtt_cv_childd

gen tantrum = .
replace tantrum = 0 if cd_chsdtt_cv_childa == -8
replace tantrum = 1 if cd_chsdtt_cv_childa == 1 | cd_chsdtt_cv_childb == 1 | cd_chsdtt_cv_childc == 1 | cd_chsdtt_cv_childd == 1
replace tantrum = 2 if cd_chsdtt_cv_childa == 2 | cd_chsdtt_cv_childb == 2 | cd_chsdtt_cv_childc == 2 | cd_chsdtt_cv_childd == 2
replace tantrum = 3 if cd_chsdtt_cv_childa == 3 | cd_chsdtt_cv_childb == 3 | cd_chsdtt_cv_childc == 3 | cd_chsdtt_cv_childd == 3

 svy: tab tantrum if tantrum>0
 tab cd_ff_furlough
 tab tantrum if tantrum>0
 
 svy: regress cd_scghq1_dv i.cd_ff_furlough i.tantrum if tantrum>0 & cd_ff_furlough>=0

 svy: regress cd_scghq1_dv cd_age i.cd_sex ib(0).cd_ff_furlough#ib(3).tantrum

	asdoc svy: regress cd_scghq1_dv cd_age i.cd_sex i.cd_ff_furlough i.tantrum ///
			if (cd_scghq1_dv>=0 & cd_ff_furlough>=0 & tantrum>0) ///
			, save(M:\Data_analysis\Covid_Childcare\Outputs\reg3_20201112.doc) replace
			coefplot

	asdoc svy: regress cd_scghq1_dv cd_age i.cd_sex ib(0).cd_ff_furlough#ib(3).tantrum ///
			if (cd_scghq1_dv>=0 & cd_ff_furlough>=0 & tantrum>0) ///
			, save(M:\Data_analysis\Covid_Childcare\Outputs\reg4_20201112.doc) replace



			* furloughed with children 5-15? happier. Those with tantruming children less happy. 

*******8*******************************************************************************************	
********************************************************************************	

* Main dataset 

* ccare uses childcare	indresp	1, 2, 3, 4, 5, 6, 7, 8, 9
* ccwork	other arrangements for child whilst working	indresp	1, 2, 3, 4, 5, 6, 7, 8, 9
* cmcsanil8	Other parent is potentially violent	indresp	5, 7, 9
* cmnil10	Other parent is abusive or violent	indresp	5, 7, 9
* cmnil11	I don't want contact with my child's other parent	indresp	7, 9
* cmnil12	I don't want my child to have contact with my child's other parent	indresp	7, 9
* cmservice13	National Domestic Violence Helpline	chmain	5, 7, 9
* husits	who is responsible for childcare	indresp	2, 4, 6, 8,
* mlrnot3	I cannot find suitable childcare	indresp	3, 4, 5, 6, 7, 8, 9

*  MOST USED CHILDCARE ARRANGEMENT

/*

mostuse1	Nursery school or nursery class	child	1, 2, 3, 4, 5, 6, 7, 8, 9
mostuse10	Holiday club/scheme	child	1, 2, 3, 4, 5, 6, 7, 8, 9
mostuse11	My ex-husband/wife/partner/the child's non resident parent	child	1, 2, 3, 4, 5, 6, 7, 8, 9
mostuse12	The child's grandparent(s)	child	1, 2, 3, 4, 5, 6, 7, 8, 9
mostuse13	The child's older brother/sister	child	1, 2, 3, 4, 5, 6, 7, 8, 9
mostuse14	Another relative	child	1, 2, 3, 4, 5, 6, 7, 8, 9
mostuse15	A friend or neighbour	child	1, 2, 3, 4, 5, 6, 7, 8, 9
mostuse16	Other nursery education provider	child	1, 2, 3, 4, 5, 6, 7, 8, 9
mostuse17	Other childcare provider	child	1, 2, 3, 4, 5, 6, 7, 8, 9
mostuse2	Special day school, nursery or unit for children with SE needs	child	1, 2, 3, 4, 5, 6, 7, 8, 9
mostuse3	which three used the most: day nursery or creche	child	1, 2, 3, 4, 5, 6, 7, 8, 9
mostuse4	Playgroup or pre-school (including Welsh medium)	child	1, 2, 3, 4, 5, 6, 7, 8, 9
mostuse5	Childminder	child	1, 2, 3, 4, 5, 6, 7, 8, 9
mostuse6	Nanny or au pair or childcarer in the home	child	1, 2, 3, 4, 5, 6, 7, 8, 9
mostuse7	Baby-sitter who comes to your home	child	1, 2, 3, 4, 5, 6, 7, 8, 9
mostuse8	Breakfast club or After school club, on school/nursery site	child	1, 2, 3, 4, 5, 6, 7, 8, 9
mostuse9	Breakfast club or After school club, not on school/nursery site	child	1, 2, 3, 4, 5, 6, 7, 8, 9

* THREE MOST IMPORTANT CHILDCARE

wrkch1a	use same childcare in term and holiday	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch1c	hours of childcare same in term and holiday	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch21	Nursery school or nursery class	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch210	Holiday club/scheme	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch211	My ex-husband/wife/partner/the child's non resident parent	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch212	The child's grandparent(s)	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch213	The child's older brother/sister	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch214	Another relative	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch215	A friend or neighbour	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch216	Other nursery education provider	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch217	Other childcare provider	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch22	Special day school, nursery or unit for children with SE needs	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch23	three most important childcare arrangements: day nursery or creche	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch24	Playgroup or pre-school (including Welsh medium)	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch25	Childminder	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch26	Nanny or au pair or childcarer in the home	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch27	Baby-sitter who comes to your home	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch28	Breakfast club or After school club, on school/nursery site	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch29	Breakfast club or After school club, not on school/nursery site	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch2a0	No childcare/nursery use	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch2a1	Nursery school or class	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch2a10	Holiday club/scheme	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch2a11	Ex/non-res parent	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch2a12	Child's grandparent(s)	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch2a13	Child's older bro/sis	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch2a14	Another relative	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch2a15	A friend or neighbour	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch2a16	Other nursery Ed provider	child	1, 2, 3, 4, 5, 6, 7, 8, 9

* HOURS OF CHILDCARE

wrkch812	hours in child's grandparent(s) during school holidays	child	6, 7, 8, 9
wrkch813	hours in child's older bro/sis during school holidays	child	6, 7, 8, 9
wrkch814	hours in another relative during school holidays	child	6, 7, 8, 9
wrkch815	hours in a friend or neighbour during school holidays	child	6, 7, 8, 9
wrkch816	hours in other nursery ed provider during school holidays	child	6, 7, 8, 9
wrkch817	hours in other childcare provider during school holidays	child	6, 7, 8, 9
wrkch82	hours of childcare used during holidays	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch83	hours of childcare used during holidays	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch84	hours in playgroup or pre-school during school holidays	child	6, 7, 8, 9
wrkch85	hours in childminder during school holidays	child	6, 7, 8, 9
wrkch86	hours in nanny/carer in home during school holidays	child	6, 7, 8, 9
wrkch87	hours in baby-sitter in home during school holidays	child	6, 7, 8, 9
wrkch88	hours in b'fast/after sch club at school/nursery during school holidays	child	6, 7, 8, 9
wrkch89	hours in b'fast/after sch club o/s school/nursery during school holidays	child	6, 7, 8, 9
wrkch31	hours spent in type of childcare	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch310	hours spent in holiday club/scheme	child	6, 7, 8, 9
wrkch311	hours spent in ex/non-res parent	child	6, 7, 8, 9
wrkch312	hours spent in child's grandparent(s)	child	6, 7, 8, 9
wrkch313	hours spent in child's older bro/sis	child	6, 7, 8, 9
wrkch314	hours spent in another relative	child	6, 7, 8, 9
wrkch315	hours spent in a friend or neighbour	child	6, 7, 8, 9
wrkch316	hours spent in other nursery ed provider	child	6, 7, 8, 9
wrkch317	hours spent in other childcare provider	child	6, 7, 8, 9
wrkch32	hours spent in type of childcare	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch33	hours spent in type of childcare	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch34	hours spent in playgroup or pre-school	child	6, 7, 8, 9
wrkch35	hours spent in childminder	child	6, 7, 8, 9
wrkch36	hours spent in nanny/carer in home	child	6, 7, 8, 9
wrkch37	hours spent in baby-sitter in home	child	6, 7, 8, 9
wrkch38	hours spent in b'fast/after sch club at school/nursery	child	6, 7, 8, 9
wrkch39	hours spent in b'fast/after sch club o/s school/nursery	child	6, 7, 8, 9
wrkch81	hours of childcare used during holidays	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch810	hours in holiday club/scheme during school holidays	child	6, 7, 8, 9
wrkch811	hours in ex/non-res parent during school holidays	child	6, 7, 8, 9
wrkch812	hours in child's grandparent(s) during school holidays	child	6, 7, 8, 9
wrkch813	hours in child's older bro/sis during school holidays	child	6, 7, 8, 9
wrkch814	hours in another relative during school holidays	child	6, 7, 8, 9
wrkch815	hours in a friend or neighbour during school holidays	child	6, 7, 8, 9
wrkch816	hours in other nursery ed provider during school holidays	child	6, 7, 8, 9
wrkch817	hours in other childcare provider during school holidays	child	6, 7, 8, 9
wrkch82	hours of childcare used during holidays	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch83	hours of childcare used during holidays	child	1, 2, 3, 4, 5, 6, 7, 8, 9
wrkch84	hours in playgroup or pre-school during school holidays	child	6, 7, 8, 9
wrkch85	hours in childminder during school holidays	child	6, 7, 8, 9
wrkch86	hours in nanny/carer in home during school holidays	child	6, 7, 8, 9
wrkch87	hours in baby-sitter in home during school holidays	child	6, 7, 8, 9
wrkch88	hours in b'fast/after sch club at school/nursery during school holidays	child	6, 7, 8, 9
wrkch89	hours in b'fast/after sch club o/s school/nursery during school holidays	child	6, 7, 8, 9

*/

* 	WHAT DO I WANT?

* 	SOCIOECONOMICS AND CHILDCARE CIRCUMSTANCES BEFORE THE PANDEMIC 
* 	GENERAL HEALTH QUESTIONNAIRE BEFORE, DURING AND AFTER
*	CHILDCARE DURING THE PANDEMIC
*   WHETHER THEY HAVE LOST JOB/ECONOMICS HAVE ALTERED DURING PANDEMIC 

*******************************************************************************

/*

* ghq at wave a

ca_scghqa ca_scghqb ca_scghqc ///
	ca_scghqd ca_scghqe ca_scghqf ca_scghqg ca_scghqh ca_scghqi ca_scghqj ///
	ca_scghqk ca_scghql

* ghq at wave b

cb_scghqa ca_scghqb cb_scghqc ///
	cb_scghqd cb_scghqe cb_scghqf cb_scghqg cb_scghqh cb_scghqi cb_scghqj ///
	cb_scghqk cb_scghql

* ghq at wave c	

cc_scghqa cc_scghqb cc_scghqc ///
	cc_scghqd cc_scghqe cc_scghqf cc_scghqg cc_scghqh cc_scghqi cc_scghqj ///
	cc_scghqk cc_scghql

* ghq at wave d

cd_scghqa cd_scghqb cd_scghqc ///
	cd_scghqd cd_scghqe cd_scghqf cd_scghqg cd_scghqh cd_scghqi cd_scghqj ///
	cd_scghqk cd_scghql

cd_scghq1_dv cd_scghq2_dv


ca_scghq1_dv cb_scghq1_dv cc_scghq1_dv cd_scghq1_dv	
	
*/



********************************************************************************

* This code merges the COVID19 waves 

* I don't know if I need this in the end

/*

global path1temp "C:\DataTemp_20201108\stata13_se" 

use $path1temp\cb_indresp_w, clear

	
/*****************************************************************************************
* MERGING INDIVIDUAL FILES ACROSS WAVES INTO LONG FORMAT                                 *
* To match individual level files across two waves into a long format                    *
* do the following (for more waves add wave specific prefix in the foreach statement)    *
*****************************************************************************************/

*** Loop 1 of the extraction


//loop through each wave
foreach w in a b c d { // For fewer waves use only the wave prefix of the waves you need to merge
	
	// find the wave number
	local waveno=strpos("abcd","`w'")
	
	// open the individual level file
	use pidp psu c`w'_age c`w'_scghq1_dv c`w'_betaindin_xw using "$path1temp/c`w'_indresp_w", clear
	
	// drop the wave prefix from all variables
	rename c`w'_* *
	
	// create a wave variable
	gen wave=`waveno'
	
	// save one file for each wave
	save $path1temp\temp`w', replace
}


// open the file for the first wave (wave a_)

use "$path1temp/tempa", clear


*** Loop 2 of the extraction, linking the data

// loop through the remaining waves
foreach w in b c d {

	// append the files for the second wave onwards
	append using $path1temp/temp`w'
}

// check how many observations are available from each wave
tab wave

// save the long file
save longfile, replace

// erase temporary files
foreach w in a b c d {
	erase $path1temp/temp`w'.dta
}
	
numlabel _all, add
	
tab scghq1_dv	
	
mvdecode scghq1_dv, mv( -9 )

xtset pidp wave

* xtline scghq1_dv didn't run

svyset psu [pweight = betaindin_xw], strata()

svy: mean scghq1_dv, over(wave)


svy: mean scghq1_dv, over(wave)


