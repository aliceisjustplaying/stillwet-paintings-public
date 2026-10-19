--@ undone 1 · was chunk 1 · replaced by edit · 1766 bytes
-- Round 6 lab, subject "foliage": one broadleaf crown in summer leaf against the sky,
-- trunk mostly hidden. Shared setup for foliage_A (old way) and foliage_B (new way):
-- canvas, palette, world and sun, sky colors, the crown and trunk drawn, the tree grown.
canvas{style="friedrich", palette="friedrich_1820_greens", aspect=4/3, size=320, seed=61}
HZ = 688
WORLD = world{horizon=HZ, sun={azimuth=-120, elevation=42}}
SUN = {-0.6, -0.6, 0.45}
-- a summer afternoon sky: clear blue-gray above, pale and warm at the horizon
sky = function(x, y)
  return gradient({{0, "#6d86a8"}, {0.45, "#95a8bc"}, {0.85, "#c6cbc6"}, {1, "#d6d3c3"}}, y / HZ)
end
skypal = pal:only{"lead white", "pale smalt", "cobalt blue", "yellow ochre", "raw umber", "red earth"}
-- a far strip of land under the tree, hazy
land = below(function(x) return HZ + 3 * math.sin(x / 70) end)
landcol = function(x, y) return mix("#8d9278", "#5e6545", smoothstep(HZ, H, y)) end
-- the crown: broad, lopsided (heavier and lower on the right), lobed, a notch top left
CROWN = {{150,430},{128,350},{160,272},{214,214},{268,190},{300,150},{372,112},{452,92},{520,116,"c"},
         {578,96},{662,118},{736,170},{792,226},{842,300,"c"},{866,384},{846,452},{874,520,"c"},
         {820,574},{728,566},{652,598},{566,584},{480,606},{398,586},{312,600},{236,568,"c"},{176,508}}
TRUNK = {{508,752},{503,700},{497,640},{490,590}}
crown = outline{pts=CROWN, char="soft", seed=62}
tree = tree_in{crown=crown, trunk=TRUNK, species="oak", season="summer", sun=WORLD, seed=63}
print(tree)
-- leaf colors, deep shade to top light
LEAF = {deep="#212a1c", body="#34402a", sunny="#5c6a3a", shade="#263020", skyshade="#4a5446",
        mid="#46522e", lit="#6f7c45", top="#98a060"}
WOOD = {dark="#3b342c", light="#7d7566"}

--@ undone 2 · was chunk 3 · undone · 207 bytes

-- A chunk 3: a day later, the second sky layer stippled over the first (sketchbook 2)
wait(24*60)
stipple(skym, {width=2.6, color=sky, coverage=2.6, pressure={0.4, 0.8}, dips={18, 0.35, 0.7}, medium=0.55})

