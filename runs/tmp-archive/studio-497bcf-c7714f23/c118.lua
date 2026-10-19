local ok = fg_grass - fence:grow(1.5) - elder2:grow(2)
local n = 0
local tipsL = {}
for i = 1, 520 do
  local x, y = rand(0, 1000), rand(600, 714)
  local d = crest_depth(x, y)
  if d > 5 and ok:at(x, y) > 0.9 then
    local near = clamp(d / 110, 0, 1)
    -- clustered: denser in drifts
    local drift = 0.5 + 0.5 * math.sin(x / 47 + y / 23) * math.sin(x / 91 - y / 37)
    if rand(0,1) < (0.25 + 0.75*near) * (0.3 + 0.7*drift) then
      local u = rand(0,1)
      local k = u < 0.5 and 1 or (u < 0.72 and 2 or (u < 0.9 and 3 or 4))
      local s = lerp(1.0, 4.2, near^1.2) * rand(0.8, 1.2)
      local p = ({butter, daisy, clover, poppy})[k]
      if near > 0.35 then
        local st = brush{kind="rigger", width=1.0 + near*0.6, point=1}
        st:load(stemG, 0.45)
        st:stroke({{x + rand(-2,2), y + s*4}, {x + rand(-0.6,0.6), y + s*1.5}, {x, y}}, {pressure={0.55, 0.2}})
      end
      local fl = brush{kind="round", width=math.max(1.2, s), point=0.2}
      fl:load(p, 0.6)
      if k == 2 and s > 2.2 then
        local pb = brush{kind="round", width=math.max(1.0, s*0.4), point=0.3}
        pb:load(daisy, 0.6)
        for q = 0, 9 do local a = q/10*2*math.pi pb:touch(x + s*0.45*math.cos(a), y + s*0.25*math.sin(a), {pressure=0.5, drag={s*0.25, a}}) end
        pb:load(butter, 0.5)
        pb:touch(x, y, {pressure=0.6})
      elseif k == 4 and s > 2 then
        fl:touch(x, y, {pressure=0.6})
        fl:touch(x + s*0.25, y - s*0.1, {pressure=0.5})
        local c = brush{kind="round", width=math.max(0.9, s*0.3), point=0.5}
        c:load(blackp, 0.4)
        c:touch(x + s*0.1, y - s*0.05, {pressure=0.4})
      else
        fl:touch(x, y, {pressure=0.5})
        if k == 3 then fl:touch(x, y - s*0.25, {pressure=0.35}) end
      end
      n = n + 1
    end
  end
end
print(n, wait(0))
