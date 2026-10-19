dry()
-- a second coat on the trunks: the first dried thin on the weave's crests
for i, f in ipairs(FEET) do
  local m, fw, th = f[5][1], f[5][5], f[5][4]
  work(m, {hand="body", tool=string.format("filbert %.1f", math.max(1, fw * 0.3)), length={0.1 * th, 0.3 * th}, coverage=3.5, medium=0.1, aim="masstone", load=1,
    angle=1.57 + f[3], angle_jitter=0.15, edge={found=0.8, soft=0.2, period=12, seed=i}, color=mix(i % 2 == 0 and "#2b2623" or "#302925", AIR, f[4])})
end
dry()
local capn = noise{seed=61, octaves=3, period=5}
function ridges(Wt, haze, lean)
  local m, hx, hy, th, fw = Wt[1], Wt[2], Wt[3], Wt[4], Wt[5]
  local x0, y0 = hx - lean * th, hy + 1.06 * th
  local lb = brush{kind="round", width=math.max(0.6, fw * 0.07), point=0.5}
  local n = math.floor(fw / 1.6)
  for i = 1, n do
    local u = clamp(randn(-0.4, 0.45), -1, 1)
    local ytop = y0 - th * rand(0.4, 1.0); local ybot = ytop + th * rand(0.15, 0.4)
    local p = {}
    for k = 0, 5 do local f = k / 5; local yy = ytop + (ybot - ytop) * f
      p[#p + 1] = {x0 + lean * (y0 - yy) + u * fw * (0.95 + 0.1 * math.sin(f * 4 + i)) + randn(0, 0.25), yy} end
    lb:reload(mix(mix("#4d443d", "#62574d", rand()), AIR, haze), rand(0.08, 0.18))
    lb:stroke(p, {pressure={0.3, 0.1}, ramps={0.2, 0.5}, shake=1.0, clip=m})
  end
  -- snow lying in patches on the knuckle's upper faces
  local cap = m * mask(function(xx, yy) return (1 - m:at(xx, yy - math.max(1, fw * 0.12))) * smoothstep(0.05, 0.35, capn(xx * 3 / math.max(1, fw * 0.3), yy)) end) * rect(hx - fw * 2, hy - th * 0.2, fw * 4, th * 0.3)
  work(cap, {hand="detail", tool=string.format("round %.1f", math.max(0.6, fw * 0.1)), length={1, fw * 0.4}, coverage=1.8, medium=0.16, angle=0.1, angle_jitter=0.5,
    color=mix("#8d8c9b", AIR, haze * 0.5), edge={found=0.2, soft=0.5, lost=0.3, period=5, seed=3}})
end
for i, f in ipairs(FEET) do if f[4] < 0.5 then ridges(f[5], f[4], f[3]) end end
DRIFTS = nil
-- snow dragged across every foot: horizontal strokes, each loaded with the field's own paint beside the trunk at that height
for i, f in ipairs(FEET) do
  local x, y, fw = f[1], f[2], f[5][5]
  local s = per_m(y)
  local m = f[5][1]
  local line = function(xx) local u = (xx - x) / fw; return y - 0.03 * s - 0.035 * s * math.sin(u * 1.7 + i) + 0.02 * s * capn(xx * 0.4 + 40 * i, 7 * i) end
  local under = (m:grow(4) * below(line)):roughen(0.01 * s, 0.1 * s, 60 + i, 0.3)
  work(under, {hand="body", tool=string.format("filbert %.1f", math.max(1.0, 0.04 * s)), length={0.1 * s, 0.35 * s}, coverage=4.5, medium=0.14, load=1,
    angle=0.02, angle_jitter=0.2, edge={found=0.3, soft=0.5, lost=0.2, period=0.2 * s, seed=i},
    color=function(xx, yy) local sd = (xx < x) and -1 or 1; return sample(x + sd * fw * 2.8, yy, 1.5) end})
  local b = brush{kind="filbert", width=math.max(1.0, 0.035 * s), stiffness=0.5}
  local n = math.floor(8 + fw * 0.6)
  for k = 1, n do
    local yy = y + rand(-0.08, 0.0) * s
    local u = rand(-1, 1)
    local side = (u < 0) and -1 or 1
    local c = sample(x + side * fw * rand(2.2, 3.2), yy + rand(-0.02, 0.02) * s, 1.5)
    b:reload(c, rand(0.6, 0.9))
    local reach = fw * rand(0.8, 1.6)
    local x0 = x + side * fw * rand(1.6, 2.4)
    local x1 = x0 - side * (fw * 1.2 + reach)
    local sag = rand(-0.015, 0.015) * s
    b:stroke({{x0, yy}, {(x0 + x1) / 2, yy + sag}, {x1, yy + randn(0, 0.01 * s)}}, {pressure={0.75, 0.15}, ramps={0.05, 0.6}, shake=0.5})
  end
end
