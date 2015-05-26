use data/Divorce-Wolfers-AER, clear
keep if inrange(year, 1968, 1988)
egen state = group(st), label
tsset state year
egen tag = tag(state)


regife div_rate unilateral divx*   [w=stpop], f(state year) d(2)
reghdfe div_rate unilateral divx* [aw=stpop], a(state year)
regife div_rate unilateral divx* [aw=stpop], f(state year) d(2)
regife div_rate unilateral divx* [aw=stpop], f(state year) d(2) a(state year)
regife div_rate unilateral divx*  i.state i.year [aw=stpop], f(state year) d(2)


* check lagged and factor display correctly
regife div_rate L.unilateral i.year   [aw=stpop], f(state year) d(2)
tab year, gen(tempyear)
regife div_rate L.unilateral tempyear*   [aw=stpop], f(state year) d(2)



* check factors with time dimension gives the original data
distinct year
local nyear = r(ndistinct)
ife div_rate, f(state year) d(`nyear') gen(new)
assert float(div_rate) == float(new)




