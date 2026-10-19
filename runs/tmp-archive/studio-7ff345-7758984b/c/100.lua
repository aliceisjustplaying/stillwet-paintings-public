-- the reeds need no more glazing; instead a few darker stems and broken heads among them, for variety
local r = brush{kind="rigger", width=0.6, point=1}
local function stem(x, y, h, lean, bent)
  local tx, ty = x + lean * h, y - h
  local pts = {{x, y}, {x + lean * h * 0.5, y - h * 0.5}, {tx, ty}}
  if bent then pts[#pts+1] = {tx + h * 0.25 * (lean >= 0 and 1 or -1), ty + h * 0.2} end
  r:stroke(pts, {pressure={0.55, 0.05}, ramps={0.05, 0.5}})
end
r:load(reedDark, 0.7)
local n = 0
for i = 1, 14 do stem(rand(398, 458), rand(560, 574), rand(9, 18), randn(0.1, 0.12), math.random() < 0.3); n = n + 1; if n % 4 == 0 then r:load(reedDark, 0.7) end end
for i = 1, 12 do stem(rand(866, 932), rand(557, 568), rand(8, 15), randn(-0.05, 0.12), math.random() < 0.3); n = n + 1; if n % 4 == 0 then r:load(reedDark, 0.7) end end
for i = 1, 9 do local x = rand(490, 840); stem(x, mereFar(x) + 0.5, rand(4, 8), randn(0, 0.15), math.random() < 0.4); n = n + 1; if n % 4 == 0 then r:load(reedDark, 0.7) end end
