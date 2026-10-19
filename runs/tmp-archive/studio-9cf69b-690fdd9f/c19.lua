barkDark = pile{{"raw umber",2},{"bone black",1.2},{"smalt",0.4},{"lead white",0.5}, medium=0.1}
deadWood = pile{{"lead white",1.6},{"raw umber",1},{"bone black",0.45},{"pale smalt",0.6}, medium=0.1}
local tm = ribbon(oakTrunk.pts, oakTrunk.ws)
-- root flare
tm = tm + poly({{160,452},{172,436},{182,420},{202,420},{212,436},{226,452}}, true)
local lm = nil
for _,s in ipairs(oak.thick) do local r = ribbon(s.pts, s.ws); lm = lm and (lm + r) or r end
oakThickM = (tm + lm):roughen(0.8, 6, 5)
local dm = nil
for _,s in ipairs(oak.dead) do local r = ribbon(s.pts, s.ws); dm = dm and (dm + r) or r end
oakDeadM = dm:roughen(0.6, 5, 6)
work(oakThickM, {hand="detail", pile=barkDark, coverage=3.5, pressure={0.6,0.9}, load=1, fill=true, angle=-math.pi/2, angle_jitter=0.5})
work(oakDeadM, {hand="detail", pile=deadWood, coverage=3.5, pressure={0.6,0.9}, load=1, fill=true, angle=-math.pi/2, angle_jitter=0.5})
