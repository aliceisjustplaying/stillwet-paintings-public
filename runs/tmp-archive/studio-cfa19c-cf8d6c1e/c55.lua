rvA = pile{{"lead white",9},{"pale smalt",1},{"yellow ochre",0.25}, medium=0.06}
rvB = pile{{"lead white",7},{"pale smalt",1.5},{"cobalt blue",0.2}, medium=0.06}
rvC = pile{{"lead white",6},{"pale smalt",1.5},{"cobalt blue",0.45}, medium=0.06}
local R = riverM
work(R * rect(320,430,300,60), {hand="body", tool="filbert 3", pile=rvA, angle=0.1, coverage=2.8, fill=true, clip=true, pressure={0.45,0.7}, seed=351})
work(R * rect(600,430,210,100), {hand="body", tool="filbert 3", pile=rvB, angle=0.16, coverage=2.8, fill=true, clip=true, pressure={0.45,0.7}, seed=352})
work(R * rect(790,430,230,140), {hand="body", tool="filbert 4", pile=rvC, angle=0.14, coverage=2.8, fill=true, clip=true, pressure={0.45,0.7}, seed=353})
-- soft willow reflections laid wet into wet with small vertical strokes
local rb = brush{kind="round", width=1.4, point=0.4}
local wRef2 = pile{{"green earth",1.5},{"raw umber",0.7},{"Prussian blue",0.2},{"lead white",0.5}, medium=0.1}
for i,w in ipairs({{452,11},{505,14},{560,18},{626,22},{702,27},{792,33},{884,38},{978,44}}) do
  local x, s = w[1], w[2]
  local yb = interp(farBank, x) + 1
  local yn = interp(nearBank, x) - 1
  local L = math.min(yn - yb, 0.9*s)
  rb:reload(wRef2, 0.5)
  -- trunk reflection
  rb:stroke({{x, yb},{x, yb + math.min(L, 0.42*s)}}, {pressure={0.7,0.5}, clip=R})
  -- the crown, broader, below it
  local n = math.max(3, math.floor(s/4))
  for k=1,n do
    local xx = x + (k/(n+1)-0.5) * 0.8*s + rand(-0.5,0.5)
    local y0 = yb + 0.42*s*rand(0.9,1.05)
    if y0 < yn then rb:stroke({{xx, y0},{xx, math.min(yn, y0 + rand(0.2,0.45)*s)}}, {pressure={0.6,0.2}, clip=R}) end
  end
end
