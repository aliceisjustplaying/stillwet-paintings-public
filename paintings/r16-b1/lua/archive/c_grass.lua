grassDark = pile{{"raw umber", 2}, {"green earth", 2}, {"bone black", 0.6}, {"Prussian blue", 0.15}, medium=0.1}
grassMid = pile{{"green earth", 2.5}, {"raw umber", 1.3}, {"yellow ochre", 0.9}, {"Prussian blue", 0.05}, medium=0.1}
grassDry = pile{{"yellow ochre", 2}, {"raw umber", 1.2}, {"green earth", 1}, {"lead white", 0.4}, medium=0.1}
grassCool = pile{{"green earth", 2}, {"raw umber", 1}, {"smalt", 0.5}, {"lead white", 0.3}, medium=0.1}
gpiles = {grassDark, grassMid, grassDry, grassCool}
gb = {}
for i = 1, 4 do gb[i] = brush{kind="round", width=3, point=1}; gb[i]:load(gpiles[i], 0.8) end
gcount = {0,0,0,0}
function blade(k, x, y, L, a, w)
  local b = gb[k]
  gcount[k] = gcount[k] + 1
  if gcount[k] % 6 == 0 then b:load(gpiles[k], 0.75) end
  local bend = randn(0, 0.25)
  local p1 = {x + 0.5*L*math.cos(a), y + 0.5*L*math.sin(a)}
  local p2 = {x + L*math.cos(a + bend), y + L*math.sin(a + bend)}
  b:stroke({{x, y}, p1, p2}, {pressure={b:pressure_for(w), 0.0}, ramps={0.02, 0.7}})
end
function grassField(n, y0, y1, pickFn, seed)
  for c = 1, n do
    local x = rand(-10, 1010)
    local ytop = crestY(x)
    local y = lerp(math.max(y0, ytop + 2), y1, rand(0,1)^0.8)
    if keepOut:at(x, y) < 0.5 then
      local s = lerp(0.35, 1.6, clamp((y - ytop) / (704 - ytop), 0, 1))
      local k = pickFn(x, y)
      local nb = math.random(4, 10)
      for j = 1, nb do
        local L = s * rand(8, 20)
        local a = -math.pi/2 + randn(0, 0.3)
        blade(k, x + randn(0, 2*s), y + rand(0, 2*s), L, a, s * rand(0.6, 1.1))
      end
    end
  end
end
grassField(700, 560, 704, function(x, y) local r = rand(0,1); if y > 650 then return r < 0.6 and 1 or (r < 0.85 and 4 or 2) end; return r < 0.35 and 1 or (r < 0.7 and 2 or (r < 0.85 and 3 or 4)) end)
