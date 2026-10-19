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
  work(cap, {hand="detail", tool=string.format("round %.1f", math.max(0.6, fw * 0.1)), length={1, fw * 0.4}, coverage=2.4, medium=0.12, angle=0.1, angle_jitter=0.5,
    color=mix("#cfcacb", AIR, haze * 0.5), edge={found=0.2, soft=0.5, lost=0.3, period=5, seed=3}})
end
for i, f in ipairs({}) do if f[4] < 0.5 then ridges(f[5], f[4], f[3]) end end
-- snow drifted against every foot, in the field's own color, climbing the trunk unevenly
for i, f in ipairs(FEET) do
  local x, y, fw = f[1], f[2], f[5][5]
  local s = per_m(y)
  local top = function(xx) local u = (xx - x) / (fw * 2.2); return y - 0.09 * s * math.max(0, 1 - u * u) + 0.03 * s * capn(xx * 0.4 + 30 * i, i) end
  local zone = (below(top) * rect(x - fw * 2.6, y - 0.2 * s, fw * 5.2, 0.5 * s)):roughen(0.03 * s, 0.25 * s, 50 + i, 0.3)
  work(zone, {hand="body", tool=string.format("filbert %.1f", math.max(1.0, 0.05 * s)), length={0.15 * s, 0.5 * s}, coverage=3.2, medium=0.12,
    angle=function(xx, yy) return 0.25 * (xx - x) / fw * 0.3 end, angle_jitter=0.2, color=function(xx, yy) return shift(snowcol(xx, yy + 0.3 * s), -0.015, 0, -0.004) end,
    edge={found=0.3, soft=0.4, lost=0.3, period=0.3 * s, seed=i}})
end
