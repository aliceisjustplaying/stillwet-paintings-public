print(drying(200,680), drying(700,680))
butter = pile{{"chrome yellow", 2}, {"lead white", 1}, {"yellow ochre", 0.5}, medium=0.08}
daisy = pile{{"lead white", 6}, {"yellow ochre", 0.15}, medium=0.08}
clover = pile{{"vermilion", 0.6}, {"red earth", 0.4}, {"lead white", 2}, {"smalt", 0.3}, medium=0.08}
poppy = pile{{"vermilion", 2}, {"red earth", 0.3}, medium=0.08}
stemG = pile{{"green earth", 2}, {"yellow ochre", 1}, {"raw umber", 0.5}, {"lead white", 0.4}, medium=0.08}
local fl = brush{kind="round", width=1.6, point=0.4}
local st = brush{kind="rigger", width=1.0, point=1}
local ok = fg_grass - fence:grow(1) - elder2:grow(2)
local kinds = {{butter, 0.45}, {daisy, 0.25}, {clover, 0.2}, {poppy, 0.1}}
local n = 0
for i = 1, 420 do
  local x, y = rand(0, 1000), rand(600, 714)
  local d = crest_depth(x, y)
  if d > 6 and ok:at(x, y) > 0.9 then
    local near = clamp(d / 110, 0, 1)
    if rand(0,1) < 0.35 + 0.65*near then
      local u = rand(0,1)
      local k = u < 0.45 and 1 or (u < 0.7 and 2 or (u < 0.9 and 3 or 4))
      local s = lerp(0.8, 3.4, near) * rand(0.8, 1.2)
      if near > 0.3 then
        st:load(stemG, 0.4)
        st:stroke({{x + rand(-1,1), y + s*3}, {x, y}}, {pressure={0.5, 0.15}})
      end
      fl:load(kinds[k][1], 0.5)
      if k == 2 and s > 2 then
        for p = 0, 7 do local a = p/8*2*math.pi fl:touch(x + s*0.55*math.cos(a), y + s*0.3*math.sin(a), {pressure=0.25}) end
        fl:load(butter, 0.4)
        fl:touch(x, y, {pressure=0.25})
      else
        fl:touch(x, y, {pressure=clamp(0.15 + s*0.12, 0.15, 0.6)})
        if s > 2.2 then fl:touch(x + s*0.3, y - s*0.15, {pressure=0.3}) end
      end
      n = n + 1
    end
  end
end
print(n, wait(0))
