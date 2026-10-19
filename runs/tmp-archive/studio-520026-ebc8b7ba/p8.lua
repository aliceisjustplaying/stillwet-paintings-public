cc = chalk()
cc:line(tlinep, {pressure=0.5, smooth=false})
cc:line(clothpts, {pressure=0.55})
cc:line(arc(BOWLX, BOWLY, BOWLRX, BOWLRY, math.pi, 2*math.pi, 24), {pressure=0.5})
cc:line(arc(BOWLX, BOWLY, BOWLRX, BOWLRY, 0, math.pi, 24), {pressure=0.22})
cc:line({{758, 498}, {742, 540}, {700, 578}, {620, 596}, {520, 594}, {452, 574}, {412, 534}, {392, 498}}, {pressure=0.5})
for i, a in ipairs(AP) do
  cc:line(circ(a.cx, a.cy, a.r, a.r*0.97), {pressure=0.55})
  cc:line({{a.cx - 0.5*a.r, a.cy - 0.5*a.r}, {a.cx + 0.58*a.r, a.cy + 0.58*a.r}}, {pressure=0.25, smooth=false})
end
for _, f in ipairs(FOLDS) do cc:line(f, {pressure=0.3}) end
print("drawn")
