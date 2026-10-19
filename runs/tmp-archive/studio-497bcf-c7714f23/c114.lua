print(drying(100,650), drying(300,555))
woodL = pile{{"lead white", 2.5}, {"raw umber", 1}, {"pale smalt", 0.6}, {"yellow ochre", 0.3}, medium=0.08}
woodD = pile{{"raw umber", 1.6}, {"bone black", 0.35}, {"lead white", 0.5}, {"pale smalt", 0.3}, medium=0.08}
posts = {}
local base = {{28,708},{96,676},{156,652},{206,636},{247,624},{280,616},{306,610}}
for i, b in ipairs(base) do
  local t = (i - 1) / (#base - 1)
  local h = lerp(62, 17, t^0.8)
  local w = lerp(7, 2.2, t^0.8)
  posts[i] = {x=b[1], y=b[2], h=h, w=w}
end
local fm
for i, p in ipairs(posts) do
  local lean = (i % 2 == 0) and 0.06 or -0.04
  local m = poly({{p.x - p.w/2, p.y}, {p.x - p.w/2 + lean*p.h, p.y - p.h}, {p.x + p.w/2 + lean*p.h, p.y - p.h - p.w*0.25}, {p.x + p.w/2, p.y}})
  p.lean = lean
  fm = fm and (fm + m) or m
end
-- rails between successive posts at 0.45 and 0.85 of height
local rails
for i = 1, #posts - 1 do
  local a, b = posts[i], posts[i+1]
  for _, f in ipairs({0.42, 0.82}) do
    local p1 = {a.x + a.lean*a.h*f, a.y - a.h*f}
    local p2 = {b.x + b.lean*b.h*f, b.y - b.h*f}
    local sag = {(p1[1]+p2[1])/2, (p1[2]+p2[2])/2 + 1.2}
    local r = ribbon({p1, sag, p2}, {a.w*0.5, (a.w+b.w)*0.22, b.w*0.5})
    rails = rails and (rails + r) or r
  end
end
fence = fm + rails
work(fence, {hand="detail", pile=woodD, angle=0, coverage=3, length={2,6}, fill=true, clip=true, edge="found"})
-- light on the upper/left faces
local lit = fence * mask(function(x,y) return 1 end) - fence:offset(1.2)
local litL = fence - fence:shrink(1.2)
print(wait(0))
