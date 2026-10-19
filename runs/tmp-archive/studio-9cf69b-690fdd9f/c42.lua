grassP = pile{{"yellow ochre",1.5},{"raw umber",1.2},{"lead white",0.5},{"red earth",0.2}, medium=0.12}
grassD = pile{{"raw umber",1.6},{"bone black",0.5},{"yellow ochre",0.5},{"lead white",0.3}, medium=0.1}
function grassClump(x, y, h, n, pile, seedHeads)
  local r = brush{kind="rigger", width=1.6, point=1}
  r:load(pile, 0.6)
  for i = 1, n do
    local bx = x + randn(0, h*0.12)
    local lean = randn(0, 0.35) + 0.08
    local hh = h * rand(0.4, 1.0)
    local tx = bx + math.sin(lean) * hh
    local ty = y - math.cos(lean) * hh
    local mx = bx + math.sin(lean) * hh * 0.5 + randn(0, hh*0.03)
    local my = y - math.cos(lean) * hh * 0.5
    -- some stalks bend over at the top, broken by the snow
    if math.random() < 0.25 then tx = tx + hh*0.25*(lean>0 and 1 or -1); ty = ty + hh*0.3 end
    r:stroke({{bx, y}, {mx, my}, {tx, ty}}, {pressure={rand(0.45,0.7), 0.0}, ramps={0.05, 0.6}})
    if seedHeads and math.random() < 0.3 then
      r:stroke({{tx, ty}, {tx + math.sin(lean)*2.5, ty - 3}}, {pressure={0.75, 0.3}})
    end
    if i % 6 == 0 then r:load(pile, 0.6) end
  end
end
-- lower left corner
grassClump(30, 690, 34, 22, grassP, true)
grassClump(60, 702, 26, 14, grassD, false)
grassClump(14, 668, 22, 10, grassP, true)
-- lower right, by the track
grassClump(820, 690, 30, 18, grassP, true)
grassClump(850, 704, 22, 10, grassD, false)
grassClump(935, 670, 24, 14, grassP, true)
grassClump(975, 700, 28, 12, grassD, true)
-- smaller, farther tufts
grassClump(420, 610, 12, 9, grassP, false)
grassClump(460, 632, 14, 8, grassD, false)
grassClump(700, 585, 9, 7, grassP, false)
grassClump(330, 560, 8, 6, grassP, false)
grassClump(760, 548, 6, 5, grassP, false)
