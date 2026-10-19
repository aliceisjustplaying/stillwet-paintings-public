--@ undone 1 · was chunk 1 · undone · 1857 bytes
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
CROWN = {{166,452},{132,392},{146,318},{196,268},{236,236},{246,196},{296,160},{356,150},{400,118},
         {462,96},{516,112},{540,146,"c"},{582,116},{646,106},{714,136},{744,184},{798,210},{846,262},
         {858,326},{830,372,"c"},{870,418},{884,488},{850,540},{790,556},{742,588},{672,590},{620,566,"c"},
         {560,590},{470,600},{420,578},{360,598},{290,590},{240,552},{212,508,"c"}}
TRUNK = {{508,752},{503,700},{497,640},{490,590}}
crown = outline{pts=CROWN, char="soft", seed=62}
tree = tree_in{crown=crown, trunk=TRUNK, species="oak", season="summer", sun=WORLD, seed=63}
print(tree)
-- leaf colors, deep shade to top light
LEAF = {deep="#212a1c", body="#34402a", sunny="#5c6a3a", shade="#263020", skyshade="#4a5446",
        mid="#46522e", lit="#6f7c45", top="#98a060"}
WOOD = {dark="#3b342c", light="#7d7566"}

--@ undone 2 · was chunk 2 · undone · 366 bytes

-- B chunk 2: the sky as ONE thin layer, blended smooth (quiet surface); the far land as tone
skym = above(function(x) return HZ + 6 + 3 * math.sin(x / 70) end)
work(skym, {hand="broad", color=sky, angle=0, coverage=4.2, medium=0.3, pal=skypal})
blend(skym, {angle=0})
work(land, {hand="body", color=landcol, angle=0.02, length={20, 60}, coverage=3.4, medium=0.18})

--@ undone 3 · was chunk 2 · undone · 513 bytes

-- B chunk 2: the sky alla prima: two thin broad layers wet into wet, then one blend
-- (quiet surface: no stipple); the far land as tone
skym = above(function(x) return HZ + 6 + 3 * math.sin(x / 70) end)
work(skym, {hand="broad", color=sky, angle=0, coverage=4.2, medium=0.3, pal=skypal})
work(skym, {hand="broad", color=sky, angle=0.01, coverage=3.2, medium=0.25, pal=skypal})
blend(skym, {angle=0, coverage=2.5})
work(land, {hand="body", color=landcol, angle=0.02, length={20, 60}, coverage=3.4, medium=0.18})

--@ undone 4 · was chunk 2 · undone · 570 bytes

-- B chunk 2: the sky alla prima in one session: a full, lean first layer, a second
-- thin layer wet into wet, one light blend (quiet surface: no stipple); the far land as tone
skym = above(function(x) return HZ + 6 + 3 * math.sin(x / 70) end)
work(skym, {hand="broad", color=sky, angle=0, coverage=5, medium=0.22, load=1, pal=skypal})
work(skym, {hand="broad", color=sky, angle=0.01, coverage=3.5, medium=0.25, load=0.9, pal=skypal})
blend(skym, {angle=0, coverage=1.5})
work(land, {hand="body", color=landcol, angle=0.02, length={20, 60}, coverage=3.4, medium=0.18})

--@ undone 5 · was chunk 3 · undone · 1591 bytes

-- B chunk 3: an hour and a half later, the sky still open. The trunk, then the whole crown
-- as ONE connected dark mass with a big brush, laid into the open sky so its edge softens.
wait(90)
print("sky at the crown edge:", drying(160, 400), drying(820, 300))
local lv = tree:leaves()
MASS = lv:blur(6):map(function(v) return smoothstep(0.3, 0.55, v) end)
local Lb, Mb = tree:light():blur(10), lv:blur(10)
LB = mask(function(x, y) local m = Mb:at(x, y) if m < 0.05 then return 0 end return clamp(Lb:at(x, y) / m, 0, 1) end)
-- trunk: the stout wood below the crown, dark, into the wet land at its foot
local tr = tree:wood(9) * mask(function(x, y) return smoothstep(540, 580, y) end)
work(tr, {hand="body", tool="filbert 5", length={10, 30}, coverage=3.2, angle=1.55, angle_jitter=0.15, clip=tr, medium=0.18,
  color=function(x, y) return mix("#2e2a25", "#3d3831", smoothstep(620, 740, y)) end})
local fl = tr * mask(function(x, y) return 1 - tr:at(x + 5, y) end)
work(fl, {hand="body", tool="round 3", length={8, 20}, coverage=2, angle=1.55, clip=tr, medium=0.18, color="#6b6559"})
-- the crown mass: shadow family only, the light family comes later into it wet
local big = noise{seed=21, period=45}
work(MASS, {hand="body", tool="filbert 7", length={10, 24}, coverage=3.2, medium=0.22, hug=false, clip=MASS:grow(3),
  angle=function(x, y) return 2.0 * big(x, y) end, angle_jitter=0.5, curve={0.25, 0.1},
  color=function(x, y) local v = LB:at(x, y) return mix(mix("#1f281b", "#2f3a26", smoothstep(0.15, 0.5, v)), "#3e4a2c", smoothstep(0.55, 0.8, v)) end})
print("mass area", MASS:area())

--@ undone 6 · was chunk 2 · replaced by edit · 1064 bytes

-- B chunk 2: the crown planned as masses first (one silhouette with only its big holes, and
-- the light grouped into families), then the sky alla prima AROUND it: the crown is reserved
-- on the warm ground, the sky laid up to it and a little under its edge. Two thin broad layers
-- wet into wet and one light blend (quiet surface: no stipple); the far land as tone.
local lv = tree:leaves()
MASS = lv:blur(6):map(function(v) return smoothstep(0.3, 0.55, v) end)
local Lb, Mb = tree:light():blur(10), lv:blur(10)
LB = mask(function(x, y) local m = Mb:at(x, y) if m < 0.05 then return 0 end return clamp(Lb:at(x, y) / m, 0, 1) end)
skym = above(function(x) return HZ + 6 + 3 * math.sin(x / 70) end)
local sk = skym - MASS:shrink(10):soften(4)
work(sk, {hand="broad", color=sky, angle=0, coverage=5, medium=0.22, load=1, pal=skypal})
work(sk, {hand="broad", color=sky, angle=0.01, coverage=3.5, medium=0.25, load=0.9, pal=skypal})
blend(sk, {angle=0, coverage=1.5})
work(land, {hand="body", color=landcol, angle=0.02, length={20, 60}, coverage=3.4, medium=0.18})

--@ undone 7 · was chunk 3 · undone · 1193 bytes

-- B chunk 3: an hour and a half later, the sky still open. The trunk, then the whole crown
-- as ONE connected dark mass with a big brush, on the reserved ground; at its edge it runs
-- a little way into the open sky, so the edge softens.
wait(90)
print("sky at the crown edge:", drying(160, 400), drying(820, 300))
local tr = tree:wood(9) * mask(function(x, y) return smoothstep(540, 580, y) end)
work(tr, {hand="body", tool="filbert 5", length={10, 30}, coverage=3.2, angle=1.55, angle_jitter=0.15, clip=tr, medium=0.18,
  color=function(x, y) return mix("#2e2a25", "#3d3831", smoothstep(620, 740, y)) end})
