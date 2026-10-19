-- the range's mirror was as dark and as tall as the range: restate it lighter, horizontal loaded strokes of its
-- color mixed toward the water's (more toward its far end), laid into the wet reflection
rrD = function(x) return math.max(1, 0.7*(HZ - crest(x))) end
work(rangeRefl, {hand="body", tool="filbert 6", color=function(x, y)
    local t = clamp((y - HZ) / rrD(x), 0, 1)
    return mix(rangereflcol(x, y), waterCol(x, y), 0.3 + 0.45*t) end,
  angle=0, angle_jitter=0.01, curve={0, 0}, length={30, 110}, coverage=2.6, medium=0.3, load=0.9, pressure={0.35, 0.5},
  pal=skypal, clip=rangeRefl:grow(2):blur(1)})
blend(rangeRefl:grow(3), {angle=0, angle_jitter=0.004, length={60, 200}, coverage=1.8, clip=waterM - reflM})
-- one calm band of mist on the far edge, straddling the seam between the range and its mirror
mn = noise{seed=77, octaves=4, period=150, stretch={0, 5}}
mistD = function(x, y)
  local c = HZ - 2 + 3*mn(x, 0)
  local up, dn = 9 + 5*mn(x, 30) + 8*G(x, 470, 90), 5 + 3*mn(x, 50)
  return clamp(smoothstep(c - up, c - up*0.3, y) * (1 - smoothstep(c + dn*0.4, c + dn, y)) * (0.7 + 0.3*mn:at01(x*1.2, 0)), 0, 1)
end
mistM = mask(mistD) - landM:grow(1)
mistcol = function(x, y) return mix("#aeaaab", "#cdbfa6", G(x, SUNX, 230)) end
work(mistM, {hand="broad", color=mistcol, angle=0, angle_jitter=0.004, curve={0, 0}, length={120, 300}, coverage=2.6,
  medium=0.35, load=0.9, load_at=function(x, y) return mistD(x, y) end, pressure={0.3, 0.4}, ramps={0.3, 0.3},
  hug=false, pal=skypal, clip=(-landM):blur(1)})
blend(mistM:blur(3), {angle=0, angle_jitter=0.003, coverage=2.0, length={100, 300}, hug=false, clip=(-landM):blur(1)})
local t = timesheet() print(string.format("%.0f min this sitting, mist %.0f", t.sitting, mistM:area()))
