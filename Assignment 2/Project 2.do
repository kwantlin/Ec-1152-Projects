
clear
set more off
cap log close

log using "/Users/kwantlin/My Documents/Harvard 2018-2019/Econ 1152/Project 1/Project_2_Log_File.smcl", replace

use "/Users/kwantlin/Downloads/grade5.dta"

*** Question 4 ***
*Part 4A

binscatter classize school_enrollment if inrange(school_enrollment,20,60), rd(40.5) discrete line(lfit) 
graph save Graph "/Users/kwantlin/My Documents/Harvard 2018-2019/Econ 1152/Project 2/Graph1.gph", replace

binscatter classize school_enrollment if inrange(school_enrollment,20,60), rd(40.5) discrete line(qfit)
graph save Graph "/Users/kwantlin/My Documents/Harvard 2018-2019/Econ 1152/Project 2/Graph2.gph", replace
*Quadratic fit seems better for classize.

*Part 4B

binscatter avgmath school_enrollment if inrange(school_enrollment,20,60), rd(40.5) discrete line(lfit)
graph save Graph "/Users/kwantlin/My Documents/Harvard 2018-2019/Econ 1152/Project 2/Graph4B1.gph", replace

binscatter avgmath school_enrollment if inrange(school_enrollment,20,60), rd(40.5) discrete line(qfit)
graph save Graph "/Users/kwantlin/My Documents/Harvard 2018-2019/Econ 1152/Project 2/Graph4B2.gph", replace
*Linear fit seems better for avgmth.

binscatter avgverb school_enrollment if inrange(school_enrollment,20,60), rd(40.5) discrete line(lfit)
graph save Graph "/Users/kwantlin/My Documents/Harvard 2018-2019/Econ 1152/Project 2/Graph4B3.gph", replace

binscatter avgverb school_enrollment if inrange(school_enrollment,20,60), rd(40.5) discrete line(qfit)
graph save Graph "/Users/kwantlin/My Documents/Harvard 2018-2019/Econ 1152/Project 2/Graph4B4.gph", replace
*Linear fit seems better for avgverb.

*Part 4C

binscatter disadvantaged school_enrollment if inrange(school_enrollment,20,60), rd(40.5) discrete line(lfit)
graph save Graph "/Users/kwantlin/My Documents/Harvard 2018-2019/Econ 1152/Project 2/Graph4C1.gph", replace

binscatter disadvantaged school_enrollment if inrange(school_enrollment,20,60), rd(40.5) discrete line(qfit)
graph save Graph "/Users/kwantlin/My Documents/Harvard 2018-2019/Econ 1152/Project 2/Graph4C2.gph", replace
*Linear fit is better for disadvantaged.

binscatter religious school_enrollment if inrange(school_enrollment,20,60), rd(40.5) discrete line(lfit)
graph save Graph "/Users/kwantlin/My Documents/Harvard 2018-2019/Econ 1152/Project 2/Graph4C3.gph", replace

binscatter religious school_enrollment if inrange(school_enrollment,20,60), rd(40.5) discrete line(qfit)
graph save Graph "/Users/kwantlin/My Documents/Harvard 2018-2019/Econ 1152/Project 2/Graph4C4.gph", replace
*Linear fit is better for religious.

binscatter female school_enrollment if inrange(school_enrollment,20,60), rd(40.5) discrete line(lfit)
graph save Graph "/Users/kwantlin/My Documents/Harvard 2018-2019/Econ 1152/Project 2/Graph4C5.gph", replace

binscatter female school_enrollment if inrange(school_enrollment,20,60), rd(40.5) discrete line(qfit)
graph save Graph "/Users/kwantlin/My Documents/Harvard 2018-2019/Econ 1152/Project 2/Graph4C6.gph", replace
*Quadratic fit is better for female.

*Part 4D
collapse (mean) school_enrollment, by(schlcode )
twoway (histogram school_enrollment if inrange(school_enrollment,20,60), discrete frequency), xline(40.5)

*Reload data
use "/Users/kwantlin/Downloads/grade5.dta", clear

*** Question 5 ***
gen above40 = 0
replace above40 = 1 if school_enrollment > 40
gen x = school_enrollment - 40
gen x_above40 = x*above40
reg classize above40 x x_above40 if inrange(school_enrollment,0,80), cluster(schlcode)
reg avgmath above40 x x_above40 if inrange(school_enrollment,0,80), cluster(schlcode)
reg avgverb above40 x x_above40 if inrange(school_enrollment,0,80), cluster(schlcode)

log close
