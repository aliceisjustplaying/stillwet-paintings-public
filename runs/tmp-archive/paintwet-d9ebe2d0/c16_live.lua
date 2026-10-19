-- a man from behind on the rise, looking out over the lake toward the afterglow: a dark coat in short strokes,
-- (no rim light: the glow is too far off and low to catch him)
local fx, fy = 802, SHORE(802) + 1
FIG = body_of{spine={{fx - 0.3, fy - 55.4}, {fx, fy - 52.8}, {fx + 0.2, fy - 49.6}, {fx + 0.6, fy - 46.2}, {fx + 1.7, fy - 30}, {fx + 2.2, fy - 13}},
  widths={6.8, 5.0, 3.9, 10.8, 9.0, 13.2},
  limbs={{{fx - 1.6, fy - 14}, {fx - 2.6, fy}, widths={2.8, 2.0}}, {{fx + 4.6, fy - 14}, {fx + 5.4, fy + 0.5}, widths={2.8, 2.0}},
         {{fx - 4.2, fy - 45.2}, {fx - 5.8, fy - 37}, {fx - 5.0, fy - 28.5}, widths={3.0, 2.7, 2.2}},
         {{fx + 6.2, fy - 44.8}, {fx + 8.2, fy - 35}, {fx + 8.8, fy - 27.5}, widths={3.0, 2.7, 2.2}}},
  blend=0.4, char="firm", amount=1.1, seed=91}
figM = FIG:mask()
print(fx, fy, figM:area())
work(figM, {hand="detail", tool="round 1.6", color=function(x, y) return mix("#252321", "#1b1a19", smoothstep(560, 600, y)) end,
  angle=1.57, angle_jitter=0.3, length={2, 6}, coverage=5, medium=0.2, load=0.95, clip=figM:grow(0.3)})
-- his stick, from the right hand down to the ground beside him
local sb = brush("rigger", 0.9); sb:load("#1e1c1a", 0.9)
sb:stroke({{fx + 8.9, fy - 28}, {fx + 10.2, fy - 14}, {fx + 11.2, fy + 0.5}}, {pressure={0.8, 0.6}, ramps={0.05, 0.1}})
