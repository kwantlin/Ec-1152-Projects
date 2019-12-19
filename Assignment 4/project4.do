
clear
set more off
cap log close

log using "/Users/kwantlin/My Documents/Harvard 2018-2019/Econ 1152/Project 4/Project_4_Log_File.smcl", replace
*** Empirical Project 4

* change directories
cd "/Users/kwantlin/My Documents/Harvard 2018-2019/Econ 1152/Project 4"



* start log
log close
log using project3.log, replace

* use given dataset
use atlas_training.dta, clear


* import google dataset
import delimited "export(2013).csv", clear
rename county* * 

* merge datasets
merge 1:1 geoid using atlas_training.dta, gen(mtrain)

*rename rates
rename personageyears5onwardsnati foreignborn
rename housingunitoccupancystatus owneroccupied
rename personageyears18onwardsarm veteran
rename personageyears25onwardsedu hscompletion
rename personplaceofbirthborninst borninst
rename personageyears15onwardsmar married
rename personpovertystatusbelowpo belowpoverty
rename persongenderfemale female
rename personraceusc_twoormorerac twoormorerac
* more than 75k income
rename personageyears15onwardsinc inc_75plus

replace foreignborn = foreignborn/pop
replace veteran = veteran/pop
replace hscompletion = hscompletion/pop
replace borninst = borninst/pop
replace married = married/pop
replace belowpoverty = belowpoverty/pop
replace female = female/pop
replace twoormorerac = twoormorerac/pop
replace owneroccupied = owneroccupied/housing
replace inc_75plus = inc_75plus/pop

save project4.dta, replace

sum foreignborn veteran hscompletion borninst married belowpoverty female twoormorerac owneroccupied inc_75plus kfr_pooled_p25 if !(missing(kfr_pooled_p25))
reg kfr_pooled_p25 foreignborn veteran hscompletion borninst married belowpoverty female twoormorerac owneroccupied inc_75plus, robust

reg kfr_pooled_p25 foreignborn veteran hscompletion borninst married belowpoverty female twoormorerac owneroccupied inc_75plus P_*, robust
predict predkfr_pooled_p25
merge 1:1 geoid using atlas_test.dta, gen(mergetest)
gen pred_error = kfr_actual - predkfr_pooled_p25
sum pred_error

* prep for Stata
order geoid place pop housing kfr_pooled_p25 test training predkfr_pooled_p25 mtrain

*Drop counties not in training and not in test data
drop if training == .


*Save data file
save project4.dta, replace



use proj4_results.dta, clear
gen pred_error_OLS = kfr_pooled_p25 - predictions_ols
gen mse_OLS = pred_error_OLS^2
sum mse_OLS if training == 1

gen pred_error_tree = kfr_pooled_p25 - predictions_tree
gen mse_tree = pred_error_tree^2
sum mse_tree if training == 1

gen pred_error_forest = kfr_pooled_p25 - predictions_forest
gen mse_forest = pred_error_forest^2
sum mse_forest if training == 1


save project4withmse.dta, replace

use proj4_results.dta, clear


merge 1:1 geoid using atlas_test.dta
gen pred_error_OLS_test = kfr_actual - predictions_ols
gen mse_OLS_test = pred_error_OLS_test^2
sum mse_OLS_test if test == 1

gen pred_error_tree_test = kfr_actual - predictions_tree
gen mse_tree_test = pred_error_tree_test^2
sum mse_tree_test if test == 1

gen pred_error_forest = kfr_pooled_p25 - predictions_forest
gen mse_forest = pred_error_forest^2
sum mse_forest if test == 1

* This is an example to visilize the difference. 

twoway (scatter kfr_pooled_p25 predictions_ols if training == 1) (lfit kfr_pooled_p25  predictions_ols if training == 1), legend(off) graphregion(color(white)) bgcolor(white) ytitle("Actual") xtitle("Predicted from OLS regression")

twoway (scatter kfr_pooled_p25 predictions_tree if training == 1) (lfit kfr_pooled_p25  predictions_tree if training == 1), legend(off) graphregion(color(white)) bgcolor(white) ytitle("Actual") xtitle("Predicted from Tree regression")

twoway (scatter kfr_pooled_p25 predictions_forest if training == 1) (lfit kfr_pooled_p25  predictions_forest if training == 1), legend(off) graphregion(color(white)) bgcolor(white) ytitle("Actual") xtitle("Predicted from Forest regression")


log close
