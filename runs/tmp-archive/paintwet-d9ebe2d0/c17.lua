-- grass on the near bank: rigger blades set down at the root and lifted off, in patches (a noise), taller
-- toward me, leaning with a slow noise; dark stalks, a few tips catching the sky. Denser along the bank's lip
-- so the line where it meets the water is broken, and around the man's feet and the stones' feet.
local patch = noise{seed=93, octaves=3, period=70}
local lean = noise{seed=94, octaves=2, period=180}
local g = brush("rigger", 0.8)
local n = 0
local cols = {"#1d1c18", "#26251f", "#2e2c24", "#1a1a17", "#34332b", "#43423a"}
for i = 1, 5200 do
  local x = rand(-5, 1005)
  local top = SHORE(x)
  local depth = rand()^1.6                                   -- most near the lip
  local y = top + 1 + depth*(H - top)
  local near = clamp((y - 600)/110, 0, 1)
  local lip = 1 - smoothstep(0, 14, y - top)
  local p = patch:at01(x, y) + 0.55*lip
  if p > 0.62 and stoneM:at(x, y - 2) < 0.5 then
    local h = (5 + 26*near) * rand(0.5, 1.5)
    local a = -1.57 + 0.35*lean(x, 0) + randn(0, 0.2)
    local curl = randn(0, 0.25)
    local tip = {x + h*math.cos(a + curl), y + h*math.sin(a + curl)}
    local mid = {x + 0.55*h*math.cos(a), y + 0.55*h*math.sin(a)}
    if n % 7 == 0 then
      local k = (rand() < 0.07) and (5 + (rand() < 0.5 and 1 or 0)) or math.random(1, 4)
      g:reload(cols[k], 0.7)
    end
    g:stroke({{x, y}, mid, tip}, {pressure={0.3 + 0.5*near, 0}, ramps={0.05, 0.75}})
    n = n + 1
  end
end
print(n)
local t = timesheet() print(string.format("%.0f min this sitting", t.sitting))
