dry()
AIR = "#a9a5ad"
function per_m(y) return (y - HZ) / 1.7 end
-- one pollard willow, by hand: trunk outline, dark body, rim of glow on the left, rods from the knuckle
function willow(x, y, lean, nrods, seed, haze)
  local s = per_m(y)
  local th = 1.9 * s * (0.9 + 0.2 * rand())
  local fw = 0.34 * s
  local function P(dx, h, c) return {x + dx + lean * h, y - h, c} end
  local pts = {
    {x - fw * 1.35, y + 0.06 * s},
    P(-fw * 1.0, 0.25 * th), P(-fw * 0.85, 0.55 * th), P(-fw * 1.05, 0.78 * th),
    P(-fw * 1.75, 0.9 * th, "c"), P(-fw * 1.25, 1.04 * th), P(-fw * 0.5, 1.09 * th, "c"), P(fw * 0.2, 1.05 * th),
    P(fw * 0.8, 1.1 * th, "c"), P(fw * 1.7, 0.95 * th, "c"), P(fw * 1.05, 0.8 * th), P(fw * 0.9, 0.5 * th), P(fw * 1.05, 0.22 * th),
    {x + fw * 1.45, y + 0.06 * s}}
  local o = outline{pts=pts, char="broken", seed=seed, amount=0.8}
  local m = o:mask()
  local dark = mix("#35302c", AIR, haze)
  work(m, {hand="body", tool=string.format("filbert %.1f", math.max(1.2, fw * 0.5)), length={0.1 * th, 0.35 * th}, coverage=4, medium=0.15,
    angle=1.57 + lean, angle_jitter=0.15, color=function(xx, yy) return mix(dark, mix("#4d433b", AIR, haze), 0.5 + 0.5 * math.sin(xx * 1.7 + yy * 0.3)) end,
    edge={found=0.8, soft=0.2, period=15, seed=seed}})
  -- rim of light from the glow on the left flank
  local rim = m * mask(function(xx, yy) return 1 - m:at(xx - math.max(0.8, fw * 0.18), yy) end)
  work(rim, {hand="detail", tool="round 0.8", length={2, 7}, coverage=1.2, medium=0.2, angle=1.57 + lean, broken=0.6,
    color=mix("#6d6158", AIR, haze * 0.6)})
  -- rods: from a few knobs on the head, outer ones lean out and curve back up, lengths very uneven
  local hx, hy = x + lean * th, y - 1.06 * th
  local knobs = {}
  for k = 1, 5 do knobs[k] = {hx + (k - 3) * fw * 0.6 + randn(0, fw * 0.12), hy + math.abs(k - 3) * 0.05 * th + randn(0, 0.02 * th)} end
  local rodc = mix("#2c2724", AIR, haze)
  for pass = 1, 2 do
    local rb = brush{kind="rigger", width=math.max(0.5, (pass == 1 and 0.06 or 0.035) * s), point=1}
    local n = pass == 1 and nrods or math.floor(nrods * 0.8)
    for i = 1, n do
      if i % 5 == 1 then rb:reload(mix(rodc, "#4a3d33", rand() * 0.35), 0.95) end
      local kn = knobs[math.random(1, 5)]
      local u = clamp((kn[1] - hx) / (fw * 1.4) + randn(0, 0.35), -1.2, 1.2)
      local a0 = -1.5708 + u * 0.85 + randn(0, 0.1)
      local bend = -u * 0.55 + randn(0, 0.08)             -- curving back toward the vertical
      local len = s * 4.6 * rand(0.3, 1.0)^0.7 * (pass == 1 and 1 or 0.6) * (1 - 0.25 * math.abs(u))
      local p = {{kn[1] + randn(0, fw * 0.1), kn[2]}}
      local px, py = p[1][1], p[1][2]
      for k = 1, 5 do
        local aa = a0 + bend * (k / 5)^1.3
        px = px + math.cos(aa) * len / 5; py = py + math.sin(aa) * len / 5
        p[#p + 1] = {px + randn(0, 0.15), py}
      end
      rb:stroke(p, {pressure={0.9, 0.0}, ramps={0.02, 0.75}, shake=0.5})
    end
  end
  return m, hx, hy, th, fw
end
W1 = {willow(455, 572, 0.05, 60, 101, 0.0)}
W2 = {willow(532, 521, -0.04, 50, 102, 0.22)}
W3 = {willow(577, 500, 0.06, 36, 103, 0.4)}
W4 = {willow(603, 491.5, -0.02, 26, 104, 0.55)}
W5 = {willow(621, 486.5, 0.03, 18, 105, 0.66)}
