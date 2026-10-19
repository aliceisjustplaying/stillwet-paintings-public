print(drying(60, 600), drying(80, 680))
thStem = pile{{"green earth", 1.5}, {"raw umber", 1.6}, {"bone black", 0.5}, {"yellow ochre", 0.3}, medium=0.05}
thLeaf = pile{{"green earth", 2}, {"raw umber", 1.2}, {"bone black", 0.4}, {"Prussian blue", 0.1}, {"lead white", 0.2}, medium=0.05}
thHead = pile{{"lead white", 0.8}, {"red earth", 0.5}, {"smalt", 0.7}, {"raw umber", 0.3}, {"vermilion", 0.1}, medium=0.05}
thBract = pile{{"green earth", 1.5}, {"raw umber", 1}, {"lead white", 0.3}, medium=0.05}
local st = brush{kind="round", width=2.2, point=1}
local lf = brush{kind="round", width=2.5, point=1}
function thistle(x0, y0, H, lean, seed)
  math.randomseed(seed)
  local pts = {}
  for i = 0, 8 do
    local t = i / 8
    pts[#pts+1] = {x0 + lean*H*t*t + randn(0, 0.6), y0 - H*t}
  end
  st:load(thStem, 0.9)
  st:stroke(pts, {pressure={st:pressure_for(2.2), st:pressure_for(1.0)}})
  -- leaves: jagged, alternate, getting smaller upward
  for i = 1, 6 do
    local t = 0.08 + i * 0.1
    local px, py = x0 + lean*H*t*t, y0 - H*t
    local side = (i % 2 == 0) and 1 or -1
    local L = H * lerp(0.28, 0.1, t)
    local a = side > 0 and (-0.35 + randn(0,0.15)) or (math.pi + 0.35 + randn(0,0.15))
    local lp = {{px, py}}
    for k = 1, 5 do
      local f = k / 5
      local jag = (k % 2 == 0) and -1 or 1
      lp[#lp+1] = {px + L*f*math.cos(a) , py + L*f*math.sin(a) + L*0.18*f*f + jag*L*0.07}
    end
    lf:load(thLeaf, 0.8)
    lf:stroke(lp, {pressure={lf:pressure_for(L*0.22), lf:pressure_for(L*0.14), lf:pressure_for(L*0.16), lf:pressure_for(L*0.08), lf:pressure_for(0.3), 0}})
    -- spines
    local sp = brush{kind="round", width=0.6, point=1}; sp:load(thStem, 0.6)
    for k = 2, 5, 2 do local q = lp[k]; sp:stroke({{q[1], q[2]}, {q[1] + randn(0, 1.5), q[2] - rand(1, 3)}}, {pressure={sp:pressure_for(0.3), 0}}) end
  end
  -- heads: branch into 2-3
  local top = pts[#pts]
  local heads = {{top[1], top[2]}}
  for k = 1, 2 do
    local bx, by = x0 + lean*H*0.7*0.7, y0 - H*0.7
    local hx, hy = bx + (k == 1 and -1 or 1) * H * rand(0.08, 0.14), by - H * rand(0.12, 0.22)
    st:load(thStem, 0.7)
    st:stroke({{bx, by}, {(bx+hx)/2 + randn(0,1), (by+hy)/2}, {hx, hy}}, {pressure={st:pressure_for(1.1), st:pressure_for(0.8)}})
    heads[#heads+1] = {hx, hy}
  end
  for _, h in ipairs(heads) do
    local r = H * 0.035 + 1.5
    work(ellipse(h[1], h[2] + r*0.3, r, r*1.1), {hand="detail", pile=thBract, coverage=4, fill=true, clip=true, length={1,2}})
    local hb = brush{kind="round", width=0.8, point=1}
    for k = 1, 9 do
      hb:load(thHead, 0.8)
      local ang = -math.pi/2 + randn(0, 0.45)
      local L = r * rand(0.8, 1.4)
      hb:stroke({{h[1] + randn(0, r*0.3), h[2] - r*0.4}, {h[1] + L*math.cos(ang), h[2] - r*0.4 + L*math.sin(ang)}}, {pressure={hb:pressure_for(0.7), hb:pressure_for(0.4)}})
    end
  end
end
thistle(62, 706, 175, 0.12, 7001)
thistle(104, 704, 120, -0.1, 7002)
thistle(34, 704, 90, 0.05, 7003)