local fl = tr * mask(function(x, y) return 1 - tr:at(x + 5, y) end)
work(fl, {hand="body", tool="round 3", length={8, 20}, coverage=2, angle=1.55, clip=tr, medium=0.18, color="#6b6559"})
local big = noise{seed=21, period=45}
work(MASS, {hand="body", tool="filbert 7", length={10, 24}, coverage=3.2, medium=0.22, hug=false, clip=MASS:grow(3),
  angle=function(x, y) return 2.0 * big(x, y) end, angle_jitter=0.5, curve={0.25, 0.1},
  color=function(x, y) local v = LB:at(x, y) return mix(mix("#1f281b", "#2f3a26", smoothstep(0.15, 0.5, v)), "#3e4a2c", smoothstep(0.55, 0.8, v)) end})

--@ undone 8 · was chunk 3 · undone · 1193 bytes

-- B chunk 3: an hour and a half later, the sky still open. The trunk, then the whole crown
-- as ONE connected dark mass with a big brush, on the reserved ground; at its edge it runs
-- a little way into the open sky, so the edge softens.
wait(90)
print("sky at the crown edge:", drying(160, 400), drying(820, 300))
local tr = tree:wood(9) * mask(function(x, y) return smoothstep(540, 580, y) end)
work(tr, {hand="body", tool="filbert 5", length={10, 30}, coverage=3.2, angle=1.55, angle_jitter=0.15, clip=tr, medium=0.18,
  color=function(x, y) return mix("#2e2a25", "#3d3831", smoothstep(620, 740, y)) end})
local fl = tr * mask(function(x, y) return 1 - tr:at(x + 5, y) end)
work(fl, {hand="body", tool="round 3", length={8, 20}, coverage=2, angle=1.55, clip=tr, medium=0.18, color="#6b6559"})
local big = noise{seed=21, period=45}
work(MASS, {hand="body", tool="filbert 7", length={10, 24}, coverage=3.2, medium=0.22, hug=false, clip=MASS:grow(3),
  angle=function(x, y) return 2.0 * big(x, y) end, angle_jitter=0.5, curve={0.25, 0.1},
  color=function(x, y) local v = LB:at(x, y) return mix(mix("#1f281b", "#2f3a26", smoothstep(0.15, 0.5, v)), "#3e4a2c", smoothstep(0.55, 0.8, v)) end})

--@ undone 9 · was chunk 3 · undone · 1193 bytes

-- B chunk 3: an hour and a half later, the sky still open. The trunk, then the whole crown
-- as ONE connected dark mass with a big brush, on the reserved ground; at its edge it runs
-- a little way into the open sky, so the edge softens.
wait(90)
print("sky at the crown edge:", drying(160, 400), drying(820, 300))
local tr = tree:wood(9) * mask(function(x, y) return smoothstep(540, 580, y) end)
work(tr, {hand="body", tool="filbert 5", length={10, 30}, coverage=3.2, angle=1.55, angle_jitter=0.15, clip=tr, medium=0.18,
  color=function(x, y) return mix("#2e2a25", "#3d3831", smoothstep(620, 740, y)) end})
local fl = tr * mask(function(x, y) return 1 - tr:at(x + 5, y) end)
work(fl, {hand="body", tool="round 3", length={8, 20}, coverage=2, angle=1.55, clip=tr, medium=0.18, color="#6b6559"})
local big = noise{seed=21, period=45}
work(MASS, {hand="body", tool="filbert 7", length={10, 24}, coverage=3.2, medium=0.22, hug=false, clip=MASS:grow(3),
  angle=function(x, y) return 2.0 * big(x, y) end, angle_jitter=0.5, curve={0.25, 0.1},
  color=function(x, y) local v = LB:at(x, y) return mix(mix("#1f281b", "#2f3a26", smoothstep(0.15, 0.5, v)), "#3e4a2c", smoothstep(0.55, 0.8, v)) end})

--@ undone 10 · was chunk 3 · undone · 1193 bytes

-- B chunk 3: an hour and a half later, the sky still open. The trunk, then the whole crown
-- as ONE connected dark mass with a big brush, on the reserved ground; at its edge it runs
-- a little way into the open sky, so the edge softens.
wait(90)
print("sky at the crown edge:", drying(160, 400), drying(820, 300))
local tr = tree:wood(9) * mask(function(x, y) return smoothstep(540, 580, y) end)
work(tr, {hand="body", tool="filbert 5", length={10, 30}, coverage=3.2, angle=1.55, angle_jitter=0.15, clip=tr, medium=0.18,
  color=function(x, y) return mix("#2e2a25", "#3d3831", smoothstep(620, 740, y)) end})
local fl = tr * mask(function(x, y) return 1 - tr:at(x + 5, y) end)
work(fl, {hand="body", tool="round 3", length={8, 20}, coverage=2, angle=1.55, clip=tr, medium=0.18, color="#6b6559"})
local big = noise{seed=21, period=45}
work(MASS, {hand="body", tool="filbert 7", length={10, 24}, coverage=3.2, medium=0.22, hug=false, clip=MASS:grow(3),
  angle=function(x, y) return 2.0 * big(x, y) end, angle_jitter=0.5, curve={0.25, 0.1},
  color=function(x, y) local v = LB:at(x, y) return mix(mix("#1f281b", "#2f3a26", smoothstep(0.15, 0.5, v)), "#3e4a2c", smoothstep(0.55, 0.8, v)) end})

--@ undone 11 · was chunk 3 · undone · 1194 bytes

-- B chunk 3: an hour and a half later, the sky still open. The trunk, then the whole crown
-- as ONE connected dark mass with a big brush, on the reserved ground; at its edge it runs
-- a little way into the open sky, so the edge softens.
wait(450)
print("sky at the crown edge:", drying(160, 400), drying(820, 300))
local tr = tree:wood(9) * mask(function(x, y) return smoothstep(540, 580, y) end)
work(tr, {hand="body", tool="filbert 5", length={10, 30}, coverage=3.2, angle=1.55, angle_jitter=0.15, clip=tr, medium=0.18,
  color=function(x, y) return mix("#2e2a25", "#3d3831", smoothstep(620, 740, y)) end})
local fl = tr * mask(function(x, y) return 1 - tr:at(x + 5, y) end)
work(fl, {hand="body", tool="round 3", length={8, 20}, coverage=2, angle=1.55, clip=tr, medium=0.18, color="#6b6559"})
local big = noise{seed=21, period=45}
work(MASS, {hand="body", tool="filbert 7", length={10, 24}, coverage=3.2, medium=0.22, hug=false, clip=MASS:grow(3),
  angle=function(x, y) return 2.0 * big(x, y) end, angle_jitter=0.5, curve={0.25, 0.1},
  color=function(x, y) local v = LB:at(x, y) return mix(mix("#1f281b", "#2f3a26", smoothstep(0.15, 0.5, v)), "#3e4a2c", smoothstep(0.55, 0.8, v)) end})

--@ undone 12 · was chunk 3 · undone · 1194 bytes

-- B chunk 3: an hour and a half later, the sky still open. The trunk, then the whole crown
-- as ONE connected dark mass with a big brush, on the reserved ground; at its edge it runs
-- a little way into the open sky, so the edge softens.
wait(930)
print("sky at the crown edge:", drying(160, 400), drying(820, 300))
local tr = tree:wood(9) * mask(function(x, y) return smoothstep(540, 580, y) end)
work(tr, {hand="body", tool="filbert 5", length={10, 30}, coverage=3.2, angle=1.55, angle_jitter=0.15, clip=tr, medium=0.18,
  color=function(x, y) return mix("#2e2a25", "#3d3831", smoothstep(620, 740, y)) end})
