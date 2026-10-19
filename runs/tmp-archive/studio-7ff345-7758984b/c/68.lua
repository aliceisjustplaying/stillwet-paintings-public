-- dead grass through the snow: tufts thickening toward us, thinning into the distance
grassP = pile{{"yellow ochre",1.5},{"raw umber",1.5},{"red earth",0.3},{"lead white",0.3}, medium=0.2}
grassD = pile{{"raw umber",2},{"bone black",0.6},{"yellow ochre",0.5}, medium=0.2}
local g1 = brush{kind="rigger", width=1.2, point=1}
local g0 = brush{kind="rigger", width=0.8, point=1}
local cnt = 0
function tuft(x, y, h, n)
  local s = (h > 10) and g1 or g0
  for i = 1, n do
    local a = -math.pi / 2 + randn(0, 0.35) + 0.1
    local L = h * rand(0.4, 1.0)
    local bend = randn(0, 0.25)
    local bx = x + randn(0, h * 0.08)
    local pts = {{bx, y}}
    local px, py, aa = bx, y, a
    for k = 1, 3 do
      aa = aa + bend
      px, py = px + math.cos(aa) * L / 3, py + math.sin(aa) * L / 3
      pts[#pts+1] = {px, py}
    end
    if cnt % 6 == 0 then s:load((math.random() < 0.55) and grassP or grassD, 0.65) end
    s:stroke(pts, {pressure={0.5, 0.03}, ramps={0, 0.55}})
    cnt = cnt + 1
  end
end
local avoid = pathM:grow(3) + merem:grow(4) + oakLive + footM
-- foreground bank: crest tufts and scattered
for i = 1, 70 do
  local x = rand(0, 1000)
  local y = bankY(x) + rand(-3, 30)
  if avoid:at(x, y) < 0.5 then tuft(x, y, rand(8, 20) * (0.7 + (y - 640) / 100), math.random(4, 10)) end
end
-- middle ground: small and sparse
for i = 1, 120 do
  local x = rand(0, 1000)
  local y = rand(505, 640)
  if avoid:at(x, y) < 0.5 then tuft(x, y, 2 + (y - 500) / 140 * 10, math.random(2, 6)) end
end
-- knoll crest and face
for i = 1, 40 do
  local x = rand(0, 480)
  local y = knollCrest(x) + rand(1, 40)
  if avoid:at(x, y) < 0.5 then tuft(x, y, rand(2, 5), math.random(2, 5)) end
end
print(cnt)
