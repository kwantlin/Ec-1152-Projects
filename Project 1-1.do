clear
set more off
cap log close

log using "/Users/kwantlin/My Documents/Harvard 2018-2019/Econ 1152/Project 1/Project_1_Log_File.smcl", replace

* Load in the data
use "/Users/kwantlin/Downloads/atlas_ranks.dta"

* List data for my home tract
list kfr_pooled_p25 if state==55 & county == 079 & tract == 186100

* List data for my home county
list kfr_pooled_p25 if state==55 & county == 079 

* Note: Though one metric alone was sufficient,
* I will begin the first section of the assignment considering upward mobility 
* using both income and rank measurements in this code, to consider multiple 
* methods of interpretation.

*** Question 3 ***

sum kfr_pooled_p25 if state==54 & county == 039 & tract == 011302 
sum kfr_pooled_p25 if state==54 [aw = count_pooled ]
sum kfr_pooled_p25 [aw = count_pooled ]

sum ranks_pooled_p25 if state==54 & county == 039 & tract == 011302 
sum ranks_pooled_p25 if state==54 [aw = count_pooled ]
sum ranks_pooled_p25 [aw = count_pooled ]

*** Queston 4 ***

* Comparing Kanawha County, WV, and the U.S. by income metric

sum kfr_pooled_p25 if state==54 & county == 039 [aw = count_pooled ]
sum kfr_pooled_p25 if state==54 [aw = count_pooled ]
sum kfr_pooled_p25 [aw = count_pooled ]


* Comparing Kanawha County, WV, and the U.S. by rank metric

sum ranks_pooled_p25 if state==54 & county == 039 [aw = count_pooled ]
sum ranks_pooled_p25 if state==54 [aw = count_pooled ]
sum ranks_pooled_p25 [aw = count_pooled ]

*** Question 5 ***

** Looking at children who start with parents at the 75th percentile.
* Repeating Questions 3:

sum kfr_pooled_p75 if state==54 & county == 039 & tract == 011302 
sum kfr_pooled_p75 if state==54 [aw = count_pooled ]
sum kfr_pooled_p75 [aw = count_pooled ]


sum ranks_pooled_p75 if state==54 & county == 039 & tract == 011302 
sum ranks_pooled_p75 if state==54 [aw = count_pooled ]
sum ranks_pooled_p75 [aw = count_pooled ]

* Repeating Question 4:

sum kfr_pooled_p75 if state==54 & county == 039 [aw = count_pooled ]
sum kfr_pooled_p75 if state==54 [aw = count_pooled ]
sum kfr_pooled_p75 [aw = count_pooled ]


sum ranks_pooled_p75 if state==54 & county == 039 [aw = count_pooled ]
sum ranks_pooled_p75 if state==54 [aw = count_pooled ]
sum ranks_pooled_p75 [aw = count_pooled ]

** Looking at children who start with parents at the 100th percentile.

* Repeating Questions 3:

sum kfr_pooled_p100 if state==54 & county == 039 & tract == 011302 
sum kfr_pooled_p100 if state==54 [aw = count_pooled ]
sum kfr_pooled_p100 [aw = count_pooled ]


sum ranks_pooled_p100 if state==54 & county == 039 & tract == 011302 
sum ranks_pooled_p100 if state==54 [aw = count_pooled ]
sum ranks_pooled_p100 [aw = count_pooled ]

* Repeating Question 4:

sum kfr_pooled_p100 if state==54 & county == 039 [aw = count_pooled ]
sum kfr_pooled_p100 if state==54 [aw = count_pooled ]
sum kfr_pooled_p100 [aw = count_pooled ]


sum ranks_pooled_p100 if state==54 & county == 039 [aw = count_pooled ]
sum ranks_pooled_p100 if state==54 [aw = count_pooled ]
sum ranks_pooled_p100 [aw = count_pooled ]

*** Question 6 ***
sum kfr_pooled_p25 if state == 54 & county == 039
gen kfr_pooled_p25_std = (kfr_pooled_p25 - r(mean))/r(sd)
sum kfr_pooled_p75 if state == 54 & county == 039
gen kfr_pooled_p75_std = (kfr_pooled_p75 - r(mean))/r(sd)
reg kfr_pooled_p25 kfr_pooled_p75_std if state==54 & county == 039, robust
twoway (scatter kfr_pooled_p25_std kfr_pooled_p75_std if state==54 & county == 039) || lfitci kfr_pooled_p25_std kfr_pooled_p75_std if state==54 & county == 039


sum ranks_pooled_p25 if state == 54 & county == 039
gen ranks_pooled_p25_std = (ranks_pooled_p25 - r(mean))/r(sd)
sum ranks_pooled_p75 if state == 54 & county == 039
gen ranks_pooled_p75_std = (ranks_pooled_p75 - r(mean))/r(sd)
reg ranks_pooled_p25 ranks_pooled_p75_std if state==54 & county == 039, robust
twoway (scatter ranks_pooled_p25_std ranks_pooled_p75_std if state==54 & county == 039) || lfitci ranks_pooled_p25_std ranks_pooled_p75_std if state==54 & county == 039

*** Question 7 ***

