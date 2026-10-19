local top = {{268,390},{274,377},{290,361},{316,351},{350,346.5},{383,348},{409,354},{428,365},{437,379}}
local lower = {{437,381},{424,376},{414,374},{404,372},{392,368},{382,370},{370,366},{356,368},{344,365},{330,368},{318,366},{306,372},{296,371},{286,378},{276,383},{268,391}}
local pts = {}
for _,p in ipairs(top) do pts[#pts+1] = p end
for _,p in ipairs(lower) do pts[#pts+1] = {p[1], p[2] + randn(0, 0.8)} end
capSnowM = poly(pts, true):roughen(0.7, 3, 81)
-- shaded body of the snow first, then the lit crown of it
work(capSnowM, {hand="detail", pile=snowSide, coverage=3.5, pressure={0.6,0.9}, load=1, fill=true, angle=0})
local lit = capSnowM * above({{260,382},{300,364},{350,357},{400,360},{440,374}})
work(lit, {hand="detail", pile=snowTop, coverage=3.5, pressure={0.6,0.9}, load=1, fill=true, angle=0})
