local cast = pile{{"green earth", 1.3}, {"raw umber", 0.7}, {"Prussian blue", 0.06}, {"yellow ochre", 0.3}, medium=0.3}
local b = brush{kind="round", width=1.2, point=0.5}
for i,h in ipairs(HORSES) do
  b:load(cast, 0.5)
  local y = h.y + 0.4
  b:stroke({{h.x - 0.6*h.H, y}, {h.x + 0.6*h.H, y - 0.4}, {h.x + 2.2*h.H, y - 0.2}}, {pressure={0.5, 0.05}, ramps={0.1, 0.6}, clip=-h.m})
  b:load(cast, 0.4)
  b:stroke({{h.x - 0.5*h.H, y + 0.8}, {h.x + 1.8*h.H, y + 0.5}}, {pressure={0.4, 0.05}, ramps={0.1, 0.6}, clip=-h.m})
end
-- evening light along the backs
local lp = {pile{{"red earth", 0.6}, {"yellow ochre", 0.8}, {"lead white", 0.4}, medium=0.08}, pile{{"lead white", 2}, {"yellow ochre", 0.3}, medium=0.08}, pile{{"raw umber", 0.6}, {"lead white", 0.5}, {"yellow ochre", 0.3}, medium=0.08}, pile{{"yellow ochre", 0.9}, {"red earth", 0.4}, {"lead white", 0.5}, medium=0.08}}
local fine = brush{kind="round", width=0.6, point=1}
for i,h in ipairs(HORSES) do
  local rim = mask(function(x, y) if h.m:at(x, y) < 0.5 then return 0 end; return (h.m:at(x - 0.7, y - 1.1) < 0.5) and 1 or 0 end)
  work(rim, {hand="detail", tool=fine, pile=lp[i], angle=0, coverage=1.5, seed=7400+i})
end
