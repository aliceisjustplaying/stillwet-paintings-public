-- reed beds at the ends of the mere and sparse reeds along the shores: stems bent by the snow, plumes, a few blades
reedP = pile{{"yellow ochre",2},{"raw umber",1.2},{"lead white",0.6},{"red earth",0.2}, medium=0.2}
reedDark = pile{{"raw umber",2},{"bone black",0.5},{"yellow ochre",0.6}, medium=0.2}
local g = brush{kind="rigger", width=1.2, point=1}
local f = brush{kind="rigger", width=0.8, point=1}
local cnt = 0
function reed(x, y, h, lean, pile)
  local a = -math.pi / 2 + lean + randn(0, 0.08)
  local pts = {{x, y}}
  local px, py = x, y
  local broken = math.random() < 0.18
  local n = 5
  for k = 1, n do
    local s = h / n
    if broken and k == 4 then a = a + ((math.random() < 0.5) and -1 or 1) * rand(0.9, 1.6) end
    a = a + 0.04 * lean * 3
    px, py = px + math.cos(a) * s, py + math.sin(a) * s
    pts[#pts+1] = {px, py}
  end
  if cnt % 5 == 0 then g:load(pile, 0.7) end
  g:stroke(pts, {pressure={0.55, 0.12}, ramps={0, 0.4}})
  cnt = cnt + 1
  -- plume: a small drooping feathered tuft
  if not broken and math.random() < 0.6 then
    f:load(reedDark, 0.6)
    for j = 1, 4 do
      local da = rand(0.3, 1.2)
      f:stroke({{px, py}, {px + math.cos(a + da) * 2.5 + 1, py + math.sin(a + da) * 2.5}, {px + math.cos(a + da) * 4 + 1.5, py + 2 + j * 0.6}}, {pressure={0.5, 0.05}})
    end
  end
  -- a leaf blade on some
  if math.random() < 0.35 then
    local i = math.random(2, 4)
    local q = pts[i]
    local side = (math.random() < 0.5) and -1 or 1
    f:load(pile, 0.6)
    f:stroke({q, {q[1] + side * rand(3, 6), q[2] - rand(1, 3)}, {q[1] + side * rand(6, 10), q[2] + rand(0, 4)}}, {pressure={0.6, 0.02}})
  end
end
function reedBed(cx, cy, wx, n, hmin, hmax, lean)
  for i = 1, n do
    local x = cx + randn(0, wx)
    local y = cy + rand(-3, 3)
    local d = math.abs(x - cx) / (2 * wx)
    reed(x, y, rand(hmin, hmax) * (1 - 0.5 * d), lean + randn(0, 0.1), (math.random() < 0.5) and reedP or reedDark)
  end
end
reedBed(418, 572, 14, 45, 14, 32, 0.12)
reedBed(452, 563, 10, 16, 10, 22, 0.1)
reedBed(912, 566, 12, 38, 14, 30, 0.15)
reedBed(870, 556, 10, 14, 8, 18, 0.12)
-- sparse along the far shore
for i = 1, 26 do local x = rand(480, 850); reed(x, mereFar(x) + 1, rand(5, 13), 0.12 + randn(0, 0.1), (math.random() < 0.5) and reedP or reedDark) end
print(cnt)
