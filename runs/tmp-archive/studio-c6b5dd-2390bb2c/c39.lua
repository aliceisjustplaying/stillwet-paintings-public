refl2O = outline{{-10,466,"c"},{466,466,"c"},{470,478},{462,490},{466,500},{450,511},{434,518},{424,532},{426,546},{408,558},{396,574},{392,592},{376,606},{372,624},{358,640},{352,660},{336,676},{330,698},{322,720,"c"},{-10,720,"c"}, closed=true, char="soft", seed=81, lobe=10, amount=1.0}
refl2 = refl2O:mask()
local nz2 = noise{seed=88, octaves=3, period=120, stretch={0, 4}}
local upper = refl2 * above(function(x) return 560 end)
local lower = refl2 - upper
pR1 = pile{{"Prussian blue",0.45},{"yellow ochre",1.0},{"raw umber",1.6},{"bone black",0.5},{"smalt",0.2}}
pR2 = pile{{"Prussian blue",0.4},{"yellow ochre",1.0},{"raw umber",1.4},{"bone black",0.35},{"smalt",0.4},{"lead white",0.12}}
work(upper, {hand="body", tool="filbert 12", pile=pR1, angle=0, angle_jitter=0.05, coverage=3.5, load=0.95, fill=true, length={40,110}, edge="soft"})
work(lower, {hand="body", tool="filbert 12", pile=pR2, angle=0, angle_jitter=0.05, coverage=3.2, load=0.9, fill=true, length={40,110}, edge="soft"})
blend(refl2, {angle=0, angle_jitter=0.02, tool="badger 30", pressure={0.25,0.45}})
