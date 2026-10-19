local pts = {}
for _, p in ipairs(jugL) do pts[#pts+1] = {p[1]+95, p[2]+18} end
for i = #jugR, 1, -1 do pts[#pts+1] = {jugR[i][1]+95, jugR[i][2]+18} end
local wsh = (poly(pts, true):blur(18) * wall - jug:grow(1)) * rect(0,0,1000,521)
wallShadow = wsh
shG = pile{{"raw umber",1},{"bone black",0.5},{"green earth",0.4}, medium=0.55}
work(wsh, {hand="glaze", pile=shG, clip=wsh, angle=1.2, length={40,120}, coverage=2})
blend(wsh:grow(10) * wall - jug:grow(2), {angle=0.8, tool={kind="badger", width=24}})