local fl = tr * mask(function(x, y) return 1 - tr:at(x + 5, y) end)
work(fl, {hand="body", tool="round 3", length={8, 20}, coverage=2, angle=1.55, clip=tr, medium=0.18, color="#6b6559"})
local big = noise{seed=21, period=45}
work(MASS, {hand="body", tool="filbert 7", length={10, 24}, coverage=3.2, medium=0.22, hug=false, clip=MASS:grow(3),
  angle=function(x, y) return 2.0 * big(x, y) end, angle_jitter=0.5, curve={0.25, 0.1},
  color=function(x, y) local v = LB:at(x, y) return mix(mix("#1f281b", "#2f3a26", smoothstep(0.15, 0.5, v)), "#3e4a2c", smoothstep(0.55, 0.8, v)) end})

--@ undone 13 · was chunk 2 · undone · 1091 bytes

-- B chunk 2: the crown planned as masses first (one silhouette with only its big holes, and
-- the light grouped into families), then the sky alla prima AROUND it: the crown is reserved
-- on the warm ground, the sky laid up to it and a little under its edge. Two thin broad layers
-- wet into wet and one light blend (quiet surface: no stipple); the far land as tone.
local lv = tree:leaves()
MASS = lv:blur(6):map(function(v) return smoothstep(0.3, 0.55, v) end)
local Lb, Mb = tree:light():blur(10), lv:blur(10)
LB = mask(function(x, y) local m = Mb:at(x, y) if m < 0.05 then return 0 end return clamp(Lb:at(x, y) / m, 0, 1) end)
skym = above(function(x) return HZ + 6 + 3 * math.sin(x / 70) end)
local sk = skym - MASS:shrink(10):soften(4)
work(sk, {hand="broad", color=sky, angle=0, coverage=5, medium=0.22, load=1, pal=skypal, clip=sk})
work(sk, {hand="broad", color=sky, angle=0.01, coverage=3.5, medium=0.25, load=0.9, pal=skypal, clip=sk})
blend(sk, {angle=0, coverage=1.5, clip=sk})
work(land, {hand="body", color=landcol, angle=0.02, length={20, 60}, coverage=3.4, medium=0.18})

--@ undone 14 · was chunk 3 · undone · 1193 bytes

-- B chunk 3: an hour and a half later, the sky still open. The trunk, then the whole crown
-- as ONE connected dark mass with a big brush, on the reserved ground; at its edge it runs
-- a little way into the open sky, so the edge softens.
wait(90)
print("sky at the crown edge:", drying(160, 400), drying(820, 300))
local tr = tree:wood(9) * mask(function(x, y) return smoothstep(540, 580, y) end)
work(tr, {hand="body", tool="filbert 5", length={10, 30}, coverage=3.2, angle=1.55, angle_jitter=0.15, clip=tr, medium=0.18,
  color=function(x, y) return mix("#2e2a25", "#3d3831", smoothstep(620, 740, y)) end})
local fl = tr * mask(function(x, y) return 1 - tr:at(x + 5, y) end)
work(fl, {hand="body", tool="round 3", length={8, 20}, coverage=2, angle=1.55, clip=tr, medium=0.18, color="#6b6559"})
local big = noise{seed=21, period=45}
work(MASS, {hand="body", tool="filbert 7", length={10, 24}, coverage=3.2, medium=0.22, hug=false, clip=MASS:grow(3),
  angle=function(x, y) return 2.0 * big(x, y) end, angle_jitter=0.5, curve={0.25, 0.1},
  color=function(x, y) local v = LB:at(x, y) return mix(mix("#1f281b", "#2f3a26", smoothstep(0.15, 0.5, v)), "#3e4a2c", smoothstep(0.55, 0.8, v)) end})

--@ undone 15 · was chunk 3 · undone · 1448 bytes

-- B chunk 3: an hour and a half later, the sky still open. The trunk, then the whole crown
-- as ONE connected dark mass with a big brush, on the reserved ground; at its edge it runs
-- a little way into the open sky, so the edge softens.
wait(90)
print("sky at the crown edge:", drying(160, 400), drying(820, 300))
local tr = tree:wood(9) * mask(function(x, y) return smoothstep(540, 580, y) end)
work(tr, {hand="body", tool="filbert 5", length={10, 30}, coverage=3.2, angle=1.55, angle_jitter=0.15, clip=tr, medium=0.18,
  color=function(x, y) return mix("#2e2a25", "#3d3831", smoothstep(620, 740, y)) end})
local fl = tr * mask(function(x, y) return 1 - tr:at(x + 5, y) end)
work(fl, {hand="body", tool="round 3", length={8, 20}, coverage=2, angle=1.55, clip=tr, medium=0.18, color="#6b6559"})
local big = noise{seed=21, period=45}
work(MASS, {hand="body", tool="filbert 7", length={10, 24}, coverage=3.2, medium=0.22, clip=MASS,
  angle=function(x, y) return 2.0 * big(x, y) end, angle_jitter=0.5, curve={0.25, 0.1},
  color=function(x, y) local v = LB:at(x, y) return mix(mix("#1f281b", "#2f3a26", smoothstep(0.15, 0.5, v)), "#3e4a2c", smoothstep(0.55, 0.8, v)) end})
-- the seam between the wet dark and the wet sky fused with a clean blender, short strokes across it
local seam = (MASS:grow(3) - MASS:shrink(3)):soften(1.5)
blend(seam, {tool="filbert 3", length={4, 9}, coverage=1.6, angle=function(x, y) return 2.0 * big(x, y) + 1.2 end})

--@ undone 16 · was chunk 3 · undone · 1174 bytes

-- B chunk 3: an hour and a half later, the sky still open. The trunk, then the whole crown
-- as ONE connected dark mass with a big brush, on the reserved ground; at its edge it runs
-- a little way into the open sky, so the edge softens.
wait(90)
print("sky at the crown edge:", drying(160, 400), drying(820, 300))
local tr = tree:wood(9) * mask(function(x, y) return smoothstep(540, 580, y) end)
work(tr, {hand="body", tool="filbert 5", length={10, 30}, coverage=3.2, angle=1.55, angle_jitter=0.15, clip=tr, medium=0.18,
  color=function(x, y) return mix("#2e2a25", "#3d3831", smoothstep(620, 740, y)) end})
local fl = tr * mask(function(x, y) return 1 - tr:at(x + 5, y) end)
work(fl, {hand="body", tool="round 3", length={8, 20}, coverage=2, angle=1.55, clip=tr, medium=0.18, color="#6b6559"})
local big = noise{seed=21, period=45}
work(MASS, {hand="body", tool="filbert 7", length={10, 24}, coverage=3.2, medium=0.22, clip=MASS,
  angle=function(x, y) return 2.0 * big(x, y) end, angle_jitter=0.5, curve={0.25, 0.1},
  color=function(x, y) local v = LB:at(x, y) return mix(mix("#1f281b", "#2f3a26", smoothstep(0.15, 0.5, v)), "#3e4a2c", smoothstep(0.55, 0.8, v)) end})

--@ undone 17 · was chunk 4 · undone · 1059 bytes

