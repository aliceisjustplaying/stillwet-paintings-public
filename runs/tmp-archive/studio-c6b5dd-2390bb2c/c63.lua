local extra = (below(function(x) return 474 end) - refl2) * rect(300, 0, 82, 800)
local c4 = function(x) return 632 + 5*math.sin(x/80+3) end
local c5 = function(x) return 672 + 4*math.sin(x/110+4) end
local e1 = extra * above(c4)
local e2 = extra * below(c4) * above(c5)
local e3 = extra * below(c5)
local o = function(p) return {hand="body", tool="filbert 8", pile=p, angle=0, angle_jitter=0.02, coverage=3.5, load=0.85, fill=true, length={30,60}, clip=extra} end
work(e1, o(gw4)); work(e2, o(gw5)); work(e3, o(gw6))
openW = openW + extra
blend(openW, {angle=0, angle_jitter=0.015, tool="badger 30", length={80,220}})
local seams = nil
for _, y in ipairs({530, 560, 604, 632, 672}) do
  local r = rect(300, y-14, 800, 28)
  seams = seams and (seams + r) or r
end
blend(seams * openW, {angle=1.5, angle_jitter=0.15, tool="badger 16", length={20,40}})
blend(openW, {angle=0, angle_jitter=0.01, tool="badger 30", length={100,250}, pressure={0.25,0.4}})
