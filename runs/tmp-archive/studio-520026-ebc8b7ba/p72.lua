-- soften the two hard contact bars under the front apples, then re-lay them wider
allap = BOWL:grow(2)
for _, a in ipairs(AP) do allap = allap + ashape(a):grow(2) end
free2 = CLOTH - allap
for _, a in ipairs{AP[4], AP[5]} do
  work(free2 * (ellipse(a.cx + a.r*0.45, a.cy + a.r*0.62, a.r*1.5, a.r*0.8):blur(a.r*0.5)),
       {hand="body", tool="filbert 14", pile=g_cm, length={35, 95}, coverage=3, pressure=1,
        fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  work(free2 * (ellipse(a.cx + a.r*0.34, a.cy + a.r*0.80, a.r*0.85, a.r*0.30):blur(a.r*0.28)),
       {hand="body", tool="filbert 12", pile=g_cd, length={30, 80}, coverage=3, pressure=1,
        fill=true, dips={1, 1.0, 0.0}, edge="soft"})
end
-- stems: a small dark dimple and a short brown stalk, the one thing that says "apple"
g_st = pile{{"raw umber", 2}, {"bone black", 1.1}, {"red earth", 1.2}}
sb = brush{kind="filbert", width=4.5, point=0.85}
for i, a in ipairs(AP) do
  local dx, dy = a.cx - a.r*0.04, a.cy - a.r*0.86
  work(ellipse(dx, dy, a.r*0.17, a.r*0.11):soften(2), {hand="body", tool="filbert 7", pile=g_st,
       length={14, 30}, coverage=3, pressure=0.9, fill=true, edge="soft"})
  sb:load(g_st, 0.9)
  sb:stroke({{dx, dy}, {dx + a.r*0.05, dy - a.r*0.14}, {dx + a.r*0.14, dy - a.r*0.26}},
    {pressure={0.85, 0.35}, ramps={0.08, 0.35}, orient="across", swell={1, 1, 0.6}})
end