-- B chunk 4: an hour later, the dark still open. The lights, few and unequal, laid INTO the wet
-- dark with stiffer paint (medium 0.12): the half-light masses on the sun side, then the top lights
-- on a few of them. Short strokes turning with the lobes; hug=false so their edges thin into the dark.
wait(60)
print("dark:", drying(300, 300), drying(600, 400))
local big = noise{seed=21, period=45}
local way = function(x, y) return 2.0 * big(x, y) + 0.4 end
LIT = MASS:shrink(2) * LB:map(function(v) return smoothstep(0.52, 0.68, v) end)
TOP = MASS:shrink(3) * LB:map(function(v) return smoothstep(0.72, 0.86, v) end)
work(LIT, {hand="body", tool="filbert 4", length={6, 14}, coverage=2.2, medium=0.12, hug=false, clip=MASS,
  angle=way, angle_jitter=0.6, curve={0.3, 0.1},
  color=function(x, y) return mix("#4b5732", "#627040", smoothstep(0.6, 0.85, LB:at(x, y))) end})
work(TOP, {hand="body", tool="filbert 3", length={4, 10}, coverage=1.6, medium=0.1, hug=false, clip=MASS,
  angle=way, angle_jitter=0.7, color="#8a9456"})
print(LIT:area(), TOP:area())

--@ undone 18 · was chunk 4 · undone · 1059 bytes

-- B chunk 4: an hour later, the dark still open. The lights, few and unequal, laid INTO the wet
-- dark with stiffer paint (medium 0.12): the half-light masses on the sun side, then the top lights
-- on a few of them. Short strokes turning with the lobes; hug=false so their edges thin into the dark.
wait(60)
print("dark:", drying(300, 300), drying(600, 400))
local big = noise{seed=21, period=45}
local way = function(x, y) return 2.0 * big(x, y) + 0.4 end
LIT = MASS:shrink(2) * LB:map(function(v) return smoothstep(0.52, 0.68, v) end)
TOP = MASS:shrink(3) * LB:map(function(v) return smoothstep(0.72, 0.86, v) end)
work(LIT, {hand="body", tool="filbert 4", length={6, 14}, coverage=2.2, medium=0.12, hug=false, clip=MASS,
  angle=way, angle_jitter=0.6, curve={0.3, 0.1},
  color=function(x, y) return mix("#4b5732", "#627040", smoothstep(0.6, 0.85, LB:at(x, y))) end})
work(TOP, {hand="body", tool="filbert 3", length={4, 10}, coverage=1.6, medium=0.1, hug=false, clip=MASS,
  angle=way, angle_jitter=0.7, color="#8a9456"})
print(LIT:area(), TOP:area())

--@ undone 19 · was chunk 4 · undone · 1060 bytes

-- B chunk 4: an hour later, the dark still open. The lights, few and unequal, laid INTO the wet
-- dark with stiffer paint (medium 0.12): the half-light masses on the sun side, then the top lights
-- on a few of them. Short strokes turning with the lobes; hug=false so their edges thin into the dark.
wait(480)
print("dark:", drying(300, 300), drying(600, 400))
local big = noise{seed=21, period=45}
local way = function(x, y) return 2.0 * big(x, y) + 0.4 end
LIT = MASS:shrink(2) * LB:map(function(v) return smoothstep(0.52, 0.68, v) end)
TOP = MASS:shrink(3) * LB:map(function(v) return smoothstep(0.72, 0.86, v) end)
work(LIT, {hand="body", tool="filbert 4", length={6, 14}, coverage=2.2, medium=0.12, hug=false, clip=MASS,
  angle=way, angle_jitter=0.6, curve={0.3, 0.1},
  color=function(x, y) return mix("#4b5732", "#627040", smoothstep(0.6, 0.85, LB:at(x, y))) end})
work(TOP, {hand="body", tool="filbert 3", length={4, 10}, coverage=1.6, medium=0.1, hug=false, clip=MASS,
  angle=way, angle_jitter=0.7, color="#8a9456"})
print(LIT:area(), TOP:area())

--@ undone 20 · was chunk 4 · undone · 1111 bytes

-- B chunk 4: an hour later, the dark still open. The lights, few and unequal, laid INTO the wet
-- dark with stiffer paint (medium 0.12): the half-light masses on the sun side, then the top lights
-- on a few of them. Short strokes turning with the lobes; hug=false so their edges thin into the dark.
wait(60)
print("dark:", drying(300, 300), drying(600, 400))
local big = noise{seed=21, period=45}
local way = function(x, y) return 2.0 * big(x, y) + 0.4 end
LIT = MASS:shrink(2) * LB:map(function(v) return smoothstep(0.52, 0.68, v) end)
TOP = MASS:shrink(3) * LB:map(function(v) return smoothstep(0.72, 0.86, v) end)
work(LIT, {hand="body", tool="filbert 4", length={6, 14}, coverage=2.2, medium=0.12, load=0.4, aim="masstone", hug=false, clip=MASS,
  angle=way, angle_jitter=0.6, curve={0.3, 0.1},
  color=function(x, y) return mix("#4b5732", "#627040", smoothstep(0.6, 0.85, LB:at(x, y))) end})
work(TOP, {hand="body", tool="filbert 3", length={4, 10}, coverage=1.6, medium=0.1, load=0.4, aim="masstone", hug=false, clip=MASS,
  angle=way, angle_jitter=0.7, color="#8a9456"})
print(LIT:area(), TOP:area())

--@ undone 21 · was chunk 4 · undone · 1079 bytes

-- B chunk 4: an hour later, the dark still open. The lights, few and unequal, laid INTO the wet
-- dark with stiffer paint (medium 0.12): the half-light masses on the sun side, then the top lights
-- on a few of them. Short strokes turning with the lobes; hug=false so their edges thin into the dark.
wait(60)
print("dark:", drying(300, 300), drying(600, 400))
local big = noise{seed=21, period=45}
local way = function(x, y) return 2.0 * big(x, y) + 0.4 end
LIT = MASS:shrink(2) * LB:map(function(v) return smoothstep(0.52, 0.68, v) end)
TOP = MASS:shrink(3) * LB:map(function(v) return smoothstep(0.72, 0.86, v) end)
work(LIT, {hand="body", tool="filbert 4", length={6, 14}, coverage=2.2, medium=0.12, load=0.4, hug=false, clip=MASS,
  angle=way, angle_jitter=0.6, curve={0.3, 0.1},
  color=function(x, y) return mix("#4b5732", "#627040", smoothstep(0.6, 0.85, LB:at(x, y))) end})
work(TOP, {hand="body", tool="filbert 3", length={4, 10}, coverage=1.6, medium=0.1, load=0.4, hug=false, clip=MASS,
  angle=way, angle_jitter=0.7, color="#8a9456"})
print(LIT:area(), TOP:area())

--@ undone 22 · was chunk 4 · undone · 1091 bytes

-- B chunk 4: an hour later, the dark still open. The lights, few and unequal, laid INTO the wet
-- dark with stiffer paint (medium 0.12): the half-light masses on the sun side, then the top lights
-- on a few of them. Short strokes turning with the lobes; hug=false so their edges thin into the dark.
wait(60)
print("dark:", drying(300, 300), drying(600, 400))
local big = noise{seed=21, period=45}
local way = function(x, y) return 2.0 * big(x, y) + 0.4 end
LIT = MASS:shrink(2) * LB:map(function(v) return smoothstep(0.52, 0.68, v) end)
TOP = MASS:shrink(3) * LB:map(function(v) return smoothstep(0.72, 0.86, v) end)
work(LIT, {hand="body", tool="filbert 4", length={6, 14}, coverage=2.2, medium=0.12, aim="masstone", hug=false, clip=MASS,
  angle=way, angle_jitter=0.6, curve={0.3, 0.1},
  color=function(x, y) return mix("#4b5732", "#627040", smoothstep(0.6, 0.85, LB:at(x, y))) end})
