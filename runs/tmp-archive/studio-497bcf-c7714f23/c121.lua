-- fence: lit left faces of the posts, lit top edges of the rails, grain, and grass growing up in front of the post feet
local r = brush{kind="round", width=1.2, point=0.8}
for i, p in ipairs(posts) do
  local w = p.w
  r = brush{kind="round", width=math.max(0.9, w*0.35), point=0.6}
  r:load(woodL, 0.5)
  r:stroke({{p.x - w*0.3, p.y - 1}, {p.x - w*0.3 + p.lean*p.h, p.y - p.h + 1}}, {pressure={0.5, 0.4}, shake=0.5})
  -- the cut top catching light
  r:touch(p.x + p.lean*p.h, p.y - p.h - w*0.1, {pressure=0.4})
  if w > 3.5 then
    local g = brush{kind="rigger", width=0.8, point=1}
    g:load(woodD, 0.4)
    for k = 1, 2 do
      local off = w*(0.05 + 0.15*k)
      g:stroke({{p.x + off, p.y - p.h*0.1}, {p.x + off + p.lean*p.h*0.8, p.y - p.h*0.85}}, {pressure={0.3, 0.1}, shake=0.8})
    end
  end
end
for i = 1, #posts - 1 do
  local a, b = posts[i], posts[i+1]
  for _, f in ipairs({0.42, 0.82}) do
    local p1 = {a.x + a.lean*a.h*f, a.y - a.h*f - a.w*0.2}
    local p2 = {b.x + b.lean*b.h*f, b.y - b.h*f - b.w*0.2}
    local sag = {(p1[1]+p2[1])/2, (p1[2]+p2[2])/2 + 1.2}
    local rb = brush{kind="round", width=math.max(0.8, a.w*0.22), point=0.5}
    rb:load(woodL, 0.45)
    rb:stroke({p1, sag, p2}, {pressure={0.45, 0.3}, shake=0.4})
  end
end
-- grass in front of fence feet
for i, p in ipairs(posts) do
  local g = brush{kind="rigger", width=1.2 + p.w*0.12, point=1}
  for k = 1, 9 do
    g:load((k % 3 == 0) and grL or grM, 0.5)
    local x = p.x + rand(-p.w*1.6, p.w*1.6)
    local L = p.h * rand(0.18, 0.4)
    g:stroke({{x, p.y + 2}, {x + rand(-2,2), p.y - L*0.5}, {x + rand(-3,3), p.y - L}}, {pressure={0.7, 0.05}, ramps={0.05, 0.7}})
  end
end
print(wait(0))
