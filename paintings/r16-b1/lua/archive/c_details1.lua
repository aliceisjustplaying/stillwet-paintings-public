-- evening star
starP = pile{{"lead white", 3}, {"chrome yellow", 0.1}, medium=0.05}
local sb = brush{kind="round", width=2.2, point=1}
sb:load(starP, 0.9)
sb:touch(876, 131, {pressure=sb:pressure_for(1.7)})
-- distant birds (rooks going home), small shallow Vs
birdP = pile{{"bone black", 1}, {"raw umber", 1}, {"smalt", 0.3}, {"lead white", 0.6}, medium=0.05}
local bb = brush{kind="round", width=1.0, point=1}
local birds = {{612, 262, 3.2}, {628, 255, 2.8}, {641, 268, 2.5}, {655, 259, 2.2}, {667, 266, 2.0}, {600, 274, 2.6}}
for _, b in ipairs(birds) do
  bb:load(birdP, 0.8)
  local x, y, s = b[1], b[2], b[3]
  local up = rand(-0.4, 0.4)
  bb:stroke({{x - s, y - 0.5*s + up}, {x - 0.45*s, y - 0.2*s}, {x, y + 0.15*s}}, {pressure={bb:pressure_for(0.3), bb:pressure_for(0.55)}})
  bb:stroke({{x, y + 0.15*s}, {x + 0.45*s, y - 0.25*s}, {x + s, y - 0.55*s - up}}, {pressure={bb:pressure_for(0.55), bb:pressure_for(0.3)}})
end
-- hay cocks on the meadow, right side between willows and figures, and a few far left
hayP = pile{{"yellow ochre", 2}, {"raw umber", 1}, {"lead white", 0.7}, {"green earth", 0.3}, medium=0.05}
hayLit = pile{{"lead white", 1.5}, {"yellow ochre", 1.5}, {"chrome yellow", 0.15}, {"raw umber", 0.3}, medium=0.05}
hayShP = pile{{"raw umber", 2}, {"green earth", 0.8}, {"bone black", 0.3}, {"lead white", 0.3}, medium=0.05}
local cocks = {{672, 522}, {700, 515}, {728, 510}, {648, 508}, {690, 501}, {470, 498}, {498, 494}, {440, 502}, {120, 505}, {150, 500}}
for _, c in ipairs(cocks) do
  local x, y = c[1], c[2]
  local s = (y - 440) / 134
  local w, h = 11 * s, 9 * s
  local m = poly({{x - w/2, y}, {x - w*0.42, y - h*0.45}, {x - w*0.2, y - h*0.9}, {x, y - h}, {x + w*0.22, y - h*0.9}, {x + w*0.42, y - h*0.45}, {x + w/2, y}}, true)
  work(m, {hand="detail", pile=hayP, coverage=4, fill=true, clip=true, angle=-1.3, length={1,3}})
  work(m * rect(x - w, y - h - 2, w*0.9, h + 3), {hand="detail", pile=hayShP, coverage=2, clip=true, angle=-1.3, length={1,3}, pressure={0.3,0.5}})
  work(m * rect(x - w*0.05, y - h - 2, w*0.4, h*0.35), {hand="detail", pile=hayLit, coverage=1.5, clip=true, angle=-1.3, length={1,2}, pressure={0.3,0.5}})
  -- cast shadow toward the viewer (sun behind)
  work(ellipse(x + 0.5, y + 1.0*s, w*0.6, 1.2*s), {hand="detail", pile=bankShadow, coverage=1.2, clip=true, angle=0, length={1,3}, pressure={0.2,0.4}})
end
