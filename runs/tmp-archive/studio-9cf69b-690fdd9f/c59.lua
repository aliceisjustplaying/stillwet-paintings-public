local r = brush{kind="round", width=1.6, point=1}
r:load(snowTop, 0.6)
local n = 0
for _,t in ipairs(sprTiers) do
  local x0, y, hw, drop = t[1], t[2], t[3], t[4]
  for _,side in ipairs({-1, 1}) do
    if math.random() < 0.7 then
      local a = rand(0.1, 0.35); local b = rand(0.6, 0.95)
      local xa, ya = x0 + side*hw*a, y - 1.8 + drop*0.5*a
      local xb, yb = x0 + side*hw*b, y - 1.0 + drop*0.5*b
      r:stroke({{xa, ya}, {xb, yb}}, {pressure={0.5, 0.2}})
      n = n + 1
      if n % 8 == 0 then r:load(snowTop, 0.6) end
    end
  end
end
-- small drifts and shadow at the feet of the spruces
local feet = nil
for _,s in ipairs(spruces) do
  local e = ellipse(s[1], s[2] + 0.5, s[3]*0.2 + 2, 1.6)
  feet = feet and (feet + e) or e
end
work(feet, {hand="detail", pile=moundShade, coverage=3, pressure={0.5,0.8}, load=0.8, fill=true, angle=0, tool={kind="round", width=1.2}})
print(n)
