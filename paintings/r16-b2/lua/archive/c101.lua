local keep = TOWN2:grow(3) + TTREES:grow(2) + MILLB:grow(2)
local P = (rect(400,400,60,14) + rect(636,408,32,30) + rect(330,405,40,40))
local E = (P:grow(6) - P:shrink(4)) * above(function(x) return 443 end) - keep
for k=1,3 do blend(E, {angle=k*0.9, angle_jitter=0.8, length={4,12}, clip=true, tool={kind="badger", width=6}, seed=1010+k}) end
