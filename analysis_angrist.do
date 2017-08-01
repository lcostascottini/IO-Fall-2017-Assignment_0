version 13
set more off
adopath + ../external/lib/stata/gslab_misc/ado
preliminaries

program main
    use ../clean/angrist.dta, clear
    ols_models
    iv_models
	logit_models
end

program ols_models
	local age AGEQ AGEQSQ 
	local ses RACE MARRIED SMSA NEWENG MIDATL ENOCENT WNOCENT SOATL ESOCENT WSOCENT MT
	local cohort YR20-YR28
	
    reg  LWKLYWGE EDUC `cohort'
    reg  LWKLYWGE EDUC `cohort' `age'
    reg  LWKLYWGE EDUC `cohort' `ses'
    reg  LWKLYWGE EDUC `cohort' `ses' `age'
end

program iv_models
	local age AGEQ AGEQSQ 
	local ses RACE MARRIED SMSA NEWENG MIDATL ENOCENT WNOCENT SOATL ESOCENT WSOCENT MT
	local cohort YR20-YR28
    local ivs QTR120-QTR129 QTR220-QTR229 QTR320-QTR329
	
    ivregress 2sls LWKLYWGE `cohort' (EDUC = `ivs')	
    ivregress 2sls LWKLYWGE `cohort' `age' (EDUC = `ivs')	
    ivregress 2sls LWKLYWGE `cohort' `ses' (EDUC = `ivs')
    ivregress 2sls LWKLYWGE `cohort' `ses' `age' (EDUC = `ivs')
end

program logit_models
	logit HIGH_SCHOOL i.QTR1 AGEQ AGEQSQ
	margins QTR1
end

* EXECUTE
main
    
