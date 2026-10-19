local riseC = pile{{"lead white",1.8},{"green earth",1.9},{"yellow ochre",0.7},{"pale smalt",0.75},{"raw umber",0.2}, medium=0.1}
local skyC  = pile{{"lead white",5},{"yellow ochre",0.22},{"pale smalt",0.15},{"raw umber",0.05}, medium=0.08}
local gaps = PWGAP[1]; for i=2,#PWGAP do gaps = gaps + PWGAP[i] end
CROWNNOW = PWCRALL - gaps
local cols = nil
for i,t in ipairs(PW) do
  local H = t.H; local hx, hy = t.x + t.lean*0.43*H, t.y - 0.43*H
  local c = poly{{hx-0.1*H, hy+0.03*H},{hx-0.2*H, hy-0.25*H},{hx+0.2*H, hy-0.25*H},{hx+0.1*H, hy+0.03*H}}
  cols = cols and (cols + c) or c
end
local band = mask(function(x,y) return (y > 430 and y < 505 and x < 445) and 1 or 0 end)
local zone = (PWCRALL:grow(12) - CROWNNOW:grow(0.5)) * band - cols - PWALL:grow(0.5) - MILL:grow(1.5) - FIGS:grow(1)
local zl = zone * LAND
local zs = zone - LAND
work(zl, {hand="detail", pile=riseC, tool={kind="round", width=1.3, point=0.3}, angle=0, length={3,10}, coverage=2.5, clip=true, fill=true, load=0.8})
work(zs, {hand="detail", pile=skyC, tool={kind="round", width=1.3, point=0.3}, angle=0, length={3,10}, coverage=2.5, clip=true, fill=true, load=0.8})
print(zl:area(), zs:area(), wait(0))
