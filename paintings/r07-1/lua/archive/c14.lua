-- small far pollards along the far shore, each by hand: bole, knob, a head of many short rods; hazier to the right
local tb, kb, rg = brush("round", 1.5), brush("round", 1.2), brush{kind="rigger", width=0.5, point=1}
for i, f in ipairs(FARWILL) do
  local x, y, h = f[1], f[2], f[3] * 1.2
  local haze = smoothstep(640, 920, x) * 0.6
  local col = mix("#4e4a52", FARC.mist, haze)
  local bh = h * rand(0.3, 0.42)
  local lean = randn(0, 0.06)
  tb:reload(col, 0.7)
  tb:stroke({{x, y + 1}, {x + lean * bh, y - bh}}, {pressure={0.85, 0.7}, ramps={0.05, 0.2}})
  local hx, hy = x + lean * bh, y - bh
  local cr = (h - bh) * rand(0.45, 0.6)          -- the head's radius
  local sky = sample(hx, hy - h, 3)
  -- the head's mass: soft touches of the rods' color thinned with the sky
  kb:reload(mix(col, sky, 0.22), 0.6)
  for k = 1, math.random(14, 22) do
    local a, r = rand(-3.3, 0.2), cr * math.sqrt(rand()) * 0.9
    kb:touch(hx + math.cos(a) * r, hy - cr * 0.8 + math.sin(a) * r * 0.9, {pressure=rand(0.25, 0.5), drag={0, -rand(0.3, 1)}})
  end
  rg:reload(mix(col, sky, 0.2), 0.7)
  for r = 1, math.random(14, 22) do
    local a = -1.57 + randn(0, 0.55)
    local len = cr * rand(1.0, 2.0)
    rg:stroke({{hx + randn(0, 0.5), hy}, {hx + math.cos(a) * len * 0.5, hy + math.sin(a) * len * 0.5}, {hx + math.cos(a) * len, hy + math.sin(a) * len}},
      {pressure={0.45, 0.02}, ramps={0.05, 0.7}})
  end
end
