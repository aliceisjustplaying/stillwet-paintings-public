pBoatR = pile{{"raw umber",1.3},{"bone black",0.5},{"smalt",0.6},{"lead white",0.5},{"red earth",0.15}}
local b = brush{kind="flat", width=4, stiffness=0.4}
-- hull reflection: a few horizontal strokes, wobbling, getting shorter and broken downward
local rows = {{560, 616, 706, 0.8},{564, 624, 700, 0.7},{568, 632, 694, 0.6},{573, 645, 690, 0.5},{578, 650, 684, 0.45},{584, 656, 682, 0.4},{590, 660, 680, 0.35},{597, 662, 678, 0.3},{604, 664, 676, 0.25}}
for i, r in ipairs(rows) do
  b:reload(pBoatR, 0.7)
  local y = r[1]
  local x0, x1 = r[2] + rand(-3,3), r[3] + rand(-3,3)
  if i > 4 and math.random() < 0.5 then
    local mid = lerp(x0, x1, rand(0.35, 0.65))
    b:stroke({{x0, y}, {mid - 2, y + rand(-0.6,0.6)}}, {pressure={r[4], r[4]*0.8}, orient="across"})
    b:reload(pBoatR, 0.6)
    b:stroke({{mid + 3, y + rand(-0.5,0.5)}, {x1, y}}, {pressure={r[4]*0.9, r[4]*0.7}, orient="across"})
  else
    b:stroke({{x0, y}, {(x0+x1)/2, y + rand(-0.6,0.6)}, {x1, y}}, {pressure={r[4], r[4]*0.8}, orient="across"})
  end
end
-- pole reflection: short broken wavy dashes
local r = brush{kind="rigger", width=1.6, point=1}
local segs = {{660,566,664,576},{666,580,669,589},{670,594,674,602},{676,608,678,614},{680,620,682,626}}
for i, s in ipairs(segs) do
  r:reload(pBoatR, 0.7)
  r:stroke({{s[1] + rand(-1,1), s[2]}, {(s[1]+s[3])/2 + rand(-1.5,1.5), (s[2]+s[4])/2}, {s[3], s[4]}}, {pressure={0.5, 0.2}, ramps={0.1,0.4}})
end
