
--@ chunk 1
canvas{size=440, aspect=1.6, linen=15, seed=7, ground={{pile={{"lead white", 3}, {"yellow ochre", 1}}, um=120, apply="knife"}}}
--@ chunk 2
p = pile{{"lead white", 6}, {"cobalt blue", 1}, {"yellow ochre", 0.3}, medium=0.3}
work(rect(0, 0, 1000, 470), {hand="broad", pile=p, angle=0, coverage=4.5})
print(wait(0))
--@ chunk 3
print(wait(3 * 60))
stipple(rect(200, 380, 600, 120), {width=3, pile=pile{{"lead white", 1}}, coverage=1.5})
b = brush("round", 3); b:load(pile{{"bone black", 1}, {"raw umber", 1}}, 0.9)
for i = 1, 40 do b:stroke({{100 + 20 * i, 520}, {110 + 20 * i, 460}}) end
print(drying(500, 200), drying(500, 490))
