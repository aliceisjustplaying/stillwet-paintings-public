-- pollards: long upright rods rising out of the crowns, each tree its own height, to break the lollipop row
wRod = pile{{"green earth", 2}, {"raw umber", 1.2}, {"lead white", 1.0}, {"pale smalt", 0.5}, {"yellow ochre", 0.3}, medium=0.1}
wLeafS = pile{{"lead white", 3.2}, {"green earth", 1.4}, {"pale smalt", 0.8}, {"yellow ochre", 0.4}, {"raw umber", 0.1}, medium=0.1}
local ext = {1.38, 1.12, 1.55, 1.22, 1.05, 1.48, 1.18, 1.32, 1.1}
local rod = brush{kind="rigger", width=0.9, point=1}
local lf = brush{kind="round", width=1.3, point=0.8}
for i = 1, 2 do
  local w = willows[i]
  local kx, ky, H, Wd = w.kx, w.ky, w.H, w.Wd
  local top = H * ext[i]
  rod:load(wRod, 0.6)
  for k = 1, 18 do
    local u = rand(-1, 1)
    local x0 = kx + u * Wd * 0.22
    local y0 = ky - H * rand(0.35, 0.6)
    local L = (top - (ky - y0)) * rand(0.7, 1.0) * (1 - 0.35 * math.abs(u))
    local a = -math.pi/2 + u * 0.42 + rand(-0.08, 0.08)
    local bend = rand(-0.06, 0.06)
    rod:stroke({{x0, y0}, {x0 + L*0.5*math.cos(a), y0 + L*0.5*math.sin(a)}, {x0 + L*math.cos(a+bend), y0 + L*math.sin(a+bend)}}, {pressure={0.55, 0.0}, ramps={0.05, 0.7}})
    if k % 5 == 0 then rod:load(wRod, 0.55) end
    -- narrow leaves along the upper rod, silvery on the lit left
    if k % 2 == 0 then
      lf:load(wLeafS, 0.35)
      for j = 1, 4 do
        local t = rand(0.45, 0.95)
        local px, py = x0 + L*t*math.cos(a), y0 + L*t*math.sin(a)
        local side = (j % 2 == 0) and 1 or -1
        lf:stroke({{px, py}, {px + side*rand(1.2, 2.2), py - rand(0.8, 1.8)}}, {pressure={0.45, 0.05}})
      end
    end
  end
end
print(wait(0))
