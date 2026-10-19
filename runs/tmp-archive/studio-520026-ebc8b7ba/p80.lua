g_st = pile{{"raw umber", 2}, {"bone black", 1.1}, {"red earth", 1.2}}
sb = brush{kind="filbert", width=5, point=0.85}
for i, a in ipairs(AP) do
  local dx, dy = a.cx - a.r*0.04, a.cy - a.r*0.86
  work(ellipse(dx, dy, a.r*0.18, a.r*0.12):soften(2.5), {hand="body", tool="filbert 7", pile=g_st,
       length={14, 30}, coverage=3.2, pressure=0.9, fill=true, edge="soft"})
  sb:load(g_st, 0.9)
  sb:stroke({{dx, dy}, {dx + a.r*0.05, dy - a.r*0.15}, {dx + a.r*0.15, dy - a.r*0.30}},
    {pressure={0.85, 0.3}, ramps={0.08, 0.35}, orient="across", swell={1, 1, 0.55}})
end
-- the wall's light, laid with body paint and fused. Stippling a lighter pile over the
-- dark wall at high coverage tears it into orange stripes; never again.
groupm = BOWL:grow(10)
for _, a in ipairs(AP) do groupm = groupm + ashape(a):grow(10) end
wallfree = wall - groupm
work(wallfree * pool1, {hand="body", tool="filbert 17", pile=g_wm, length={45, 120},
     coverage=2.2, pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=0.35, edge="soft"})
work(wallfree * pool2, {hand="body", tool="filbert 15", pile=g_wt, length={40, 110},
     coverage=1.6, pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=0.45, edge="soft"})
blend((wallfree * pool1:grow(30)):soften(30), {angle=0.35})
work(wallfree * (ellipse(940, 400, 400, 280):blur(190)), {hand="glaze", pile=g_dk2, coverage=2.2})
