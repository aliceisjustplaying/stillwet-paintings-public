local parts = {}
local function B(x,y,r,z,sd) parts[#parts+1] = {body.ellipsoid({x,y,z or 0},{r*1.12, r*0.88, r}):rough(r*0.1, r*0.8, sd)} end
B(598,384,30,0,1) B(648,356,40,0,2) B(700,320,46,5,3) B(752,290,50,0,4) B(810,294,48,-5,5) B(862,318,44,0,6)
B(912,338,40,0,7) B(958,350,36,0,8) B(1002,360,34,0,9)
B(742,258,28,10,10) B(792,260,30,5,11) B(690,302,26,15,12) B(838,278,26,5,13)
B(655,392,36,25,14) B(730,374,50,30,15) B(810,370,56,30,16) B(890,380,48,25,17) B(965,390,40,20,18)
parts.light = {from={-1,-0.8}, front=0.35, ambient=0.25}
cloud2F = form(parts)
local town = (townM + townM2):grow(0.6)
local cut = rect(0,0,1000,413)
cloud2M = ((cloud2F:silhouette{} + cloudM) * cut) - town
cloud2Lit = cloud2F:lit{soft=0.25} * cut - town
local csh = pile{{"lead white",7},{"pale smalt",1.4},{"red earth",0.22},{"raw umber",0.12},{"yellow ochre",0.2}, medium=0.08}
local cmid = pile{{"lead white",10},{"pale smalt",0.7},{"yellow ochre",0.35},{"red earth",0.08}, medium=0.08}
local chi = pile{{"lead white",14},{"yellow ochre",0.3},{"vermilion",0.03}, medium=0.06}
work(cloud2M, {hand="body", tool="filbert 8", pile=csh, angle=function(x,y) return 0.3 end, coverage=2.6, fill=true, edge="soft", pressure={0.45,0.7}, curve={0.3,0.1}, seed=901})
work(cloud2Lit, {hand="body", tool="filbert 7", pile=cmid, angle=cloud2F:field("across"), coverage=2.2, edge="soft", pressure={0.4,0.65}, seed=902})
local hi = cloud2Lit:map(function(v) return smoothstep(0.55, 0.9, v) end)
work(hi, {hand="body", tool="filbert 5", pile=chi, angle=cloud2F:field("across"), coverage=1.8, edge="soft", pressure={0.4,0.6}, seed=903})
