local g = pile{{"green earth", 1.5}, {"raw umber", 0.4}, {"pale smalt", 0.3}, {"Prussian blue", 0.02}, medium=0.6}
for wi, w in ipairs(WILLOWS) do
  work(w.crown, {hand="detail", tool={kind="round", width=2.2, point=0.3}, pile=g, angle=-1.2, coverage=1.3, load_at=function(x, y) return clamp(0.3 + (x - w.hx)/(w.h*0.8) + (y - w.hy + w.h*0.5)/(w.h*1.2), 0.2, 0.75) end, seed=8300+wi})
end
