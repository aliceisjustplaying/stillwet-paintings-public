function tuft_at(x, y, pl, prmax, nb, scale)
  if fgg:at(x,y) < 0.5 then return end
  local k = (y-525)/190
  local b = brush{kind="rigger", width=1.0 + 2.4*k, point=1}
  b:load(pl, 0.75)
  local L = (4 + 30*k) * (scale or 1)
  for j=1,nb do
    local ang = -math.pi/2 + randn(0, 0.3)
    blade(b, x + rand(-L*0.25, L*0.25), y + rand(-1,1), L*rand(0.6,1.25), ang, randn(0, L*0.15), rand(0.5,prmax))
    if b:fullness() < 0.2 then b:load(pl, 0.6) end
  end
end
-- clusters, denser near the bottom
for c=1,90 do
  local y = 530 + 190*math.sqrt(rand(0,1))
  local x = rand(0,1000)
  local r = 6 + 30*(y-525)/190
  for t=1,math.random(4,9) do
    tuft_at(x + randn(0, r), y + randn(0, r*0.35), (t%3==0) and gr_mid or gr_dk, 0.9, math.random(4,8), 1.0)
  end
end
-- tall reeds in corners and along the near left bank
local reed = brush{kind="rigger", width=2.6, point=1}
local function reeds(n, x0, x1, y0, y1, L0, L1)
  for i=1,n do
    local x, y = rand(x0,x1), rand(y0,y1)
    if fgg:at(x,y) > 0.5 then
      reed:load((i%4==0) and gr_mid or gr_dk, 0.7)
      local L = rand(L0, L1)
      blade(reed, x, y, L, -math.pi/2 + randn(0.05, 0.12), randn(0, L*0.08), rand(0.55,0.8))
    end
  end
end
reeds(70, 0, 220, 640, 720, 40, 95)
reeds(45, 380, 490, 640, 720, 35, 80)
reeds(50, 860, 1000, 650, 720, 40, 90)
