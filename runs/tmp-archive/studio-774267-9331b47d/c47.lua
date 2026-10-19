local ws = {30, 26, 20, 15, 11, 9, 7, 5, 3.5, 2.5, 1.6}
local pts, wd = {}, {}
local nn = noise{seed=5, octaves=2, period=30}
for i=1,#PATHPTS-1 do
  for s=0,9 do
    local t = s/10
    local x, y = lerp(PATHPTS[i][1], PATHPTS[i+1][1], t), lerp(PATHPTS[i][2], PATHPTS[i+1][2], t)
    pts[#pts+1] = {x + 1.5*nn(x, y), y}
    wd[#wd+1] = lerp(ws[i], ws[i+1], t) * (0.8 + 0.4*nn:at01(x*2, y))
  end
end
pts[#pts+1] = PATHPTS[#PATHPTS]; wd[#wd+1] = 1.5
NARROW = ribbon(pts, wd):roughen(1.2, 6, 71) * below(function(x) return fg(x) + 1 end)
local edge = PATHM:grow(2.5) - NARROW
local cuts = {0, 12, 35, 70, 400}
local piles = {
  pile{{"green earth", 2}, {"yellow ochre", 1.6}, {"lead white", 0.6}, {"chrome yellow", 0.12}, {"raw umber", 0.1}, medium=0.15},
  pile{{"green earth", 2}, {"yellow ochre", 1.2}, {"lead white", 0.3}, {"raw umber", 0.3}, {"Prussian blue", 0.04}, medium=0.15},
  pile{{"green earth", 2}, {"yellow ochre", 0.9}, {"raw umber", 0.6}, {"Prussian blue", 0.07}, {"bone black", 0.05}, medium=0.15},
  pile{{"green earth", 1.6}, {"raw umber", 1}, {"yellow ochre", 0.6}, {"Prussian blue", 0.1}, {"bone black", 0.12}, medium=0.15},
}
FGP = piles
for i=1,4 do
  local a, b = cuts[i], cuts[i+1]
  local m = edge * mask(function(x, y) local d = y - fg(x); return (d >= a and d < b) and 1 or 0 end)
  work(m, {hand="detail", tool={kind="round", width=3, point=0.3}, pile=piles[i], angle=-0.3, angle_jitter=0.4, coverage=3, fill=true, seed=4700+i})
end
-- darken the remaining track: a thin earth glaze, heavier toward the bottom
local g = pile{{"raw umber", 1}, {"green earth", 0.8}, {"yellow ochre", 0.4}, medium=0.6}
work(NARROW:grow(1), {hand="glaze", tool="filbert 6", pile=g, angle=-0.5, length={20,50}, coverage=1.2, clip=true, load_at=function(x, y) return clamp((y-520)/110, 0.15, 0.7) end, seed=4705})
