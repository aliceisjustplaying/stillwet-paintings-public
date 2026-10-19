-- a colour test in a dark corner that the finishing glaze will cover anyway
-- candidates: a real ladder for the reds, dark to light
c1 = pile{{"vermilion", 1.6}, {"raw umber", 3}, {"red earth", 2.4}, {"bone black", 1.2}}
c2 = pile{{"red earth", 3}, {"vermilion", 1.0}, {"raw umber", 1.2}}
c3 = pile{{"lead white", 3}, {"yellow ochre", 1.8}, {"vermilion", 0.9}, {"red earth", 0.5}}
c4 = pile{{"vermilion", 0.8}, {"raw umber", 3}, {"red earth", 1.6}, {"bone black", 1.4}}
-- and for the green
c5 = pile{{"green earth", 2.0}, {"Prussian blue", 0.5}, {"raw umber", 2.8}, {"bone black", 1.0}}
c6 = pile{{"yellow ochre", 2.4}, {"green earth", 2.0}, {"raw umber", 1.0}, {"lead white", 0.3}}
c7 = pile{{"lead white", 2.6}, {"yellow ochre", 1.6}, {"green earth", 0.8}, {"raw umber", 0.3}}
local sw = {}
for i, p in ipairs{c1, c2, c3, c4, c5, c6, c7} do sw[i] = p end
for i = 1, 7 do
  work(rect(860 + (i-1)*18, 120, 17, 90), {hand="body", tool="filbert 12", pile=sw[i],
       length={20, 50}, coverage=3.2, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="found"})
end
print("swatches 1-4 red ladder, 5-7 green ladder")
