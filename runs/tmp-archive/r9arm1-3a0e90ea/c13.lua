FEET = {{852,616,-0.07,0.0,W0}, {455,572,0.05,0.0,W1}, {532,521,-0.04,0.22,W2}, {577,500,0.06,0.4,W3}, {603,491.5,-0.02,0.55,W4}, {621,486.5,0.03,0.66,W5}}
function whips(Wt, n, haze, lean)
  local m, hx, hy, th, fw = Wt[1], Wt[2], Wt[3], Wt[4], Wt[5]
  local s = th / 1.9
  local rb = brush{kind="rigger", width=math.max(0.45, 0.025 * s), point=1}
  for i = 1, n do
    if i % 5 == 1 then rb:reload(mix(mix("#302a27", "#54463b", rand() * 0.5), AIR, haze), 0.95, {medium=0.4}) end
    local u = clamp(randn(0, 0.5), -1.05, 1.05)
    local sx, sy = hx + u * fw * 1.1, hy + math.abs(u) * 0.06 * th + rand(-0.03, 0.05) * th
    local a0 = -1.5708 + u * 0.8 + randn(0, 0.12)
    local bend = -u * 0.5 + randn(0, 0.1)
    local len = s * 4.4 * rand(0.35, 1.0)^0.6
    local p = {{sx, sy}}
    local px, py = sx, sy
    for k = 1, 6 do
      local aa = a0 + bend * (k / 6)^1.3
      px = px + math.cos(aa) * len / 6; py = py + math.sin(aa) * len / 6
      p[#p + 1] = {px + randn(0, 0.12), py}
    end
    rb:stroke(p, {pressure={0.85, 0.0}, ramps={0.02, 0.8}, shake=0.6})
  end
end
function bark(Wt, haze, lean, seed)
  local m, hx, hy, th, fw = Wt[1], Wt[2], Wt[3], Wt[4], Wt[5]
  local s = th / 1.9
  local x0, y0 = hx - lean * th, hy + 1.06 * th
  -- darken the body again in its own paint, aimed as masstone so it is truly dark
  work(m:grow(0.5), {hand="body", tool=string.format("round %.1f", math.max(1, fw * 0.25)), length={0.1 * th, 0.3 * th}, coverage=2.5, medium=0.12, aim="masstone",
    angle=1.57 + lean, angle_jitter=0.2, edge={found=0.6, soft=0.4, period=12, seed=seed}, color=mix("#2a2522", AIR, haze), load=0.9})
  if haze > 0.3 then return end
  -- fissures and ridges, wandering down the trunk
  local fb = brush{kind="round", width=math.max(0.6, fw * 0.09), point=0.7}
  local lb = brush{kind="round", width=math.max(0.6, fw * 0.1), point=0.7}
  local nf = math.floor(fw / 1.3)
  for i = 1, nf do
    local u = rand(-0.9, 0.9)
    local ytop = y0 - th * rand(0.6, 1.0); local ybot = y0 - th * rand(0.0, 0.25)
    local p = {}
    for k = 0, 6 do local f = k / 6; local yy = ytop + (ybot - ytop) * f; p[#p + 1] = {x0 + lean * (y0 - yy) + u * fw * (0.9 + 0.2 * math.sin(f * 3 + i)) + randn(0, 0.4), yy} end
    if false then
      lb:reload(mix(mix("#6f6459", "#8a7b6c", rand()), AIR, haze), 0.6); lb:stroke(p, {pressure={0.6, 0.15}, shake=0.9, clip=m})
    else
      fb:reload(mix("#15120f", AIR, haze), 0.8); fb:stroke(p, {pressure={0.7, 0.3}, shake=0.8, clip=m})
    end
  end
  -- knobs on the knuckle: clusters of dark dabs, a lit dab or two on the upper left of each
  for i = 1, 5 do
    local bx, by = hx + rand(-1.3, 1.3) * fw, hy + rand(0.0, 0.14) * th
    local r = fw * rand(0.1, 0.22)
    fb:reload("#1a1614", 0.8)
    for k = 1, 4 do fb:touch(bx + randn(0, r * 0.5), by + randn(0, r * 0.35), {pressure=rand(0.5, 0.9), clip=m}) end
  end
end
for i, f in ipairs(FEET) do bark(f[5], f[4], f[3], 200 + i) end
whips(W0, 160, 0.0); whips(W1, 110, 0.0); whips(W2, 70, 0.22); whips(W3, 40, 0.4); whips(W4, 24, 0.55); whips(W5, 16, 0.66)
