-- sitting 4: the near shore. The bank as one dark mass in level strokes, its lip catching a little sky light;
-- two stones on the water's edge laid into it wet so they sit in the bank, dark against the pale water,
-- lit only on the faces turned up to the sky.
shoreCol = function(x, y)
  local top = SHORE(x)
  return mix(mix("#3a3831", "#27251f", smoothstep(top, top + 18, y)), "#1d1c19", smoothstep(top + 30, H, y))
end
work(shoreM, {hand="body", tool="filbert 6", color=shoreCol, angle=0.04, angle_jitter=0.25, length={14, 50}, coverage=3.0,
  medium=0.2, load=0.85, clip=shoreM:grow(1.2)})
SKYLIGHT = {from={0.35, -1}, front=-0.2, ambient=0.35, bounce=0.2, bounce_from={0, 1, 0.3}}
S1 = outline{pts={{356,653,"c"},{360,641},{371,631,"c"},{398,623},{426,612,"c"},{445,610},{457,617,"c"},{467,634},{474,654,"c"},{420,657}},
  char="broken", seed=71}
S2 = outline{pts={{494,649,"c"},{497,640},{506,633,"c"},{521,631},{530,637,"c"},{535,650},{512,652}}, char="broken", seed=72}
stones = {}
for i, o in ipairs({S1, S2}) do
  local r = rock{outline=o, kind="granite", sun=SKYLIGHT, seed=80 + i,
    cracks=(i == 1) and {{{428,613},{431,630},{426,648}}} or nil}
  stones[i] = r
  local m, v = r:mask(), r:value()
  local lo, hi = r:levels(0.03, 0.97)
  local col = function(x, y)
    return gradient({{0, "#1f1e1b"}, {0.5, "#2b2a26"}, {0.8, "#3a3a37"}, {1, "#56575a"}}, smoothstep(lo, hi, v:at(x, y)))
  end
  work(m, {hand="body", tool="filbert 4", color=col, angle=r:field("plane"), length={5, 14}, coverage=3.0, medium=0.2, load=0.9, clip=m})
  local rb = brush("round", 1.2)
  for j, s in ipairs(r.seams) do
    if j % 3 == 1 then rb:reload("#191816", 0.8) end
    rb:stroke(s.pts, {pressure={0.6, 0.15}, ramps={0.15, 0.45}, shake=0.5, clip=m})
  end
  blend(r:shadow(0.3), {angle=r:field("plane"), coverage=1.2, clip=m})
end
stoneM = stones[1]:mask() + stones[2]:mask()
print(shoreM:area(), stoneM:area(), stones[1])
