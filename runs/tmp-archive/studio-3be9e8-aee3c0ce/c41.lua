local b = brush{kind="flat", width=14, stiffness=0.6}
local jb = jugBody:grow(1)
local n = 0
for pass = 1, 2 do
for s = 0, 13 do
  local t = lerp(0.42, 1.0, (s + 0.5) / 14) + rand(-0.01, 0.01)
  local y = 190 + rand(0, 20)
  while y < 610 do
    local len = rand(50, 90)
    local pts = {}
    local yy = y
    while yy <= math.min(y + len, 612) do
      pts[#pts+1] = {lerp(edgeX(jugL, yy), edgeX(jugR, yy), t), yy}
      yy = yy + 6
    end
    if #pts >= 2 then
      b:stroke(pts, {pressure={0.7, 0.6}, ramps={0.1, 0.1}, orient="across", clip=jb})
      b:wipe(1)
      n = n + 1
    end
    y = y + len * 0.85
  end
end
end
print(n)
