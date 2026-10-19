print(wait(60*4))
local wd = pile{{"raw umber",1},{"bone black",0.5},{"red earth",0.15},{"lead white",0.2}, medium=0.05}
-- wheels
local w1 = ellipse(795.2,539.6,2.1,2.3) - ellipse(795.2,539.6,1.2,1.35)
local w2 = ellipse(808.6,540.3,2.1,2.3) - ellipse(808.6,540.3,1.2,1.35)
work(w1 + w2, {hand="detail", pile=wd, tool={kind="round", width=0.6, point=0.5}, angle=0, coverage=3.5, fill=true, clip=true, pressure={0.4,0.6}, seed=3831})
-- deeper shade on the load's right and underside
local hayD = pile{{"yellow ochre",1},{"raw umber",0.8},{"lead white",0.5},{"pale smalt",0.25}, medium=0.05}
local sh = wagonLoad * mask(function(x,y) return smoothstep(0.2, 1.2, (x - 806)/5 + (y - 531)/3) end)
work(sh, {hand="detail", pile=hayD, tool={kind="round", width=0.9, point=0.4}, angle=0.4, coverage=3, fill=true, clip=true, pressure={0.4,0.6}, seed=3832})
-- lit top wisps
local hayT = pile{{"lead white",2},{"yellow ochre",1},{"chrome yellow",0.1}, medium=0.05}
local r = brush{kind="rigger", width=0.5, point=1}
r:reload(hayT, 0.5)
for i = 1, 9 do
  local x = 792.5 + i * 1.5 + rand(-0.4, 0.4)
  local y = 530.5 - math.sin((i/10) * math.pi) * 2.6 + rand(-0.3, 0.3)
  r:stroke({{x,y},{x+1.4,y-0.5+rand(-0.2,0.2)},{x+2.8,y-0.2}}, {pressure={0.35,0.05}})
end
-- the horse in the shafts, facing left
local hb = poly({{781,533.4},{788.6,533.2},{789.4,534.4},{789,536.4},{781.4,536.6},{780.6,535}}, true)
local hn = poly({{781.4,534.4},{779.6,531.4},{778.4,530.8},{777.0,532.4},{777.5,533.0},{778.8,532.6},{780.4,535.4}})
local horse = hb + hn
horseW = horse
local bay = pile{{"red earth",1},{"raw umber",0.9},{"lead white",0.35}, medium=0.05}
work(horse, {hand="detail", pile=bay, tool={kind="round", width=0.7, point=0.5}, angle=0, coverage=3.5, fill=true, clip=true, pressure={0.4,0.6}, seed=3833})
r:reload(bay, 0.6)
for _, lx in ipairs({{781.6,-0.3},{783,0.4},{787.4,-0.2},{788.6,0.5}}) do
  r:stroke({{lx[1],536},{lx[1]+lx[2]*0.5,538},{lx[1]+lx[2],540.3}}, {pressure={0.55,0.45}})
end
r:reload(wd, 0.6)
r:stroke({{789.2,535.2},{792,536.4}}, {pressure={0.3,0.3}})             -- shaft
r:stroke({{789.6,534.0},{789.8,536.8}}, {pressure={0.25,0.2}})           -- tail
r:stroke({{779.6,531.2},{781.4,532.6},{783.6,533.4}}, {pressure={0.3,0.2}}) -- mane
