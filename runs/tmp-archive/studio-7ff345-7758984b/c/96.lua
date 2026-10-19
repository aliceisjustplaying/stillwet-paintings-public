-- the reed glaze went on opaque (raw umber hides): lift it off while it is open, with a clean brush wiped after every stroke
print(drying(600, 540), drying(428, 556), drying(900, 553))
rag = brush{kind="flat", width=4, pickup=1}
local function lift(m, x0, x1, y0, y1, ang)
  for pass = 1, 3 do
    for y = y0, y1, 1.6 do
      for x = x0, x1, 12 do
        local xx = x + rand(-3, 3)
        if m:at(xx + 5, y) > 0.05 then
          rag:wipe(1)
          rag:stroke({{xx, y}, {xx + 11, y + ang}}, {pressure={0.55, 0.55}, ramps={0.05, 0.05}})
        end
      end
    end
  end
end
local strip = (rect(480, 530, 300, 20) * above(function(x) return mereFar(x) + 1 end)):soften(1)
lift(strip:grow(2), 476, 784, 528, 551, 0)
lift(ellipse(428, 556, 40, 22), 385, 470, 536, 578, 0)
lift(ellipse(900, 553, 46, 20), 852, 948, 535, 573, 0)
rag:wipe(1)
