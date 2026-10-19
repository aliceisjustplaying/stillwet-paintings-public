mist = pile{{"lead white",5},{"pale smalt",1},{"vermilion",0.06},{"yellow ochre",0.2}, medium=0.6}
local nz = noise{seed=321, period=180, octaves=3}
MISTB = rect(0,456,1000,56) - TOWN2 - DCL2
work(MISTB, {hand="glaze", pile=mist, angle=0, angle_jitter=0.02, clip=true, coverage=2, fill=true, length={120,300},
  load_at=function(x,y) return clamp(0.75*math.exp(-((y-478)/11)^2) * (0.75+0.35*nz(x,y)), 0.02, 0.9) end, seed=322})
for i=1,2 do blend(MISTB, {angle=0, ruler=true, length={100,300}, seed=323+i}) end
