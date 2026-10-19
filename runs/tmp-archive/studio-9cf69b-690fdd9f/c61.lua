sprDark = pile{{"Prussian blue",0.5},{"raw umber",1.5},{"bone black",0.8},{"yellow ochre",0.3},{"lead white",0.4}, medium=0.08}
local r = brush{kind="round", width=1.8, point=1}
r:load(sprDark, 0.7)
local n = 0
for _,t in ipairs(sprTiers) do
  local x0, y, hw, drop = t[1], t[2], t[3], t[4]
  for _,side in ipairs({-1, 1}) do
    -- the shadowed underside of each tier, stem outward, drooping
    local xb, yb = x0 + side*hw*rand(0.75, 0.95), y + drop*0.45
    r:stroke({{x0, y + 0.8}, {x0 + side*hw*0.5, y + drop*0.3 + 0.6}, {xb, yb}}, {pressure={0.5, 0.1}})
    n = n + 1
    if n % 8 == 0 then r:load(sprDark, 0.7) end
  end
end
-- the stems show dark between the tiers
for _,s in ipairs(spruces) do r:stroke({{s[1], s[2]}, {s[1], s[2] - s[3]*0.8}}, {pressure={0.4, 0.1}}) end
