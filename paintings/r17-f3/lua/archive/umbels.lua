local stemP = pile{{"green earth",1.3},{"yellow ochre",0.8},{"raw umber",0.4},{"lead white",0.6},{"Prussian blue",0.1}, medium=0.08}
local flowerP = pile{{"lead white",6},{"yellow ochre",0.1},{"green earth",0.1}, medium=0.05}
local flowerS = pile{{"lead white",3},{"green earth",0.4},{"pale smalt",0.4},{"raw umber",0.1}, medium=0.05}
local litBlade = pile{{"yellow ochre",1.4},{"chrome yellow",0.3},{"green earth",0.9},{"lead white",1.2},{"Prussian blue",0.06}, medium=0.08}
local rs = brush{kind="rigger", width=1.3, point=1}
local ft = brush{kind="round", width=1.8, point=0.4}
local function umbel(x, y, h, lean)
  local tx, ty = x + lean*h, y - h
  rs:reload(stemP, 0.7)
  rs:stroke({{x, y}, {x + lean*h*0.4, y - h*0.5}, {tx, ty}}, {pressure={0.7,0.35}})
  -- rays and florets
  local R = h*0.14
  local rb = brush{kind="rigger", width=0.7, point=1}
  rb:load(stemP, 0.5)
  local n = math.random(7, 10)
  local heads = {}
  for k=1,n do
    local a = -math.pi/2 + (k - (n+1)/2) * (2.4/n) + rand(-0.08,0.08)
    local ex, ey = tx + math.cos(a)*R, ty + math.sin(a)*R*0.55 - R*0.15
    rb:stroke({{tx,ty},{ex,ey}}, {pressure={0.4,0.2}})
    heads[#heads+1] = {ex, ey}
  end
  for _,hd in ipairs(heads) do
    ft:reload(flowerS, 0.4)
    ft:touch(hd[1] + 0.5, hd[2] + 0.6, {pressure=0.35})
    ft:reload(flowerP, 0.5)
    for j=1,4 do ft:touch(hd[1] + rand(-1.6,1.6), hd[2] + rand(-1.2,0.4), {pressure=rand(0.2,0.35)}) end
  end
end
umbel(62, 704, 120, 0.06)
umbel(92, 706, 96, -0.05)
umbel(35, 708, 80, 0.12)
umbel(905, 706, 110, -0.07)
umbel(948, 708, 132, 0.03)
umbel(870, 710, 70, 0.1)
umbel(640, 706, 58, -0.04)
-- lit blades catching sun over the dark bottom
local lb = brush{kind="rigger", width=1.2, point=1}
lb:load(litBlade, 0.6)
for k=1,90 do
  local x, y = rand(0,1000), rand(660, 712)
  if PATH:at(x, math.min(y,703)) < 0.3 then
    local h = rand(14, 40)
    local b = rand(-0.35, 0.35)
    lb:stroke({{x, y}, {x + b*h*0.4, y - h*0.55}, {x + b*h, y - h}}, {pressure={0.55,0.0}})
    if lb:fullness() < 0.3 then lb:reload(litBlade, 0.6) end
  end
end
print(wait(0))
