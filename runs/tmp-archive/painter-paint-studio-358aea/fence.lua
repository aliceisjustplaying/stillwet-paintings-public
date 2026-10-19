local f = 1000
local function proj(X, Y, Z) return 500 + f*X/Z, 468 + f*(1.75 - Y)/Z end
local wood = pile{{"raw umber",1},{"lead white",0.8},{"bone black",0.25},{"pale smalt",0.3},{"yellow ochre",0.2}, medium=0.08}
local woodL = pile{{"lead white",2.4},{"raw umber",0.5},{"yellow ochre",0.4},{"pale smalt",0.3}, medium=0.08}
local woodD = pile{{"bone black",0.8},{"raw umber",1},{"lead white",0.25}, medium=0.08}
FENCE = nil
local Zs = {}
local z = 13.2
while z < 75 do Zs[#Zs+1] = z; z = z * 1.0 + 2.9 + rand(-0.2,0.2) end
local posts = {}
for i,Z in ipairs(Zs) do
  local X = 7 + 0.02*i + rand(-0.06,0.06)
  local hgt = 1.15 + rand(-0.08, 0.08)
  local lean = rand(-0.04, 0.04)
  local w = 0.13
  local xb, yb = proj(X, 0, Z)
  local xt, yt = proj(X + lean, hgt, Z)
  local hw = f*w/Z/2
  local pts = {{xb-hw, yb+0.4}, {xt-hw*0.9, yt+hw*0.3}, {xt-hw*0.3, yt-hw*0.2}, {xt+hw*0.9, yt}, {xb+hw, yb+0.4}}
  local m = poly(pts)
  posts[i] = {xb=xb, yb=yb, xt=xt, yt=yt, hw=hw, Z=Z, X=X, lean=lean}
  FENCE = FENCE and (FENCE + m) or m
  local tw = math.max(0.7, hw*0.5)
  work(m, {hand="detail", pile=wood, tool={kind="round", width=tw, point=0.4}, angle=math.pi/2, length={2,10}, coverage=3, clip=true, fill=true, edge="found"})
  if hw > 1.2 then
    local lit = m * mask(function(x,y) return x < lerp(xb, xt, (yb-y)/(yb-yt)) - hw*0.2 and 1 or 0 end)
    work(lit, {hand="detail", pile=woodL, tool={kind="round", width=math.max(0.6,tw*0.7), point=0.4}, angle=math.pi/2, length={2,8}, coverage=1.5, clip=true})
  end
end
FPOSTS = posts
-- rails: two, from post to post, slight sag
local rails = nil
for i=1,#posts-1 do
  local a, b = posts[i], posts[i+1]
  for _,Y in ipairs({0.95, 0.5}) do
    local x1, y1 = proj(a.X + a.lean*Y/1.15, Y, a.Z)
    local x2, y2 = proj(b.X + b.lean*Y/1.15, Y, b.Z)
    local w1, w2 = f*0.09/a.Z, f*0.09/b.Z
    local mx, my = (x1+x2)/2, (y1+y2)/2 + f*0.03/((a.Z+b.Z)/2)
    local rm = ribbon({{x1,y1},{mx,my},{x2,y2}}, {math.max(0.8,w1), math.max(0.7,(w1+w2)/2), math.max(0.6,w2)})
    rails = rails and (rails + rm) or rm
  end
end
RAILS = rails - FENCE
work(RAILS, {hand="detail", pile=wood, tool={kind="round", width=1.0, point=0.4}, angle=-0.6, length={4,14}, coverage=3, clip=true, fill=true, edge="found"})
local rtop = RAILS * mask(function(x,y) return 1 end) - RAILS:offset(-1.0)
print(#posts, wait(0))
