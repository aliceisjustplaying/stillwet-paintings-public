-- raw umber is a LIGHT earth, so a "dark" pile built mostly on it is not dark at all.
-- Put the weight on bone black for the darks and on lead white for the lights.
r_lay  = pile{{"bone black", 1.6}, {"raw umber", 2}, {"red earth", 2.4}, {"vermilion", 1.2}}
r_mid  = pile{{"red earth", 2.4}, {"vermilion", 1.4}, {"raw umber", 0.6}, {"bone black", 0.5}}
r_lit  = pile{{"lead white", 2.5}, {"yellow ochre", 2}, {"vermilion", 0.8}, {"red earth", 0.5}}
r_core = pile{{"bone black", 2.4}, {"raw umber", 2}, {"red earth", 1.2}, {"vermilion", 0.4}}
g_lay  = pile{{"bone black", 1.5}, {"green earth", 2.2}, {"raw umber", 1.8}, {"Prussian blue", 0.2}}
g_mid  = pile{{"green earth", 2.2}, {"yellow ochre", 1.4}, {"raw umber", 0.8}, {"bone black", 0.4}}
g_lit  = pile{{"lead white", 2.2}, {"yellow ochre", 1.8}, {"green earth", 0.9}}
g_core = pile{{"bone black", 2.2}, {"green earth", 1.2}, {"raw umber", 1.8}, {"Prussian blue", 0.15}}
local sw = {r_lay, r_mid, r_lit, r_core, g_lay, g_mid, g_lit, g_core}
for i, p in ipairs(sw) do
  work(rect(848 + (i-1)*18, 130, 17, 150), {hand="body", tool="filbert 12", pile=p,
       length={20, 50}, coverage=3.2, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="found"})
end
print("red: lay mid lit core | green: lay mid lit core")
