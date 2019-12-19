

clear
set more off
cap log close

log using "/Users/kwantlin/My Documents/Harvard 2018-2019/Econ 1152/Project 3/Project_3_Log_File.smcl", replace

use "/Users/kwantlin/Downloads/cmto.dta"

*Report control group means
sum hoh_age child_count child_age hh_income origin_pop2010 if treatment_group == 0

cap rm table1.txt
cap rm table1.xls

*Run regressions for balance test
foreach var in hoh_age child_count child_age hh_income origin_pop2010{
reg `var' treatment_group pha, r
outreg2 using table1.xls, symbol(**, *, +)

}


*Estimate compliance rate for the CMTO experiment
reg received_cmto_services treatment_group pha, r
local pi = _b[treatment_group]

*Estimate ITT
reg leased_up_opp treatment_group pha, r
local alpha = _b[treatment_group]

*Estimate TOT
*Method 1
display `alpha'/`pi'

*Draw graph of distribution of the change in neighborhood quality
gen change = forecast_kravg30_p25 - origin_forecast_kravg30_p25 

twoway (kdensity change if treatment_group == 1,  lwidth(thick)) (kdensity change if treatment_group == 0), xtitle("Change in Neighborhood Quality") ytitle("Density") graphregion(color(white)) bgcolor(white) legend(order(1 "Treatment Group" 2 "Control Group")) 

graph save Graph "/Users/kwantlin/My Documents/Harvard 2018-2019/Econ 1152/Project 3/Graph2.gph", replace

*Heterogeneity in ITT
*(i) family income above the median in the sample and below the median in the sample; 

sum hh_income, d
gen abovemedian = (hh_income>r(p50)) & !missing(hh_income)

ivregress 2sls leased_up_opp (received_cmto_services = treatment_group) pha if abovemedian == 1, r
outreg2 using table2.xls, symbol(**, *, +) replace ctitle(above median)
ivregress 2sls leased_up_opp (received_cmto_services = treatment_group) pha if abovemedian == 0 , r
outreg2 using table2.xls, symbol(**, *, +) ctitle(below median)

*(ii)	Each Public Housing Authority separately (KCHA and SHA)
ivregress 2sls leased_up_opp (received_cmto_services = treatment_group) if  pha == 1, r
outreg2 using table2.xls, symbol(**, *, +) ctitle(pha1)
ivregress 2sls leased_up_opp (received_cmto_services = treatment_group) if  pha == 0 , r
outreg2 using table2.xls, symbol(**, *, +) ctitle(pha0)

log close



