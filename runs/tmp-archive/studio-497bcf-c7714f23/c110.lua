wood = pile{{"raw umber", 2}, {"red earth", 0.4}, {"lead white", 0.6}, {"bone black", 0.2}, medium=0.08}
horseB = pile{{"red earth", 1.2}, {"raw umber", 1.5}, {"bone black", 0.25}, {"lead white", 0.2}, medium=0.08}
horseD = pile{{"raw umber", 1.5}, {"bone black", 0.8}, {"lead white", 0.2}, medium=0.08}
shirt = pile{{"lead white", 5}, {"yellow ochre", 0.3}, {"pale smalt", 0.4}, medium=0.08}
-- cast shadow of the whole group on the stubble
local cs = poly({{508,531},{600,530},{606,534},{512,535}}, true)
work(cs, {hand="detail", pile=hcC, angle=0, coverage=2, length={3,8}, fill=true, clip=true, edge="soft", load=0.5})
-- the load of hay
load_m = poly({{513,521},{511,512},{512,503},{516,497},{524,494},{536,493},{548,494},{556,497},{560,503},{561,512},{559,521}}, true):roughen(0.8, 3, 161)
work(load_m, {hand="detail", pile=hcS, angle=math.pi/2, coverage=2.5, length={2,6}, fill=true, clip=true, edge="firm"})
local lit = load_m * mask(function(x,y) return ((x - 536)/24 + (y - 507)/14*0.5) < -0.05 and 1 or 0 end)
work(lit, {hand="detail", pile=hcL, angle=-1.2, coverage=2.2, length={2,5}, fill=true, clip=load_m, edge="soft"})
-- wagon bed, ladder rail
bed = rect(514, 520.5, 45, 3.2)
work(bed, {hand="detail", pile=wood, angle=0, coverage=3, length={3,8}, fill=true, clip=true, edge="found"})
-- wheels
local wb = brush{kind="round", width=1.1, point=0.7}
local function wheel(cx, cy, r)
  wb:load(wood, 0.6)
  local pts = {}
  for k = 0, 24 do local a = k / 24 * 2 * math.pi pts[#pts+1] = {cx + r*math.cos(a), cy + r*math.sin(a)} end
  wb:stroke(pts, {pressure={0.6,0.6}, ramps={0.0,0.0}})
  wb:load(wood, 0.4)
  for k = 0, 5 do local a = k / 6 * math.pi + 0.2 wb:stroke({{cx - r*math.cos(a), cy - r*math.sin(a)}, {cx + r*math.cos(a), cy + r*math.sin(a)}}, {pressure={0.3,0.3}}) end
  wb:touch(cx, cy, {pressure=0.8})
end
wheel(523, 525.5, 6.2)
wheel(551, 527, 4.8)
print(wait(0))
