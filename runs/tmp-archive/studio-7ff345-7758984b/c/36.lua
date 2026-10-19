-- distant woods: hazy bare crowns along the top of the silhouette, so the domes read as trees
woodsHaze = pile{{"lead white",3.5},{"smalt",1},{"pale smalt",1},{"vermilion",0.08},{"bone black",0.08}, medium=0.45}
local g = brush{kind="rigger", width=0.8, point=1}
local n = 0
for i = 1, 520 do
  local x = rand(500, 1000)
  if math.abs(x - 662) > 40 then
    local y0 = woodtop(x) + rand(3, 9)
    local L = rand(5, 14)
    local a = -math.pi/2 + randn(0, 0.25)
    if n % 8 == 0 then g:load(woodsHaze, 0.5) end
    g:stroke({{x, y0}, {x + math.cos(a) * L * 0.5, y0 + math.sin(a) * L * 0.5}, {x + math.cos(a + randn(0, 0.2)) * L, y0 + math.sin(a) * L}},
      {pressure={0.5, 0.02}, ramps={0, 0.6}})
    n = n + 1
  end
end
print(n)