work(TOP, {hand="body", tool="filbert 3", length={4, 10}, coverage=1.6, medium=0.1, aim="masstone", hug=false, clip=MASS,
  angle=way, angle_jitter=0.7, color="#8a9456"})
print(LIT:area(), TOP:area())

--@ undone 23 · was chunk 4 · undone · 1060 bytes

-- B chunk 4: an hour later, the dark still open. The lights, few and unequal, laid INTO the wet
-- dark with stiffer paint (medium 0.12): the half-light masses on the sun side, then the top lights
-- on a few of them. Short strokes turning with the lobes; hug=false so their edges thin into the dark.
wait(480)
print("dark:", drying(300, 300), drying(600, 400))
local big = noise{seed=21, period=45}
local way = function(x, y) return 2.0 * big(x, y) + 0.4 end
LIT = MASS:shrink(2) * LB:map(function(v) return smoothstep(0.52, 0.68, v) end)
TOP = MASS:shrink(3) * LB:map(function(v) return smoothstep(0.72, 0.86, v) end)
work(LIT, {hand="body", tool="filbert 4", length={6, 14}, coverage=2.2, medium=0.12, hug=false, clip=MASS,
  angle=way, angle_jitter=0.6, curve={0.3, 0.1},
  color=function(x, y) return mix("#4b5732", "#627040", smoothstep(0.6, 0.85, LB:at(x, y))) end})
work(TOP, {hand="body", tool="filbert 3", length={4, 10}, coverage=1.6, medium=0.1, hug=false, clip=MASS,
  angle=way, angle_jitter=0.7, color="#8a9456"})
print(LIT:area(), TOP:area())

--@ undone 24 · was chunk 4 · undone · 1060 bytes

-- B chunk 4: an hour later, the dark still open. The lights, few and unequal, laid INTO the wet
-- dark with stiffer paint (medium 0.12): the half-light masses on the sun side, then the top lights
-- on a few of them. Short strokes turning with the lobes; hug=false so their edges thin into the dark.
wait(900)
print("dark:", drying(300, 300), drying(600, 400))
local big = noise{seed=21, period=45}
local way = function(x, y) return 2.0 * big(x, y) + 0.4 end
LIT = MASS:shrink(2) * LB:map(function(v) return smoothstep(0.52, 0.68, v) end)
TOP = MASS:shrink(3) * LB:map(function(v) return smoothstep(0.72, 0.86, v) end)
work(LIT, {hand="body", tool="filbert 4", length={6, 14}, coverage=2.2, medium=0.12, hug=false, clip=MASS,
  angle=way, angle_jitter=0.6, curve={0.3, 0.1},
  color=function(x, y) return mix("#4b5732", "#627040", smoothstep(0.6, 0.85, LB:at(x, y))) end})
work(TOP, {hand="body", tool="filbert 3", length={4, 10}, coverage=1.6, medium=0.1, hug=false, clip=MASS,
  angle=way, angle_jitter=0.7, color="#8a9456"})
print(LIT:area(), TOP:area())

--@ undone 25 · was chunk 4 · undone · 1061 bytes

-- B chunk 4: an hour later, the dark still open. The lights, few and unequal, laid INTO the wet
-- dark with stiffer paint (medium 0.12): the half-light masses on the sun side, then the top lights
-- on a few of them. Short strokes turning with the lobes; hug=false so their edges thin into the dark.
wait(1440)
print("dark:", drying(300, 300), drying(600, 400))
local big = noise{seed=21, period=45}
local way = function(x, y) return 2.0 * big(x, y) + 0.4 end
LIT = MASS:shrink(2) * LB:map(function(v) return smoothstep(0.52, 0.68, v) end)
TOP = MASS:shrink(3) * LB:map(function(v) return smoothstep(0.72, 0.86, v) end)
work(LIT, {hand="body", tool="filbert 4", length={6, 14}, coverage=2.2, medium=0.12, hug=false, clip=MASS,
  angle=way, angle_jitter=0.6, curve={0.3, 0.1},
  color=function(x, y) return mix("#4b5732", "#627040", smoothstep(0.6, 0.85, LB:at(x, y))) end})
work(TOP, {hand="body", tool="filbert 3", length={4, 10}, coverage=1.6, medium=0.1, hug=false, clip=MASS,
  angle=way, angle_jitter=0.7, color="#8a9456"})
print(LIT:area(), TOP:area())

--@ undone 26 · was chunk 2 · replaced by edit · 1113 bytes

-- B chunk 2: the crown planned as masses first (one silhouette with only its big holes, and
-- the light grouped into families), then the sky alla prima AROUND it: the crown is reserved
-- on the warm ground, the sky laid up to its edge (dark over wet sky turns to a pale lace). Two thin broad layers
-- wet into wet and one light blend (quiet surface: no stipple); the far land as tone.
local lv = tree:leaves()
MASS = lv:blur(6):map(function(v) return smoothstep(0.3, 0.55, v) end)
local Lb, Mb = tree:light():blur(10), lv:blur(10)
LB = mask(function(x, y) local m = Mb:at(x, y) if m < 0.05 then return 0 end return clamp(Lb:at(x, y) / m, 0, 1) end)
skym = above(function(x) return HZ + 6 + 3 * math.sin(x / 70) end)
local sk = skym - MASS:shrink(1.5):soften(1.5)
work(sk, {hand="broad", color=sky, angle=0, coverage=5, medium=0.22, load=1, pal=skypal, clip=sk})
work(sk, {hand="broad", color=sky, angle=0.01, coverage=3.5, medium=0.25, load=0.9, pal=skypal, clip=sk})
blend(sk, {angle=0, coverage=1.5, clip=sk})
work(land, {hand="body", color=landcol, angle=0.02, length={20, 60}, coverage=3.4, medium=0.18})

--@ undone 27 · was chunk 3 · replaced by edit · 1184 bytes

-- B chunk 3: an hour and a half later, the sky still open. The trunk, then the whole crown
-- as ONE connected dark mass with a big brush, on the reserved ground; at its edge it runs
-- a little way into the open sky, so the edge softens.
wait(90)
print("sky at the crown edge:", drying(160, 400), drying(820, 300))
local tr = tree:wood(9) * mask(function(x, y) return smoothstep(540, 580, y) end)
work(tr, {hand="body", tool="filbert 5", length={10, 30}, coverage=3.2, angle=1.55, angle_jitter=0.15, clip=tr, medium=0.18,
  color=function(x, y) return mix("#2e2a25", "#3d3831", smoothstep(620, 740, y)) end})
local fl = tr * mask(function(x, y) return 1 - tr:at(x + 5, y) end)
work(fl, {hand="body", tool="round 3", length={8, 20}, coverage=2, angle=1.55, clip=tr, medium=0.18, color="#6b6559"})
local big = noise{seed=21, period=45}
work(MASS, {hand="body", tool="filbert 7", length={10, 24}, coverage=2.6, medium=0.3, load=0.55, clip=MASS,
  angle=function(x, y) return 2.0 * big(x, y) end, angle_jitter=0.5, curve={0.25, 0.1},
  color=function(x, y) local v = LB:at(x, y) return mix(mix("#1f281b", "#2f3a26", smoothstep(0.15, 0.5, v)), "#3e4a2c", smoothstep(0.55, 0.8, v)) end})