* From this point, we will restrict our analysis to just using the income metric, for simplicity now that
* the usefullness of the rank metric has been explored.

* Repeating Question 3 for all races, looking at children who start with parents at the 25th percentile.
sum kfr_*_p25 if state==54 & county == 039 & tract == 011302 
sum kfr_*_p25 if state==54 [aw = count_pooled ]
sum kfr_*_p25 [aw = count_pooled ]


* Repeating Question 4 for all races, looking at children who start with parents at the 75th percentile.
sum kfr_*_p75 if state==54 & county == 039 [aw = count_pooled ]
sum kfr_*_p75 if state==54 [aw = count_pooled ]
sum kfr_*_p75 [aw = count_pooled ]

*Repeating Question 4 for all races, looking at children who start with parents at the 100th percentile.
sum kfr_*_p100 if state==54 & county == 039 [aw = count_pooled ]
sum kfr_*_p100 if state==54 [aw = count_pooled ]
sum kfr_*_p100 [aw = count_pooled ]

*** Question 8 ***
* Here we will test familiar covariates mentioned in the Opportunity Atlas Manuscript
*Covariate: Job Density in 201324
sum kfr_pooled_p25 if state == 54 & county == 039 
gen y_std2 = (kfr_pooled_p25 - r(mean))/r(sd)
sum job_density_2013 if state == 54 & county == 039
gen x_std2 = (job_density_2013 - r(mean))/r(sd)
reg y_std2 x_std2 if state == 54 & county == 039,  robust

*Covariate: Poor Share in 2010
sum kfr_pooled_p25 if state == 54 & county == 039 
gen y_std3 = (kfr_pooled_p25 - r(mean))/r(sd)
sum poor_share2010 if state == 54 & county == 039
gen x_std3 = (poor_share2010 - r(mean))/r(sd)
reg y_std3 x_std3 if state == 54 & county == 039,  robust

*Covariate: Fraction of Residents with a High School Diploma or More
sum kfr_pooled_p75 if state == 54 & county == 039 
gen y_std4 = (kfr_pooled_p75 - r(mean))/r(sd)
sum frac_coll_plus2010 if state == 54 & county == 039
gen x_std4 = (frac_coll_plus2010 - r(mean))/r(sd)
reg y_std4 x_std4 if state == 54 & county == 039,  robust

*** Question 9 ***
* Here we will test covariates relating to our unique hypothesis

*Covariate: Single Parent share in 2000 among those with poorer parents
sum kfr_pooled_p25 if state == 54 & county == 039 
gen y_std8 = (kfr_pooled_p25 - r(mean))/r(sd)
sum singleparent_share2000 if state == 54 & county == 039
gen x_std8 = (singleparent_share2000 - r(mean))/r(sd)
reg y_std8 x_std8 if state == 54 & county == 039,  robust
*Previous covariate is especially true in my home county/area
sum kfr_pooled_p25 if state == 54 
gen y_std9 = (kfr_pooled_p25 - r(mean))/r(sd)
sum singleparent_share2000 if state == 54 
gen x_std9 = (singleparent_share2000 - r(mean))/r(sd)
reg y_std9 x_std9 if state == 54,  robust
*Covariate: Employment in 2000, for those with wealthier parents
sum kfr_pooled_p75 if state == 54 & county == 039 
gen y_std10 = (kfr_pooled_p75 - r(mean))/r(sd)
sum emp2000 if state == 54 & county == 039 
gen x_std10 = (emp2000 - r(mean))/r(sd)
reg y_std10 x_std10 if state == 54 & county == 039 ,  robust
*Previous covariate has similarly strong correlation for those with less wealthy parents
sum kfr_pooled_p25 if state == 54 & county == 039 
gen y_std11 = (kfr_pooled_p25 - r(mean))/r(sd)
sum emp2000 if state == 54 & county == 039 
gen x_std11 = (emp2000 - r(mean))/r(sd)
reg y_std11 x_std11 if state == 54 & county == 039 ,  robust
* Covariate: Share black in 2010 (most diversity in the area is black), considering those with wealthiest parents
sum kfr_pooled_p100 if state == 54 & county == 039 
gen y_std5 = (kfr_pooled_p100 - r(mean))/r(sd)
sum share_black2010 if state == 54 & county == 039
gen x_std5 = (share_black2010 - r(mean))/r(sd)
reg y_std5 x_std5 if state == 54 & county == 039,  robust
*Covariate: Share black in 2010, but this time considering those with well-off parents
sum kfr_pooled_p75 if state == 54 & county == 039 
gen y_std6 = (kfr_pooled_p75 - r(mean))/r(sd)
sum share_black2010 if state == 54 & county == 039
gen x_std6 = (share_black2010 - r(mean))/r(sd)
reg y_std6 x_std6 if state == 54 & county == 039,  robust
*Covariate: Share black in 2010, but this time considering those with less well-off parents
sum kfr_pooled_p25 if state == 54 & county == 039 
gen y_std7 = (kfr_pooled_p25 - r(mean))/r(sd)
sum share_black2010 if state == 54 & county == 039
gen x_std7 = (share_black2010 - r(mean))/r(sd)
reg y_std7 x_std7 if state == 54 & county == 039,  robust

log close




