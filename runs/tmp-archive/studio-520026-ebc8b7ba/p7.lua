hp = pencil("HB")
hp:line(tlinep, {pressure=0.55, smooth=false})
hp:line(clothpts, {pressure=0.6})
hp:line(arc(BOWLX, BOWLY, BOWLRX, BOWLRY, math.pi, 2*math.pi, 24), {pressure=0.55})
hp:line(arc(BOWLX, BOWLY, BOWLRX, BOWLRY, 0, math.pi, 24), {pressure=0.3})
hp:line({{758, 498}, {742, 540}, {700, 578}, {620, 596}, {520, 594}, {452, 574}, {412, 534}, {392, 498}}, {pressure=0.55})
for i, a in ipairs(AP) do
  hp:line(circ(a.cx, a.cy, a.r, a.r*0.97), {pressure=0.6})
  hp:line({{a.cx - 0.42*a.r, a.cy - 0.42*a.r}, {a.cx + 0.5*a.r, a.cy + 0.5*a.r}}, {pressure=0.28, smooth=false})
end
for _, f in ipairs(FOLDS) do hp:line(f, {pressure=0.3}) end
print("drawn")
