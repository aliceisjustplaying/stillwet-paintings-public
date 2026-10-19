-- take the lightness from yellow ochre (a light, chromatic earth), not from lead white
d1 = pile{{"yellow ochre", 2.2}, {"vermilion", 1.4}, {"red earth", 0.8}, {"lead white", 0.5}, {"raw umber", 0.2}}
d2 = pile{{"yellow ochre", 2.6}, {"vermilion", 1.0}, {"red earth", 0.6}, {"lead white", 0.6}}
d3 = pile{{"yellow ochre", 2.0}, {"green earth", 1.2}, {"lead white", 0.6}, {"raw umber", 0.2}}
d4 = pile{{"yellow ochre", 2.6}, {"green earth", 0.9}, {"lead white", 1.0}, {"raw umber", 0.2}}
d5 = pile{{"red earth", 2.6}, {"vermilion", 1.2}, {"raw umber", 0.8}, {"yellow ochre", 0.4}}
d6 = pile{{"yellow ochre", 2.2}, {"green earth", 1.8}, {"raw umber", 0.8}, {"red earth", 0.3}}
local sw2 = {d1, d2, d3, d4, d5, d6}
for i = 1, 6 do
  work(rect(866 + (i-1)*20, 232, 19, 88), {hand="body", tool="filbert 12", pile=sw2[i],
       length={20, 50}, coverage=3.2, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="found"})
end
print("row 2: 1,2 red lit | 3,4 green lit | 5 red mid | 6 green mid")
