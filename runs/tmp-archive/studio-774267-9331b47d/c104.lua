print(drying(700, 495), drying(900, 505))
local wood = pile{{"raw umber", 1}, {"lead white", 0.35}, {"bone black", 0.12}, {"pale smalt", 0.2}, medium=0.08}
local lit = pile{{"lead white", 1.4}, {"yellow ochre", 0.35}, {"raw umber", 0.35}, medium=0.08}
local b = brush{kind="round", width=1.0, point=0.8, stiffness=0.5}
local rb = brush{kind="round", width=0.7, point=1, stiffness=0.5}
local x0, y0, x1, y1 = 1008, 511, 560, 484
local posts = {}
local t = 0
while t < 1 do
  local x, y = lerp(x0, x1, t), lerp(y0, y1, t)
  local sc = (y - 392)/(511 - 392)
  posts[#posts+1] = {x=x + rand(-0.4, 0.4), y=y, h=7.5*sc*rand(0.9, 1.1), w=1.1*sc + 0.35, lean=rand(-0.06, 0.06)}
  t = t + (15*sc)/(x0 - x1)
end
-- rails first (behind the posts' lit faces), two, sagging a little
for r=1,2 do
  local pts = {}
  for i,p in ipairs(posts) do
    local fr = (r == 1) and 0.85 or 0.45
    pts[#pts+1] = {p.x, p.y - p.h*fr + ((i % 2 == 0) and 0.3 or 0)}
  end
  rb:load(wood, 0.6)
  for i=1,#pts-1 do
    if i % 5 == 0 then rb:load(wood, 0.6) end
    local sc = (posts[i].y - 392)/(119)
    rb:stroke({pts[i], {(pts[i][1] + pts[i+1][1])/2, (pts[i][2] + pts[i+1][2])/2 + 0.3*sc}, pts[i+1]}, {pressure={rb:pressure_for(0.55*sc + 0.25), rb:pressure_for(0.55*sc + 0.25)}})
  end
end
for i,p in ipairs(posts) do
  b:load(wood, 0.5)
  b:stroke({{p.x, p.y + 0.3}, {p.x + p.lean*p.h, p.y - p.h}}, {pressure={b:pressure_for(p.w), b:pressure_for(p.w*0.9)}, ramps={0.02, 0.02}})
  rb:load(lit, 0.4)
  rb:stroke({{p.x - p.w*0.3 + p.lean*p.h, p.y - p.h + 0.2}, {p.x - p.w*0.3, p.y - p.h*0.35}}, {pressure={rb:pressure_for(p.w*0.35), 0.05}})
end
print(#posts)
