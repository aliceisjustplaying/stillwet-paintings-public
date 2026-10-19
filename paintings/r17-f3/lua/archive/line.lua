local lD = pile{{"green earth",1.6},{"raw umber",0.7},{"Prussian blue",0.3},{"yellow ochre",0.45},{"lead white",0.4}, medium=0.07}
local all = PWCR2[1]
for i=2,#PWCR2 do all = all + PWCR2[i] end
PWCRALL = all
local band = all:shrink(1.5) * rect(0, 440, 450, 30)
stipple(band, {pile=lD, width=2.0, coverage=2.5, pressure={0.55,0.85}, cluster=0.4, dips={10,0.8,0.4}})
print(wait(0))
