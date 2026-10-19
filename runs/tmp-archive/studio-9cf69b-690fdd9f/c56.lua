snowSide2 = pile{{"lead white",4.5},{"pale smalt",1.5},{"smalt",0.35},{"raw umber",0.12},{"vermilion",0.03}, medium=0.08}
local top = {{268,389},{273,377},{289,361},{315,350.5},{350,346},{383,347.5},{409,353.5},{428,364.5},{437,379}}
local lip = {{437,381},{430,378},{420,377},{410,373},{400,374},{390,370},{378,372},{366,368},{352,370},{340,367},{328,370},{316,368},{305,373},{295,372},{285,378},{276,384},{268,391}}
local pts = {}
for _,p in ipairs(top) do pts[#pts+1] = p end
for _,p in ipairs(lip) do pts[#pts+1] = p end
local snowM = poly(pts, true):roughen(0.6, 3, 141)
work(snowM, {hand="detail", pile=snowSide2, coverage=4.5, pressure={0.7,1.0}, load=1, fill=true, angle=0, tool={kind="round", width=2}})
local litM = snowM * above({{260,380},{290,364},{320,356},{350,353},{385,354},{415,360},{440,372}})
work(litM, {hand="detail", pile=snowTop, coverage=4.5, pressure={0.7,1.0}, load=1, fill=true, angle=0, tool={kind="round", width=2}})
-- the shadow line under the overhanging lip
local r = brush{kind="round", width=2, point=1}
r:load(chamber, 0.6)
local sh = {}
for _,p in ipairs(lip) do sh[#sh+1] = {p[1], p[2] + 1.3} end
r:stroke(sh, {pressure={0.3,0.3}})
-- snow cap on the fallen stone to the right, and on the left one
local c1 = poly({{444,423},{447,418.5},{456,415.5},{468,416},{477,421},{471,420.5},{460,420},{450,422}}, true)
local c2 = poly({{246,425},{250,419.5},{260,417},{268,421},{263,421.5},{254,422.5}}, true)
work(c1 + c2, {hand="detail", pile=snowTop, coverage=4.5, pressure={0.7,1.0}, load=1, fill=true, angle=0, tool={kind="round", width=1.5}})
