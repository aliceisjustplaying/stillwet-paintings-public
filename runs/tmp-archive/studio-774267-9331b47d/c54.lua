local function streamy(x)
  for i=1,#STREAMPTS-1 do
    local a, b = STREAMPTS[i], STREAMPTS[i+1]
    if (x <= a[1] and x >= b[1]) then
      local t = (a[1] - x)/(a[1] - b[1]); return lerp(a[2], b[2], t), lerp(STREAMW[i], STREAMW[i+1], t)
    end
  end
  return 510, 8
end
STREAMY = streamy
WILLOWS = {{x=58, h=60}, {x=112, h=52}, {x=168, h=46}, {x=226, h=40}, {x=281, h=34}}
local trunkp = pile{{"raw umber", 1}, {"bone black", 0.2}, {"lead white", 0.3}, {"yellow ochre", 0.2}, medium=0.1}
local trunkl = pile{{"lead white", 1}, {"raw umber", 0.6}, {"yellow ochre", 0.5}, {"pale smalt", 0.2}, medium=0.1}
local darkf = pile{{"green earth", 1.5}, {"raw umber", 0.55}, {"Prussian blue", 0.05}, {"bone black", 0.04}, {"lead white", 0.25}, medium=0.1}
local midf = pile{{"lead white", 1.1}, {"green earth", 1.5}, {"pale smalt", 0.5}, {"yellow ochre", 0.35}, {"raw umber", 0.2}, medium=0.1}
local litf = pile{{"lead white", 2}, {"green earth", 0.7}, {"yellow ochre", 0.5}, {"pale smalt", 0.2}, medium=0.1}
WILLOWM = nil
for wi, w in ipairs(WILLOWS) do
  local sy, sw = streamy(w.x)
  w.y = sy - sw/2 - 0.3
  local s = w.h/60
  local th = w.h*0.36
  local tw = 7*s
  local hx, hy = w.x + rand(-1.5, 1.5), w.y - th
  w.hx, w.hy = hx, hy
  -- trunk: stout, slightly leaning, with a swollen head
  local trunk = poly({{w.x - tw/2 - 1*s, w.y + 0.5}, {w.x - tw/2 + 0.6*s, w.y - th*0.5}, {hx - tw/2 - 0.5*s, hy + 1}, {hx - tw*0.8, hy - 1.5*s}, {hx, hy - 3*s}, {hx + tw*0.8, hy - 1.5*s}, {hx + tw/2 + 0.5*s, hy + 1}, {w.x + tw/2 - 0.3*s, w.y - th*0.5}, {w.x + tw/2 + 1.2*s, w.y + 0.5}}, true)
  -- the crown: a fan of shoots, clumped foliage around them
  local shoots = {}
  local crown = nil
  local ns = 16
  for k=1,ns do
    local a = -math.pi/2 + lerp(-1.05, 1.05, (k-0.5)/ns) + rand(-0.08, 0.08)
    local L = w.h*0.66 * (0.75 + 0.3*math.cos(a + math.pi/2)) * rand(0.85, 1.1)
    local bend = rand(-0.15, 0.15)
    local pts = {}
    for j=0,6 do
      local t = j/6
      local aa = a + bend*t + 0.25*t*(math.cos(a) > 0 and 1 or -1)*math.abs(math.cos(a))
      pts[#pts+1] = {hx + L*t*math.cos(aa), hy - 2*s + L*t*math.sin(aa)}
    end
    shoots[#shoots+1] = pts
    local fol = nil
    for j=2,7 do
      local p = pts[j]
      local r = (1.2 + 3.2*s) * rand(0.7, 1.3) * (0.6 + 0.4*math.sin(math.pi*(j-1)/6))
      local e = ellipse(p[1] + rand(-1,1), p[2] + rand(-1,1), r*1.1, r)
      fol = fol and (fol + e) or e
    end
    crown = crown and (crown + fol) or fol
  end
  crown = crown:roughen(1.2*s + 0.5, 4, 700 + wi)
  w.crown, w.trunk, w.shoots = crown, trunk, shoots
  local wm = crown + trunk
  WILLOWM = WILLOWM and (WILLOWM + wm) or wm
  work(crown, {hand="detail", tool={kind="round", width=1.6, point=0.5}, pile=midf, coverage=2.4, fill=true, seed=5400+wi})
  -- shadowed right and lower parts of the crown
  local shade = crown * mask(function(x, y) return ((x - hx)*0.8 + (y - (hy - w.h*0.3))*0.6 > rand(-2, 2)*0 + 2*s) and 1 or 0 end)
  stipple(shade, {pile=darkf, width=1.6*s + 0.6, coverage=1.6, cluster=0.6, clip=true, seed=5410+wi})
  stipple(crown, {pile=darkf, width=1.2, coverage=0.3, cluster=0.8, clip=true, seed=5420+wi})
  work(trunk, {hand="detail", tool={kind="round", width=1.4, point=0.5}, pile=trunkp, angle=math.pi/2, coverage=3, fill=true, seed=5430+wi})
  work(trunk * rect(w.x - 10, 0, 10 - tw*0.1, 700), {hand="detail", tool={kind="round", width=1, point=0.5}, pile=trunkl, angle=math.pi/2, coverage=1.3, seed=5440+wi})
end
