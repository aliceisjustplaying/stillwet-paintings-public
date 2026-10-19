local keep = TOWN2:grow(1.2) + TTREES:grow(1.5) + MILLB:grow(1.5)
local P = (rect(400,400,60,14) + rect(636,408,32,30) + rect(330,405,40,40)) * above(function(x) return 444 end) - keep
work(P, {hand="detail", pile=skyapr, tool={kind="round", width=1.0, point=0.6}, angle=0, coverage=4, fill=true, length={2,4}, seed=1001})
