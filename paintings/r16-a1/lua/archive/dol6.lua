SLAB = outline{{736,492,"c"},{741,472},{749,459,"c"},{762,457,"c"},{774,468},{784,493,"c"}, closed=true, char="broken", seed=123}
work(SLAB:mask(), {hand="detail", pile=rkA, coverage=3, fill=true, angle=1.2, load=1, pressure={0.6,0.9}})
stipple(SLAB:mask(), {pile=rkB, width=3, coverage=0.5, pressure={0.4,0.7}})
local stones = {{519,489,8,5,1},{537,492,6,4,2},{801,495,9,5.5,3},{821,498,6,4,4},{612,501,10,4.5,5},{683,503,7,4,6},{760,500,6,3.5,7},{498,486,5,3,8}}
KERB = {}
local km
for i,s in ipairs(stones) do
  local x, y, rx, ry = s[1], s[2], s[3], s[4]
  local o = outline{{x-rx,y+ry*0.6,"c"},{x-rx*0.8,y-ry*0.4},{x-rx*0.2,y-ry},{x+rx*0.5,y-ry*0.8},{x+rx,y-ry*0.1},{x+rx*0.9,y+ry*0.6,"c"}, closed=true, char="broken", seed=300+i}
  KERB[i] = {x=x, y=y, rx=rx, ry=ry, m=o:mask()}
  km = km and (km + KERB[i].m) or KERB[i].m
end
KERBM = km
work(km, {hand="detail", pile=rkA, coverage=3, fill=true, angle=0, load=1, pressure={0.6,0.9}, tool={kind="round", width=1.8, point=0.6}})
