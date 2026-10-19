local avoid = (MAN + WOMAN):grow(2) + BOULD:grow(1) + NARROW
local wh = pile{{"lead white", 2.2}, {"yellow ochre", 0.1}, medium=0.08}
local ye = pile{{"chrome yellow", 1}, {"yellow ochre", 0.3}, {"lead white", 0.3}, medium=0.08}
local bl = pile{{"cobalt blue", 1}, {"smalt", 0.4}, {"lead white", 0.5}, medium=0.08}
local rd = pile{{"vermilion", 0.6}, {"red earth", 0.2}, {"lead white", 0.9}, medium=0.08}
local t = brush{kind="round", width=2.4, point=0.3, stiffness=0.5}
local t2 = brush{kind="round", width=1.2, point=0.3, stiffness=0.5}
print(t:mark_width(0.3), t:mark_width(0.6))
local function yarrow(x, y, d)
  t2:load(wh, 0.5)
  for k=1,6 do t2:touch(x + randn(0, 1.4*d), y + randn(0, 0.5*d), {pressure=0.35 + 0.2*d}) end
end
local function daisy(x, y, d)
  t:load(wh, 0.6); t:touch(x, y, {pressure=0.25 + 0.3*d})
  t2:load(ye, 0.5); t2:touch(x + 0.1, y + 0.05, {pressure=0.2})
end
local function dot(x, y, d, p) t2:load(p, 0.5); t2:touch(x, y, {pressure=0.3 + 0.35*d}) end
local n = 0
for i=1,260 do
  local x = rand(0, 1000)
  local y = lerp(fg(x) + 50, 646, rand(0,1)^0.6)
  local d = clamp((y - 560)/90, 0.1, 1)
  if avoid:at(x, y) < 0.2 then
    local r = math.random()
    if r < 0.25 then yarrow(x, y, d) elseif r < 0.5 then daisy(x, y, d) elseif r < 0.8 then dot(x, y, d, ye) elseif r < 0.9 then dot(x, y, d, rd) else dot(x, y, d, bl) end
    n = n + 1
  end
end
print(n)
