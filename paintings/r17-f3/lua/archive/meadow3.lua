local cr = CROWN2[1]
for i=2,#CROWN2 do cr = cr + CROWN2[i] end
CROWNS_ALL = cr
KEEPM = HORSES:grow(1) + TRUNKS:grow(0.5) + CROWNS_ALL:grow(0.5) + PATH:shrink(2)
MEAD = LAND * mask(function(x,y) return y > 496 and 1 or 0 end) - KEEPM
gP = {
 lit = pile{{"lead white",1.5},{"yellow ochre",1.5},{"chrome yellow",0.5},{"green earth",0.8},{"Prussian blue",0.1}, medium=0.1},
 mid = pile{{"yellow ochre",1.5},{"green earth",1.4},{"Prussian blue",0.25},{"lead white",0.7},{"raw umber",0.2}, medium=0.1},
 sh  = pile{{"green earth",1.4},{"Prussian blue",0.3},{"raw umber",0.6},{"yellow ochre",0.8},{"lead white",0.6},{"pale smalt",0.3}, medium=0.1},
 dark= pile{{"raw umber",1.2},{"Prussian blue",0.45},{"green earth",1},{"yellow ochre",0.6},{"bone black",0.1}, medium=0.1},
}
local nz = noise{seed=5, period=160, octaves=3}
function zoneN(a, b, amp, soft)
  return mask(function(x,y) local yy = y + amp*nz(x, y*2); return smoothstep(a-soft, a+soft, yy)*(1 - smoothstep(b-soft, b+soft, yy)) end)
end
function mpass(m, p, y0, cov, seed)
  local d = y0 - 468
  local len = {d*0.05, d*0.12}
  local w = clamp(0.6 + d*0.008, 0.8, 2.4)
  work(m, {hand="hatch", pile=p, tool={kind="round", width=w, point=0.8}, angle=-math.pi/2, angle_jitter=0.3, length=len, coverage=cov, pressure={0.35,0.75}, ramps={0.1,0.6}, threshold=0.5, seed=seed})
end
-- cloud shadow band 532-578, cool
mpass(MEAD * zoneN(532, 560, 8, 5), gP.sh, 545, 1.4, 1)
mpass(MEAD * zoneN(555, 580, 8, 5), gP.sh, 568, 1.4, 2)
-- lit bands
mpass(MEAD * zoneN(496, 520, 4, 4), gP.lit, 510, 1.2, 3)
mpass(MEAD * zoneN(516, 536, 5, 4), gP.lit, 526, 1.2, 4)
mpass(MEAD * zoneN(578, 604, 8, 5), gP.lit, 590, 1.3, 5)
mpass(MEAD * zoneN(600, 628, 8, 5), gP.mid, 614, 1.3, 6)
print(wait(0))
