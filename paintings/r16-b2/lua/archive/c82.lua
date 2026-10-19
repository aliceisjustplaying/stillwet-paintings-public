leafp = pile{{"green earth",1.5},{"raw umber",1.6},{"Prussian blue",0.2},{"bone black",0.15}, medium=0.2}
leaflt = pile{{"green earth",1.5},{"yellow ochre",0.6},{"lead white",0.6},{"raw umber",0.6}, medium=0.2}
thisp = pile{{"red earth",0.7},{"smalt",0.7},{"lead white",0.8},{"raw umber",0.4},{"vermilion",0.1}, medium=0.2}
local function leaf(x,y,L,a,w)
  local tx,ty = x+math.cos(a)*L, y+math.sin(a)*L
  local nx,ny = -math.sin(a), math.cos(a)
  local mx,my = x+math.cos(a)*L*0.45, y+math.sin(a)*L*0.45
  return poly({{x,y},{mx+nx*w,my+ny*w},{tx,ty},{mx-nx*w,my-ny*w}}, true)
end
-- dock clump bottom right
local D = nil
local base = {{930,716},{955,716},{905,716}}
local specs = {{930,716,46,-1.9,9},{934,716,40,-1.2,8},{926,716,34,-2.5,7},{955,716,30,-1.5,6},{905,716,28,-2.2,6},{945,716,24,-0.8,5}}
for _,s in ipairs(specs) do local l = leaf(s[1],s[2],s[3],s[4],s[5]); D = D and D + l or l end
work(D, {hand="detail", pile=leafp, tool={kind="round", width=1.4, point=0.6}, angle=-1.5, angle_jitter=0.3, coverage=4, fill=true, length={3,8}, seed=821})
local st = brush{kind="round", width=1, point=1}
st:load(leaflt, 0.4)
for _,s in ipairs(specs) do
  local tx,ty = s[1]+math.cos(s[4])*s[3]*0.9, s[2]+math.sin(s[4])*s[3]*0.9
  st:stroke({{s[1],s[2]},{tx,ty}}, {pressure={st:pressure_for(1.1), st:pressure_for(0.2)}})
end
-- a tall dock seed spike, rusty
local dk = brush{kind="round", width=1.2, point=0.6}
st:load(leafp,0.5); st:stroke({{940,700},{942,660},{946,628}}, {pressure={st:pressure_for(1.6), st:pressure_for(0.5)}})
dk:load(sorrp,0.6)
for k=0,14 do local f=k/14; dk:touch(lerp(942,946,f)+randn(0,1.2), lerp(662,628,f), {pressure=dk:pressure_for(lerp(2.2,1.0,f))}) end
-- thistle bottom left
local tx0, ty0 = 70, 716
st:load(leafp,0.6); st:stroke({{tx0,ty0},{72,680},{76,646}}, {pressure={st:pressure_for(2.2), st:pressure_for(1.2)}})
st:load(leafp,0.5); st:stroke({{72,690},{64,676},{56,668}}, {pressure={st:pressure_for(1.5), st:pressure_for(0.3)}})
st:stroke({{73,672},{80,662},{89,656}}, {pressure={st:pressure_for(1.5), st:pressure_for(0.3)}})
st:stroke({{74,660},{70,652},{64,646}}, {pressure={st:pressure_for(1.2), st:pressure_for(0.3)}})
-- spiny leaf blades
local TL = leaf(71,700,34,-2.7,5) + leaf(73,700,32,-0.45,5) + leaf(72,682,22,-2.4,4) + leaf(74,680,22,-0.6,4)
work(TL, {hand="detail", pile=leafp, tool={kind="round", width=1.2, point=0.6}, angle=0, angle_jitter=0.5, coverage=4, fill=true, length={2,6}, seed=822})
-- heads: dark bulb + mauve tuft
for _,h in ipairs({{76,644,4},{56,666,3},{89,654,3.2},{64,644,2.6}}) do
  work(ellipse(h[1],h[2]+h[3]*0.3,h[3]*0.8,h[3]*0.8), {hand="detail", pile=leafp, tool={kind="round", width=0.9, point=0.6}, coverage=4, fill=true, length={1,3}, seed=823})
  dk:load(thisp,0.6)
  for k=1,9 do local a = rand(-math.pi*0.9,-math.pi*0.1); dk:stroke({{h[1],h[2]-h[3]*0.2},{h[1]+math.cos(a)*h[3]*1.1, h[2]-h[3]*0.2+math.sin(a)*h[3]*1.2}}, {pressure={dk:pressure_for(0.9), dk:pressure_for(0.3)}}) end
end
