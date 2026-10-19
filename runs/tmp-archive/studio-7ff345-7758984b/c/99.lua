-- far too blue and far too visible: lift it all again
local function lift(m, x0, x1, y0, y1)
  for pass = 1, 4 do
    for y = y0, y1, 1.4 do
      for x = x0, x1, 12 do
        local xx = x + rand(-3, 3)
        if m:at(xx + 5, y) > 0.02 then
          rag:wipe(1)
          rag:stroke({{xx, y}, {xx + 11, y}}, {pressure={0.6, 0.6}, ramps={0.05, 0.05}})
        end
      end
    end
  end
end
local strip = (rect(480, 528, 300, 22) * above(function(x) return mereFar(x) + 1 end)):grow(3)
lift(strip, 474, 786, 524, 552)
lift(ellipse(428, 556, 40, 23), 383, 472, 532, 580)
lift(ellipse(900, 553, 46, 21), 850, 950, 531, 575)
rag:wipe(1)
