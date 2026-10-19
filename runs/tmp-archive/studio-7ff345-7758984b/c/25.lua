-- the fine twiglets at every twig end: oak's crooked clustered shoots
twigP = pile{{"raw umber",2},{"bone black",1},{"lead white",0.8},{"smalt",0.4}, medium=0.3}
bFine = brush{kind="rigger", width=0.8, point=1}
local cnt = 0
local function twiglets(s)
  local pts = s.pts
  local n = #pts
  local x, y = pts[n][1], pts[n][2]
  local a = math.atan(pts[n][2] - pts[n-1][2], pts[n][1] - pts[n-1][1])
  local k = math.random(2, 4)
  for i = 1, k do
    local ca = a + rand(-0.9, 0.9)
    local L = rand(4, 10)
    local mx, my = x + math.cos(ca) * L * 0.5, y + math.sin(ca) * L * 0.5
    local ca2 = ca + rand(-0.35, 0.35)
    local ex, ey = mx + math.cos(ca2) * L * 0.5, my + math.sin(ca2) * L * 0.5
    if cnt % 6 == 0 then bFine:load(twigP, 0.55) end
    bFine:stroke({{x, y}, {mx, my}, {ex, ey}}, {pressure={0.55, 0.05}, ramps={0, 0.5}})
    cnt = cnt + 1
    -- a second tier on some
    if math.random() < 0.45 then
      local ca3 = ca2 + rand(-0.8, 0.8)
      bFine:stroke({{ex, ey}, {ex + math.cos(ca3) * L * 0.5, ey + math.sin(ca3) * L * 0.5}}, {pressure={0.35, 0.02}, ramps={0, 0.6}})
      cnt = cnt + 1
    end
  end
end
for _, s in ipairs(oakSegs) do if not s.dead and s.w1 < 0.62 then twiglets(s) end end
for _, s in ipairs(oakSegs2) do if s.w1 < 0.62 then twiglets(s) end end
print(cnt)
