sprP = pile{{"Prussian blue",0.4},{"raw umber",1.5},{"yellow ochre",0.4},{"bone black",0.5},{"lead white",0.9}, medium=0.1}
spruces = {{872,497,34},{893,502,60},{915,499,44},{937,503,29},{953,500,19},{858,500,16}}
local b = brush{kind="round", width=2.2, point=1, stiffness=0.6}
b:load(sprP, 0.8)
local n = 0
for _,s in ipairs(spruces) do
  local x0, yb, h = s[1], s[2], s[3]
  local top = yb - h
  -- stem
  b:stroke({{x0, yb+1}, {x0+randn(0,0.4), top}}, {pressure={0.45, 0.02}})
  local y = yb - 2
  while y > top + 1 do
    local t = (yb - y) / h
    local hw = h * 0.21 * (1 - t)^0.85 + 1.2
    for _,side in ipairs({-1, 1}) do
      local len = hw * rand(0.8, 1.15)
      local droop = rand(0.25, 0.55)
      local ex = x0 + side * len
      local ey = y + len * droop * 0.6
      b:stroke({{x0, y - 1}, {x0 + side*len*0.55, y + len*droop*0.35}, {ex, ey}, {ex + side*1.2, ey - 0.6}}, {pressure={0.55, 0.05}, ramps={0, 0.4}})
      n = n + 1
      if n % 10 == 0 then b:load(sprP, 0.7) end
    end
    y = y - rand(1.8, 3.0)
  end
  -- leader
  b:stroke({{x0, top+3},{x0, top-2.5}}, {pressure={0.3,0.0}})
end
print(n)
