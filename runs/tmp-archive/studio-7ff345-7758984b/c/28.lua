-- three young spruces on the far bank, right
spruceP = pile{{"Prussian blue",1},{"bone black",1.2},{"yellow ochre",0.8},{"raw umber",1},{"lead white",0.2}, medium=0.1}
sprTrunk = pile{{"raw umber",2},{"bone black",1},{"red earth",0.3}, medium=0.1}
spruces = {{cx=852, base=512, h=98}, {cx=884, base=516, h=140}, {cx=921, base=513, h=74}, {cx=958, base=518, h=46}}
bSpr = brush{kind="round", width=3, point=1}
bSprF = brush{kind="rigger", width=1.2, point=1}
sprTiers = {}
function paintSpruce(s)
  local top = s.base - s.h
  local tr = brush{kind="round", width=2.5, point=0.8}
  tr:load(sprTrunk, 0.8)
  tr:stroke({{s.cx, top + 4}, {s.cx + 0.5, s.base}}, {pressure={0.25, 0.7}})
  local y = top + 2
  local gap = 2.2
  local cnt = 0
  while y < s.base - 4 do
    local d = (y - top) / s.h
    local half = s.h * 0.29 * (0.25 + 0.75 * d) * rand(0.8, 1.12)
    if d < 0.08 then half = s.h * 0.05 end
    for _, side in ipairs({-1, 1}) do
      local L = half * rand(0.85, 1.1)
      local droop = L * rand(0.25, 0.45)
      local x0 = s.cx
      local pts = {{x0, y}, {x0 + side * L * 0.45, y + droop * 0.45}, {x0 + side * L * 0.85, y + droop * 0.95}, {x0 + side * L, y + droop * 0.85}}
      if cnt % 3 == 0 then bSpr:load(spruceP, 0.9) end
      bSpr:stroke(pts, {pressure={0.75, 0.25}, ramps={0.05, 0.4}})
      cnt = cnt + 1
      -- hanging fringe of second-order twigs under the branch (comb spruce)
      bSprF:load(spruceP, 0.7)
      local nf = math.floor(L / 3)
      for k = 1, nf do
        local t = k / (nf + 1)
        local fx = x0 + side * L * t
        local fy = y + droop * t * 1.0
        local fl = rand(2, 5) * (0.5 + d)
        bSprF:stroke({{fx, fy}, {fx + side * rand(0, 1), fy + fl}}, {pressure={0.6, 0.1}})
      end
      sprTiers[#sprTiers + 1] = {pts=pts, side=side, s=s}
    end
    gap = 2.2 + 5.5 * d
    y = y + gap * rand(0.8, 1.2)
  end
end
for _, s in ipairs(spruces) do paintSpruce(s) end
print(#sprTiers)
