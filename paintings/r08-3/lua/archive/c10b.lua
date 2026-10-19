OAKC = {{52,236},{70,178},{112,140},{150,96},{196,84},{232,110},{262,104},{300,140},{322,190},{336,246,"c"},{318,292},
        {296,330},{250,352},{206,358},{160,362},{112,350},{76,326,"c"},{48,290}}
oak = tree_in{crown=outline{pts=OAKC, char="soft", seed=9}, trunk={{176,448},{174,410},{168,372},{170,340}},
  species="oak", season="winter", sun={0.55, -0.15, -0.6}, detail=0.3, seed=17}
barkpal = pal:only{"lead white", "smalt", "raw umber", "bone black", "red earth", "yellow ochre"}
local bark = "#37322e"
local thick = oak:wood(3.5)
local bn = noise{seed=71, period=6, octaves=3, stretch={1.57, 3}}
work(thick, {hand="body", tool="round 2", length={4, 12}, coverage=3.5, clip=thick, pal=barkpal,
  angle=function(x, y) return 1.5 + 0.3 * bn(x, y) end,
  color=function(x, y) return shift(bark, 0.03 * bn(x, y), 0.004, 0.006 * bn(y, x)) end})
-- the flank toward the dawn glow (right)
local stout = oak:wood(6)
work(stout * mask(function(x, y) return 1 - stout:at(x + 2.2, y + 0.5) end),
  {hand="body", tool="round 1.2", length={3, 9}, coverage=2.4, angle=1.5, clip=thick, pal=barkpal, color="#6f655d"})
-- the shaded left side darker, bark furrows
work(stout * mask(function(x, y) return 1 - stout:at(x - 4, y) end),
  {hand="hatch", tool="round 1", length={4, 10}, coverage=2, angle=1.55, clip=thick, pal=barkpal, color="#221f1e"})
oak:paint_wood(brush("round", 2.4), {color=bark, min=1.2, max=3.5, every=2, load=1})
-- the fine wood by hand: a pointed round, pressed to each run's width at its root and lifting to a point
local fb = brush{kind="round", width=1.3, point=1}
local ff = brush{kind="rigger", width=0.8, point=1}
local n = 0
for _, s in ipairs(oak:wood_strokes{max=1.2}) do
  local b = (s.w[1] > 0.6) and fb or ff
  n = n + 1
  if n % 7 == 1 or b:fullness() < 0.3 then b:reload(mix("#3a3431", "#57504d", rand()), 0.8) end
  local p0 = clamp(b:pressure_for(s.w[1]), 0.05, 1)
  local p1 = s.tip and 0 or clamp(b:pressure_for(s.w[#s.w]), 0.02, 1)
  b:stroke(s.pts, {pressure={p0, p1}, ramps={0.02, s.tip and 0.6 or 0.1}, shake=0.3})
end
print(n, "fine strokes")
