local gD = pile{{"green earth",1.4},{"Prussian blue",0.3},{"raw umber",0.6},{"yellow ochre",0.4},{"lead white",0.3}, medium=0.08}
local gM = pile{{"green earth",1.4},{"yellow ochre",1.1},{"Prussian blue",0.15},{"raw umber",0.3},{"lead white",0.7}, medium=0.08}
local gL = pile{{"yellow ochre",1.2},{"chrome yellow",0.35},{"green earth",0.8},{"lead white",1.2}, medium=0.08}
local rb = brush{kind="rigger", width=1.3, point=1}
local function edgeAt(yy, side)
  if side < 0 then for xx = 400, 700 do if PATHX:at(xx, yy) > 0.5 then return xx end end
  else for xx = 700, 400, -1 do if PATHX:at(xx, yy) > 0.5 then return xx end end end
end
local n = 0
local yy = 572
while yy < 706 do
  local sc = 0.35 + (yy - 560)/110
  for side = -1, 1, 2 do
    if math.random() < 0.8 then
      local ey = math.min(yy, 703)
      local ex = edgeAt(ey, side)
      if ex then
        -- a tuft: base a little outside the edge, blades leaning in over the path
        local bx = ex - side*rand(-3, 2)*sc
        local nb = math.random(3, 7)
        local p = (yy > 640) and gD or ((math.random() < 0.5) and gM or gD)
        rb:reload(p, 0.55)
        for k = 1, nb do
          local h = rand(6, 16) * sc
          local lean = -side * rand(0.05, 0.6) + randn(0, 0.15)
          local x0 = bx + rand(-2, 2)*sc
          local y0 = yy + rand(0, 3)
          local curl = rand(0.1, 0.4) * lean
          rb:stroke({{x0, y0}, {x0 + lean*h*0.4, y0 - h*0.5}, {x0 + lean*h*0.8 + curl*h, y0 - h}}, {pressure={0.55, 0.0}})
          n = n + 1
        end
        if math.random() < 0.45 then
          rb:reload(gL, 0.5)
          for k = 1, math.random(1, 3) do
            local h = rand(5, 13) * sc
            local lean = -side * rand(0.1, 0.5)
            local x0 = bx + rand(-2, 2)*sc
            rb:stroke({{x0, yy+1}, {x0 + lean*h*0.4, yy - h*0.5}, {x0 + lean*h*0.9, yy - h}}, {pressure={0.45, 0.0}})
            n = n + 1
          end
        end
      end
    end
  end
  yy = yy + rand(3, 7) * (0.5 + (yy-560)/140)
end
-- a few low clumps inside the path, on the worn middle
for k = 1, 9 do
  local y0 = rand(585, 700)
  local l, r = edgeAt(y0, -1), edgeAt(y0, 1)
  if l and r then
    local x0 = lerp(l, r, rand(0.35, 0.65))
    local sc = 0.35 + (y0 - 560)/110
    rb:reload((math.random() < 0.5) and gM or gD, 0.45)
    for j = 1, math.random(3, 6) do
      local h = rand(3, 8) * sc
      local lean = randn(0, 0.4)
      local xx = x0 + rand(-3, 3)*sc
      rb:stroke({{xx, y0}, {xx + lean*h*0.5, y0 - h*0.5}, {xx + lean*h, y0 - h}}, {pressure={0.45, 0.0}})
      n = n + 1
    end
  end
end
print(n, wait(0))
