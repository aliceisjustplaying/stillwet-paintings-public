-- snow drifted against the foot of the dolmen
local prof = {{546,492},{552,488},{560,486.5},{572,487.5},{584,486},{596,488.5},{607,487},{618,488},{630,486.5},{643,488.5},{655,486},{668,488},{680,487},{692,488.5},{704,486.5},{716,487.5},{728,486},{738,489},{748,490},{760,489},{772,490.5},{786,492.5},{790,497}}
local pts = {}
for _,p in ipairs(prof) do pts[#pts+1] = p end
pts[#pts+1] = {790,500}; pts[#pts+1] = {546,500}
BASED = poly(pts, true)
work(BASED, {hand="detail", pile=crest, coverage=4, fill=true, angle=0, load=1, pressure={0.6,0.9}, tool={kind="round", width=2, point=0.4}})
-- the lit top line of the drift
local tb = brush{kind="round", width=1.6, point=0.8}
tb:load(snowTop, 0.7)
tb:stroke(prof, {pressure={tb:pressure_for(1.0), tb:pressure_for(0.8)}, shake=0.4})
