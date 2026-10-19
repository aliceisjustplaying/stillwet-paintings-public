local ok = fg_grass - fence:grow(2) - elder2:grow(3)
local n = 0
for i = 1, 200 do
  local x, y = rand(0, 1000), rand(655, 712)
  local d = crest_depth(x, y)
  local drift = 0.5 + 0.5 * math.sin(x / 47 + y / 23) * math.sin(x / 91 - y / 37)
  if ok:at(x, y) > 0.9 and rand(0,1) < 0.25 + 0.6 * drift and n < 38 then
    local near = clamp((y - 650) / 60, 0, 1)
    local s = lerp(4, 7.5, near) * rand(0.85, 1.15)
    local u = rand(0,1)
    local st = brush{kind="rigger", width=1.5, point=1}
    st:load(stemG, 0.55)
    local sx = x + rand(-3, 3)
    st:stroke({{sx, 716}, {lerp(sx, x, 0.6) + rand(-1.5,1.5), (y + 716)/2}, {x, y}}, {pressure={0.6, 0.25}})
    if u < 0.4 then
      -- ox-eye daisy: white rays, yellow disc, rays on the shaded side greyer
      local pb = brush{kind="round", width=s*0.33, point=0.6}
      for q = 0, 11 do
        local a = q/12*2*math.pi + rand(-0.1,0.1)
        pb:load((math.cos(a) > 0.3) and elderFs or daisy, 0.6)
        pb:stroke({{x + s*0.12*math.cos(a), y + s*0.07*math.sin(a)}, {x + s*0.5*math.cos(a), y + s*0.3*math.sin(a)}}, {pressure={0.6, 0.2}})
      end
      local c = brush{kind="round", width=s*0.3, point=0.2}
      c:load(butter, 0.6)
      c:touch(x, y, {pressure=0.7})
    elseif u < 0.75 then
      -- buttercups: two or three cups on branching stalks
      local c = brush{kind="round", width=s*0.4, point=0.2}
      for q = 1, 3 do
        local bx, by = x + rand(-s*0.8, s*0.8), y + rand(-s*0.6, s*0.2)
        st:load(stemG, 0.4)
        st:stroke({{x, y + s*0.8}, {bx, by}}, {pressure={0.4,0.2}})
        c:load(butter, 0.6)
        c:touch(bx, by, {pressure=0.7})
        c:load(hcL, 0.3)
        c:touch(bx - s*0.08, by - s*0.08, {pressure=0.3})
      end
    else
      -- red clover heads / a poppy
      local c = brush{kind="round", width=s*0.45, point=0.2}
      if u < 0.9 then
        c:load(clover, 0.6); c:touch(x, y, {pressure=0.7}); c:touch(x, y - s*0.15, {pressure=0.5})
      else
        c:load(poppy, 0.7); c:touch(x, y, {pressure=0.8}); c:touch(x + s*0.2, y - s*0.1, {pressure=0.7})
        local k = brush{kind="round", width=s*0.14, point=0.4}; k:load(blackp, 0.4); k:touch(x + s*0.1, y - s*0.05, {pressure=0.6})
      end
    end
    n = n + 1
  end
end
print(n, wait(0))
