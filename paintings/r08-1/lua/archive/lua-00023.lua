dry()
-- the woman, modeled over the dry silhouette: long folds of the cloak, the hood, a thin rim of the glow
local fx, fy = FIG.x, FIG.foot
local pb = brush{kind="round", width=1.1, point=1}
-- folds: lighter where the cloth turns to the sky, darker in the hollows between
local folds = {{-5.5, -46, -8.5, -1, "#3f3938"}, {-1, -49, -2, 0, "#3a3434"}, {4.5, -47, 8, -1, "#3f3938"}, {8, -40, 11.2, -2, "#453e3c"},
               {-3.2, -45, -5.4, 0, "#1d1a1c"}, {2, -48, 3.2, 0, "#1d1a1c"}, {6.2, -44, 9.8, 0, "#201c1e"}}
for _, f in ipairs(folds) do
  pb:reload(f[5], 0.8)
  local mx = (f[1] + f[3])/2 + randn(0, 0.25)
  pb:stroke({{fx + f[1], fy + f[2]}, {fx + mx, fy + (f[2] + f[4])/2}, {fx + f[3], fy + f[4]}}, {pressure={0.05, 0.45, 0.6}, ramps={0.35, 0.1}, clip=FIGM})
end
-- the hood's top and its fall onto the shoulders, a shade lighter
pb:reload("#433c3a", 0.7)
pb:stroke({{fx - 3, fy - 60}, {fx + 0.5, fy - 61.8}, {fx + 3.6, fy - 59.6}}, {pressure={0.2, 0.5, 0.2}, ramps={0.3, 0.3}, clip=FIGM})
pb:stroke({{fx - 6.5, fy - 49.8}, {fx - 3.5, fy - 51.4}, {fx + 0.5, fy - 51.6}}, {pressure={0.15, 0.4, 0.1}, ramps={0.3, 0.3}, clip=FIGM})
-- the rim of the glow: a hair of warm light on the right side of hood and shoulder, and on the left sleeve
local rb = brush{kind="round", width=0.6, point=1}
rb:load("#9a8474", 0.6)
rb:stroke({{fx + 3.9, fy - 60.5}, {fx + 4.4, fy - 57}, {fx + 5, fy - 53}, {fx + 8.2, fy - 49.4}, {fx + 9.1, fy - 44}}, {pressure={0.05, 0.3, 0.25, 0.05}, ramps={0.3, 0.4}})
rb:reload("#857368", 0.5)
rb:stroke({{fx - 7.8, fy - 48}, {fx - 8.6, fy - 42}, {fx - 9.2, fy - 34}}, {pressure={0.05, 0.25, 0.05}, ramps={0.3, 0.5}})
-- the hem sunk in the snow: short strokes of the snow over the bottom edge, uneven
local sn = brush{kind="round", width=1.6, point=0.4}
for i = 1, 9 do
  local x = fx - 13 + i*2.9 + randn(0, 0.5)
  sn:reload(snowcol(x, fy + 3):hex(), 0.7)
  sn:stroke({{x - 2.2, fy + 0.4 + randn(0, 0.5)}, {x + 2.2, fy - rand(0, 1.4)}}, {pressure={0.4, 0.6}, ramps={0.2, 0.3}})
end
