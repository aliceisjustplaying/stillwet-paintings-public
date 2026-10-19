local FGM = below(function(x) return FGTOP(x) + 10 end) - FPATH:grow(2) - (MAN_COAT+WOM_DRESS+WOM_SHAWL):grow(4)
stemp = pile{{"green earth",1.5},{"raw umber",1.2},{"yellow ochre",0.3}, medium=0.2}
umbp = pile{{"lead white",2},{"yellow ochre",0.3},{"pale smalt",0.3},{"raw umber",0.3}, medium=0.2}
champ = pile{{"lead white",2.5},{"pale smalt",0.2},{"raw umber",0.15}, medium=0.2}
sorrp = pile{{"red earth",1.5},{"vermilion",0.3},{"raw umber",0.8}, medium=0.2}
yelp = pile{{"yellow ochre",1.5},{"lead white",0.8},{"raw umber",0.2}, medium=0.2}
local st = brush{kind="round", width=1, point=1}
local dt = brush{kind="round", width=1.2, point=0.5}
local function pick(y0,y1)
  for k=1,60 do local x,y = rand(5,995), rand(y0,y1); if FGM:at(x,y)>0.5 then return x,y end end
end
local function stem(x,y,L,a)
  local tx, ty = x + math.cos(a)*L, y + math.sin(a)*L
  st:stroke({{x,y},{(x+tx)/2 + randn(0,0.6),(y+ty)/2},{tx,ty}}, {pressure={st:pressure_for(math.max(0.5,L/25)), st:pressure_for(0.35)}})
  return tx, ty
end
-- cow parsley umbels, larger nearer
for i=1,26 do
  local x,y = pick(612,712)
  if x then
    local t = (y-600)/110
    local L = lerp(10,34,t)*rand(0.8,1.2)
    st:load(stemp,0.5)
    local tx,ty = stem(x,y,L,-math.pi/2+randn(0,0.12))
    local r = lerp(2,6,t)
    dt:load(umbp,0.6)
    for k=1,math.floor(lerp(5,12,t)) do
      local a = rand(math.pi, 2*math.pi)
      dt:touch(tx + math.cos(a)*r*rand(0.2,1), ty + math.sin(a)*r*0.45*rand(0.2,1) - r*0.1, {pressure=dt:pressure_for(lerp(0.7,1.5,t))})
    end
  end
end
-- chamomile / daisies: small white dots with a yellow eye
for i=1,70 do
  local x,y = pick(605,712)
  if x then
    local t = (y-600)/110
    st:load(stemp,0.4)
    local tx,ty = stem(x,y,lerp(4,14,t)*rand(0.7,1.3),-math.pi/2+randn(0,0.2))
    dt:load(champ,0.5)
    dt:touch(tx,ty,{pressure=dt:pressure_for(lerp(0.8,2.0,t))})
    if t > 0.4 then dt:load(yelp,0.4); dt:touch(tx,ty,{pressure=dt:pressure_for(lerp(0.3,0.8,t))}) end
  end
end
-- sorrel: rusty red spikes
for i=1,40 do
  local x,y = pick(600,712)
  if x then
    local t = (y-600)/110
    local L = lerp(8,26,t)*rand(0.8,1.2)
    st:load(stemp,0.4)
    local tx,ty = stem(x,y,L,-math.pi/2+randn(0,0.1))
    dt:load(sorrp,0.5)
    for k=0,math.floor(lerp(3,7,t)) do
      local f = k/7
      dt:touch(lerp(x,tx,0.45+f*0.55)+randn(0,0.5), lerp(y,ty,0.45+f*0.55), {pressure=dt:pressure_for(lerp(0.6,1.3,t))})
    end
  end
end
-- buttercups
for i=1,40 do
  local x,y = pick(605,712)
  if x then
    local t = (y-600)/110
    st:load(stemp,0.4)
    local tx,ty = stem(x,y,lerp(4,16,t)*rand(0.7,1.3),-math.pi/2+randn(0,0.2))
    dt:load(yelp,0.5); dt:touch(tx,ty,{pressure=dt:pressure_for(lerp(0.6,1.6,t))})
  end
end