--@ undone 28 · was chunk 4 · replaced by edit · 1164 bytes

-- B chunk 4: 15 hours later, the dark SETTING (open: the lights plowed it into a camouflage mottle
-- down to the ground; tacky: flat poster slabs). The lights, few and unequal, laid into the setting
-- dark with stiffer paint (medium 0.12): the half-light masses on the sun side, then the top lights
-- on a few of them. Short strokes turning with the lobes; hug=false so their edges thin into the dark.
wait(900)
print("dark:", drying(300, 300), drying(600, 400))
local big = noise{seed=21, period=45}
local way = function(x, y) return 2.0 * big(x, y) + 0.4 end
LIT = MASS:shrink(2) * LB:map(function(v) return smoothstep(0.52, 0.68, v) end)
TOP = MASS:shrink(3) * LB:map(function(v) return smoothstep(0.72, 0.86, v) end)
work(LIT, {hand="body", tool="filbert 4", length={6, 14}, coverage=2.2, medium=0.12, hug=false, clip=MASS,
  angle=way, angle_jitter=0.6, curve={0.3, 0.1},
  color=function(x, y) return mix("#4b5732", "#627040", smoothstep(0.6, 0.85, LB:at(x, y))) end})
work(TOP, {hand="body", tool="filbert 3", length={4, 10}, coverage=1.6, medium=0.1, hug=false, clip=MASS,
  angle=way, angle_jitter=0.7, color="#8a9456"})
print(LIT:area(), TOP:area())

--@ undone 29 · was chunk 4 · replaced by edit · 1459 bytes

-- B chunk 4: 15 hours later, the dark SETTING (open: the lights plowed it into a camouflage mottle
-- down to the ground; tacky: flat poster slabs). The lights, few and unequal, laid into the setting
-- dark with stiffer paint (medium 0.12): the half-light masses on the sun side, then the top lights
-- on a few of them. Short strokes turning with the lobes; hug=false so their edges thin into the dark.
wait(900)
print("dark:", drying(300, 300), drying(600, 400))
local big = noise{seed=21, period=45}
local way = function(x, y) return 2.0 * big(x, y) + 0.4 end
LIT = MASS:shrink(2) * LB:map(function(v) return smoothstep(0.52, 0.68, v) end)
TOP = MASS:shrink(3) * LB:map(function(v) return smoothstep(0.72, 0.86, v) end)
work(LIT, {hand="body", tool="filbert 4", length={6, 14}, coverage=2.2, medium=0.12, hug=false, clip=MASS,
  angle=way, angle_jitter=0.6, curve={0.3, 0.1},
  color=function(x, y) return mix("#4b5732", "#627040", smoothstep(0.6, 0.85, LB:at(x, y))) end})
work(TOP, {hand="body", tool="filbert 3", length={4, 10}, coverage=1.6, medium=0.1, hug=false, clip=MASS,
  angle=way, angle_jitter=0.7, color="#8a9456"})
print(LIT:area(), TOP:area())
-- the trunk's lit flank now, into the setting trunk (laid wet it plowed through to the ground)
local fl = TRUNKM * mask(function(x, y) return 1 - TRUNKM:at(x + 5, y) end)
work(fl, {hand="body", tool="round 3", length={8, 20}, coverage=2, angle=1.55, clip=TRUNKM, medium=0.12, color="#6b6559"})

--@ undone 30 · was chunk 4 · replaced by edit · 1792 bytes

-- B chunk 4: 15 hours later, the dark SETTING (open: the lights plowed it into a camouflage mottle
-- down to the ground; tacky: flat poster slabs). The lights, few and unequal, laid into the setting
-- dark with stiffer paint (medium 0.12): the half-light masses on the sun side, then the top lights
-- on a few of them. Short strokes turning with the lobes; hug=false so their edges thin into the dark.
wait(900)
print("dark:", drying(300, 300), drying(600, 400))
local big = noise{seed=21, period=45}
local way = function(x, y) return 2.0 * big(x, y) + 0.4 end
LIT = MASS:shrink(2) * LB:map(function(v) return smoothstep(0.52, 0.68, v) end)
TOP = MASS:shrink(3) * LB:map(function(v) return smoothstep(0.72, 0.86, v) end)
work(LIT, {hand="body", tool="filbert 4", length={6, 14}, coverage=2.2, medium=0.12, hug=false, clip=MASS,
  angle=way, angle_jitter=0.6, curve={0.3, 0.1},
  color=function(x, y) return mix("#4b5732", "#627040", smoothstep(0.6, 0.85, LB:at(x, y))) end})
work(TOP, {hand="body", tool="filbert 3", length={4, 10}, coverage=1.6, medium=0.1, hug=false, clip=MASS,
  angle=way, angle_jitter=0.7, color="#8a9456"})
print(LIT:area(), TOP:area())
-- the trunk again into its setting paint (one pass left the ground in streaks), then its lit
-- flank on the sun side; both only below the crown (in it, a flank reads as a gray pole)
local trv = TRUNKM - MASS
work(trv, {hand="body", tool="filbert 4", length={10, 24}, coverage=2.4, load=0.7, angle=1.55, angle_jitter=0.1, clip=trv, medium=0.14,
  color=function(x, y) return mix("#2f2a25", "#3a342d", smoothstep(620, 740, y)) end})
local fl = trv * mask(function(x, y) return 1 - TRUNKM:at(x - 6, y) end)
work(fl, {hand="body", tool="round 3", length={8, 20}, coverage=1.8, angle=1.55, clip=trv, medium=0.12, color="#6b6559"})

--@ undone 31 · was chunk 5 · undone · 1495 bytes
-- B chunk 5: the same session, the dark still setting. A few unequal sky holes, drawn where the
-- limb masses part and a limb crosses (so a branch fragment can show), laid with sky paint INTO
-- the setting dark; then the silhouette broken by a share of the tree's own touches along the rim
-- only (dark on the shade side, lit on the sun side), never inside the masses.
print("dark:", drying(425, 318), "sky at rim:", drying(120, 330), drying(900, 480))
HOLEPTS = {{425,318,20,12,0.3},{690,293,16,10,-0.4},{760,445,22,11,0.2},{330,520,18,10,-0.2},
           {560,393,11,7,0.5},{480,150,10,7,0},{812,505,12,8,0.3}}
local h = nil
for i, p in ipairs(HOLEPTS) do local e = ellipse(p[1], p[2], p[3], p[4]) h = h and (h + e) or e end
HOLES = h:roughen(5, 9, 5, 1.5)
work(HOLES, {hand="body", tool="filbert 3", length={4, 10}, coverage=2.6, medium=0.2, hug=false, clip=HOLES:grow(1.5),
  angle=0.1, angle_jitter=0.6, color=sky})
RIM = MASS:grow(8) - MASS:shrink(8)
local function onrim(lo, hi) return function(t) return t end end
local b = brush("round", tree.touch_w)
local n = 0
n = n + tree:paint(b, {color="#243020", lit={0, 0.45}, clip=RIM, share=0.45})
n = n + tree:paint(b, {color="#4a5446", lit={0.2, 0.45}, depth={0.3, 1}, clip=RIM, share=0.2})
n = n + tree:paint(brush("round", tree.touch_w * 0.9), {color="#55623a", lit={0.45, 0.7}, clip=RIM, share=0.4})
n = n + tree:paint(brush("round", tree.touch_w * 0.8), {color="#8a9456", lit={0.7, 1}, clip=RIM, share=0.4})
print("rim touches", n)

