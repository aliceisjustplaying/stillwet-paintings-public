land_m = -sky_m
gFar  = pile{{"lead white", 5}, {"green earth", 3}, {"pale smalt", 1.5}, {"yellow ochre", 1}, medium=0.08}
gMidL = pile{{"lead white", 3}, {"yellow ochre", 3}, {"chrome yellow", 0.5}, {"Prussian blue", 0.2}, {"green earth", 2}, medium=0.08}
gShad = pile{{"yellow ochre", 2}, {"Prussian blue", 0.35}, {"raw umber", 1}, {"green earth", 2}, {"lead white", 1.2}, medium=0.08}
gLit2 = pile{{"lead white", 2}, {"yellow ochre", 3}, {"chrome yellow", 1}, {"Prussian blue", 0.3}, {"green earth", 1}, medium=0.08}
gFore = pile{{"yellow ochre", 2}, {"raw umber", 1.5}, {"Prussian blue", 0.4}, {"green earth", 2}, {"lead white", 0.6}, {"red earth", 0.2}, medium=0.08}
local function wav(y0, a, p, ph) local pts = {} for x=-20,1020,40 do pts[#pts+1] = {x, y0 + a*math.sin(x/p+ph) + 0.4*a*math.sin(x/(p*0.37)+2*ph)} end return pts end
b_far  = wav(474, 4, 90, 1)
b_mid  = wav(516, 7, 120, 2)
b_shad = wav(546, 8, 140, 3)
Zfar  = below(land_top) - below(b_far)
Zmid  = below(b_far) - below(b_mid)
Zsh   = below(b_mid) - below(b_shad)
Zlit  = below(b_shad) - below(rise_top)
Zfore = below(rise_top)
local zs = {{Zfar, gFar, {20,60}}, {Zmid, gMidL, {25,70}}, {Zsh, gShad, {25,70}}, {Zlit, gLit2, {30,80}}, {Zfore, gFore, {30,80}}}
for _, z in ipairs(zs) do
  work(z[1] * land_m, {hand="body", pile=z[2], angle=function(x,y) return 0.03*math.sin(x/200) end, coverage=2.0, length=z[3], pressure={0.5,0.85}, fill=true, clip=land_m, edge="soft"})
end
print(wait(0))
