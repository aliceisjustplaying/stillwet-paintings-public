print(drying(100, 450), drying(60, 440))
local g = pile{{"green earth", 1.5}, {"yellow ochre", 0.3}, {"pale smalt", 0.3}, {"raw umber", 0.1}, medium=0.75}
for wi, w in ipairs(WILLOWS) do
  work(w.crown, {hand="detail", tool={kind="round", width=2.2, point=0.3}, pile=g, angle=-1.2, coverage=1, load=0.3, seed=9400+wi})
end
