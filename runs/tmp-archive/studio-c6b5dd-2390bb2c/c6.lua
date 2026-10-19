local c = {{520,212,270,20},{250,252,210,15},{770,182,220,24},{630,302,190,11},{140,172,150,13},{860,322,150,9},{420,150,160,10}}
clouds = nil
for i, e in ipairs(c) do
  local m = ellipse(e[1], e[2], e[3], e[4]):roughen(10, 60, i, 0)
  clouds = clouds and (clouds + m) or m
end
pCl = pile{{"lead white",3},{"smalt",1},{"red earth",0.35},{"raw umber",0.2},{"vermilion",0.1}}
work(clouds, {hand="body", tool="filbert 8", pile=pCl, angle=0.0, angle_jitter=0.06, coverage=2, length={40,120}, pressure={0.4,0.7}, edge="soft"})