--@ undone 32 · was chunk 5 · undone · 1658 bytes
-- B chunk 5: the same session, the dark still setting. A few unequal sky holes, drawn where the
-- limb masses part and a limb crosses (so a branch fragment can show), laid with sky paint INTO
-- the setting dark: thin (masstone, load 0.5; the default aim piled it 500 um thick into white
-- cotton), a shade grayer than the open sky, since sky seen through leaves reads darker.
print("dark:", drying(425, 318), "sky at rim:", drying(120, 330), drying(900, 480))
HOLEPTS = {{425,318,20,12,0.3},{690,293,16,10,-0.4},{760,445,22,11,0.2},{330,520,18,10,-0.2},
           {560,393,11,7,0.5},{480,150,10,7,0},{812,505,12,8,0.3}}
local h = nil
for i, p in ipairs(HOLEPTS) do local e = ellipse(p[1], p[2], p[3], p[4]) h = h and (h + e) or e end
HOLES = h:roughen(5, 9, 5, 1.5)
work(HOLES, {hand="body", tool="filbert 3", length={4, 10}, coverage=2.4, medium=0.3, load=0.5, aim="masstone", hug=false,
  clip=HOLES:grow(1.5), angle=0.1, angle_jitter=0.6, color=function(x, y) return mix(sky(x, y), "#707c80", 0.22) end})
