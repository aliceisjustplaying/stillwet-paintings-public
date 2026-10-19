local function snowOn(list, minw)
  local m = nil
  for _,s in ipairs(list) do
    local run, runw = {}, {}
    local function flush()
      if #run >= 2 then local r = ribbon(run, runw); m = m and (m + r) or r end
      run, runw = {}, {}
    end
    for i = 1, #s.pts - 1 do
      local a, b = s.pts[i], s.pts[i+1]
      local dx, dy = b[1]-a[1], b[2]-a[2]
      local L = math.sqrt(dx*dx + dy*dy)
      if L > 0 then
        local ang = math.atan(dy, dx)
        local h = math.abs(math.cos(ang))       -- 1 when level
        local w = (s.ws[i] + s.ws[i+1]) / 2
        if w >= minw and h > 0.55 and math.random() < 0.85 then
          local nx, ny = -dy/L, dx/L
          if ny > 0 then nx, ny = -nx, -ny end
          local t = clamp(w * 0.38, 0.9, 3.2) * (h - 0.4) / 0.6
          local off = w/2 - t*0.35
          if #run == 0 then run[1] = {a[1] + nx*off, a[2] + ny*off}; runw[1] = t*0.5 end
          run[#run+1] = {b[1] + nx*off, b[2] + ny*off}; runw[#runw+1] = t
        else flush() end
      end
    end
    flush()
  end
  return m
end
local m = snowOn(oak.thick, 2.2)
local m2 = snowOn(extra.thick, 2.2)
if m2 then m = m + m2 end
limbSnowM = m:roughen(0.4, 3, 121)
work(limbSnowM, {hand="detail", pile=snowTop, coverage=3.5, pressure={0.5,0.8}, load=0.9, fill=true, angle=0, tool={kind="round", width=1.4}})