-- the silhouette broken only by the tree's own touches that reach OUT past the mass (517 of 38,586)
local picked = {}
for _, t in ipairs(tree:touches{}) do local p = t.pts[#t.pts] if MASS:at(p[1], p[2]) < 0.5 then picked[#picked + 1] = t end end
local bd, bl = brush("round", tree.touch_w), brush("round", tree.touch_w * 0.85)
for i, t in ipairs(picked) do
  local lit = t.lit
  local b = lit > 0.55 and bl or bd
  if i % 6 == 1 or b:fullness() < 0.3 then
    bd:reload("#26311f", 0.8)
    bl:reload(lit > 0.72 and "#7f8a4e" or "#56633a", 0.8)
  end
  b:stroke(t.pts, {pressure={0.75, 0.05}, ramps={0.1, 0.6}})
end
print("rim touches", #picked)

--@ undone 33 · was chunk 4 · undone · 1486 bytes

-- B chunk 4: 15 hours later, the dark SETTING (open: the lights plowed it into a camouflage mottle
-- down to the ground; tacky: flat poster slabs). The lights, few and unequal, laid into the setting
-- dark with stiffer paint (medium 0.12): the half-light masses on the sun side, then the top lights
-- on a few of them. Short strokes turning with the lobes; hug=false so their edges thin into the dark.
wait(900)
print("dark:", drying(300, 300), drying(600, 400))
local big = noise{seed=21, period=45}
local way = function(x, y) return 2.0 * big(x, y) + 0.4 end
LIT = MASS:shrink(2) * LB:map(function(v) return smoothstep(0.52, 0.68, v) end)
TOP = MASS:shrink(3) * LB:map(function(v) return smoothstep(0.72, 0.86, v) end)
work(LIT, {hand="body", tool="filbert 4", length={6, 14}, coverage=2.2, medium=0.12, hug=false, clip=MASS,
  angle=way, angle_jitter=0.6, curve={0.3, 0.1},
  color=function(x, y) return mix("#4b5732", "#627040", smoothstep(0.6, 0.85, LB:at(x, y))) end})
work(TOP, {hand="body", tool="filbert 3", length={4, 10}, coverage=1.6, medium=0.1, hug=false, clip=MASS,
  angle=way, angle_jitter=0.7, color="#8a9456"})
print(LIT:area(), TOP:area())
-- the trunk's lit flank on the sun side, only below the crown (in it, a flank reads as a gray pole)
local trv = TRUNKM - MASS
local fl = trv * mask(function(x, y) return 1 - TRUNKM:at(x - 6, y) end)
work(fl, {hand="body", tool="round 3", length={8, 20}, coverage=1.8, angle=1.55, clip=trv, medium=0.12, color="#6b6559"})

--@ undone 34 · was chunk 2 · replaced by edit · 1282 bytes

-- B chunk 2: the crown planned as masses first (one silhouette with only its big holes, and
-- the light grouped into families), then the sky alla prima AROUND it: the crown is reserved
-- on the warm ground, the sky laid up to its edge (dark over wet sky turns to a pale lace); the trunk reserved too. Two thin broad layers
-- wet into wet and one light blend (quiet surface: no stipple); the far land as tone.
local lv = tree:leaves()
MASS = lv:blur(6):map(function(v) return smoothstep(0.3, 0.55, v) end)
local Lb, Mb = tree:light():blur(10), lv:blur(10)
LB = mask(function(x, y) local m = Mb:at(x, y) if m < 0.05 then return 0 end return clamp(Lb:at(x, y) / m, 0, 1) end)
skym = above(function(x) return HZ + 6 + 3 * math.sin(x / 70) end)
TRUNKM = tree:wood(9) * mask(function(x, y) return smoothstep(540, 580, y) end)
local sk = skym - MASS:shrink(1.5):soften(1.5) - TRUNKM:shrink(1.5)
work(sk, {hand="broad", color=sky, angle=0, coverage=5, medium=0.22, load=1, pal=skypal, clip=sk})
work(sk, {hand="broad", color=sky, angle=0.01, coverage=3.5, medium=0.25, load=0.9, pal=skypal, clip=sk})
blend(sk, {angle=0, coverage=1.5, clip=sk})
local ld = land - TRUNKM:shrink(1.5)
work(ld, {hand="body", color=landcol, angle=0.02, length={20, 60}, coverage=3.4, medium=0.18, clip=ld})

--@ undone 35 · was chunk 6 · undone · 666 bytes
-- B chunk 6: next morning (the sky in the holes setting to tacky). A few limb fragments: only
-- where the wood crosses a sky hole or shows under the crown's lower edge; nowhere else.
wait(1020)
print("holes:", drying(425,318), drying(760,445), drying(330,520), "under the crown:", drying(480, 600))
local seen = (HOLES:grow(3) + (-MASS:shrink(2)) * mask(function(x, y) return smoothstep(500, 540, y) end)) * crown:mask():grow(20)
local n = 0
n = n + tree:paint_wood(brush("round", 2.4), {color="#34302a", min=1.6, clip=seen})
n = n + tree:paint_wood(brush("rigger", 0.9), {color="#3b3730", min=0.7, max=1.6, clip=seen})
print("wood strokes (most clipped away)", n)

--@ undone 36 · was chunk 7 · undone · 1087 bytes
-- B chunk 7: the same day. The accents, a very few: the front shade masses catch the blue sky
-- (a cool gray-green, thin, scumbled into the setting dark: volume in the dark half), and the
-- brightest lights, ~40 single touches, on the tops of the lit lobes.
print("dark:", drying(700, 480), drying(300, 250))
local fs = tree:leaves{depth={0.35, 1}, lit={0.12, 0.45}}:blur(5):map(function(v) return smoothstep(0.35, 0.7, v) end) * MASS:shrink(4)
work(fs, {hand="body", tool="filbert 4", length={6, 14}, coverage=1.3, medium=0.25, load=0.45, hug=false, clip=MASS,
  angle=function(x, y) return 0.5 + 0.8 * math.sin(x / 40 + y / 55) end, angle_jitter=0.6, color="#434d42"})
local top, k = {}, 0
for _, t in ipairs(tree:touches{lit={0.86, 1}}) do k = k + 1 if k % 45 == 0 and MASS:at(t.pts[1][1], t.pts[1][2]) > 0.8 then top[#top + 1] = t end end
local b = brush("round", tree.touch_w * 0.9)
for i, t in ipairs(top) do
  if i % 8 == 1 then b:reload("#a5aa6c", 0.7) end
  b:stroke(t.pts, {pressure={0.8, 0.1}, ramps={0.1, 0.6}})
end
print("front shade area", fs:area(), "top lights", #top)

--@ undone 37 · was chunk 7 · undone · 1132 bytes
-- B chunk 7: the same day. The accents, a very few: the front shade masses catch the blue sky
-- (a cool green only a step off the dark, thin and feathered: at a full step
-- lighter over the tacky dark it made flat gray slabs), and the
-- brightest lights, ~40 single touches, on the tops of the lit lobes.
print("dark:", drying(700, 480), drying(300, 250))
local fs = tree:leaves{depth={0.6, 1}, lit={0.15, 0.4}}:blur(4):map(function(v) return smoothstep(0.45, 0.8, v) end) * MASS:shrink(4)
work(fs, {hand="body", tool="filbert 4", length={6, 14}, coverage=0.9, medium=0.3, load=0.35, hug=false, clip=MASS,
  angle=function(x, y) return 0.5 + 0.8 * math.sin(x / 40 + y / 55) end, angle_jitter=0.6, color="#353f35"})
local top, k = {}, 0
for _, t in ipairs(tree:touches{lit={0.86, 1}}) do k = k + 1 if k % 45 == 0 and MASS:at(t.pts[1][1], t.pts[1][2]) > 0.8 then top[#top + 1] = t end end
local b = brush("round", tree.touch_w * 0.9)
for i, t in ipairs(top) do
  if i % 8 == 1 then b:reload("#a5aa6c", 0.7) end
  b:stroke(t.pts, {pressure={0.8, 0.1}, ramps={0.1, 0.6}})
end
print("front shade area", fs:area(), "top lights", #top)

--@ undone 38 · was chunk 6 · replaced by edit · 796 bytes
-- B chunk 6: next morning (the sky in the holes setting to tacky). A few limb fragments, only
-- where the wood crosses a sky hole; nowhere else. The wood there a little stouter than grown,
-- so a fragment reads at arm's length; a lighter flank on the sun side of the stoutest.
wait(1020)
print("holes:", drying(425,318), drying(760,445), drying(330,520))
LIMBS = tree:wood(1.3):grow(0.8) * HOLES:grow(4)
work(LIMBS, {hand="detail", tool="round 1.6", length={3, 8}, coverage=3, clip=LIMBS, medium=0.14, color="#2f2b26"})
local st = tree:wood(2.6):grow(0.8) * HOLES:grow(4)
local fl = st * mask(function(x, y) return 1 - st:at(x - 1.6, y + 0.6) end)
work(fl, {hand="detail", tool="round 1", length={2, 5}, coverage=1.6, clip=LIMBS, medium=0.12, color="#7a7466"})
print("limb area", LIMBS:area())

--@ undone 39 · was chunk 6 · replaced by edit · 550 bytes
-- B chunk 6: next morning (the sky in the holes setting to tacky). A few limb fragments, only
-- where the wood crosses a sky hole; nowhere else. Dark silhouettes only, a touch stouter than
-- grown so they read (with a lit flank, at 3200 they looked like crossed planks).
wait(1020)
print("holes:", drying(425,318), drying(760,445), drying(330,520))
LIMBS = tree:wood(1.3):grow(0.35) * HOLES:grow(4)
work(LIMBS, {hand="detail", tool="round 1.4", length={3, 8}, coverage=3, clip=LIMBS, medium=0.14, color="#2f2b26"})
print("limb area", LIMBS:area())

--@ undone 40 · was chunk 6 · replaced by edit · 1075 bytes
-- B chunk 6: next morning (the sky in the holes setting to tacky). One limb per hole, drawn once:
-- the stoutest limb that crosses each sky hole, a single round-brush stroke pressed to its width,
-- clipped to the hole. (Filling the grown wood mask there gave crossed planks at 3200.)
wait(1020)
print("holes:", drying(425,318), drying(760,445), drying(330,520))
local HG = HOLES:grow(3)
local best = {}
for li, l in ipairs(tree.limbs) do
  for k, p in ipairs(l.pts) do
    if HG:at(p[1], p[2]) > 0.5 then
      for hi, h in ipairs(HOLEPTS) do
        if math.abs(p[1] - h[1]) < h[3] + 6 and math.abs(p[2] - h[2]) < h[4] + 6 then
          local w = l.w[k] or l.w[1]
          if not best[hi] or w > best[hi].w then best[hi] = {w=w, limb=l} end
        end
      end
    end
  end
end
local b = brush("round", 3)
local n = 0
for hi, e in pairs(best) do
  if e.w >= 1.2 then
    b:reload("#2d2924", 0.8)
    b:stroke(e.limb.pts, {pressure={b:pressure_for(math.min(3, e.w + 0.6)), b:pressure_for(math.max(0.8, e.w * 0.6))}, clip=HG})
    n = n + 1
  end
end
print("limbs", n)

--@ undone 41 · was chunk 6 · replaced by edit · 1453 bytes
-- B chunk 6: next morning (the sky in the holes setting to tacky). One limb per hole, drawn once:
-- the stoutest limb that crosses each sky hole, a single round-brush stroke pressed to its width,
-- clipped to the hole. (Filling the grown wood mask there gave crossed planks at 3200.)
wait(1020)
print("holes:", drying(425,318), drying(760,445), drying(330,520))
local HG = HOLES:grow(3)
local best = {}
for li, l in ipairs(tree.limbs) do
  for k, p in ipairs(l.pts) do
    if HG:at(p[1], p[2]) > 0.5 then
      for hi, h in ipairs(HOLEPTS) do
        if math.abs(p[1] - h[1]) < h[3] + 6 and math.abs(p[2] - h[2]) < h[4] + 6 then
          local w = l.w[k] or l.w[1]
          if not best[hi] or w > best[hi].w then best[hi] = {w=w, limb=l, h=h} end
        end
      end
    end
  end
end
local b = brush("round", 3)
local n = 0
for hi, e in pairs(best) do
  if e.w >= 1.2 then
    -- only the stretch of the limb near its hole (the whole limb, clipped, ran the brush dry
    -- before the hole: a gray translucent streak)
    local seg, h = {}, e.h
    for _, p in ipairs(e.limb.pts) do
      if math.abs(p[1] - h[1]) < h[3] + 14 and math.abs(p[2] - h[2]) < h[4] + 14 then seg[#seg + 1] = p end
    end
    if #seg < 2 then goto continue end
    b:reload("#2d2924", 0.9)
    b:stroke(seg, {pressure={b:pressure_for(math.min(3, e.w + 0.6)), b:pressure_for(math.max(0.8, e.w * 0.6))}, clip=HG})
    n = n + 1
  end
  ::continue::
end
print("limbs", n)

