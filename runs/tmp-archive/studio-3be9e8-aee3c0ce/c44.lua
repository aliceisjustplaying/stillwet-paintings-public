local b = brush{kind="flat", width=10, stiffness=0.6}
local L = lemons:grow(2)
local n = 0
for pass = 1, 2 do
  for y = 515, 645, 7 do
    for x0 = 520, 800, 45 do
      local a = pass == 1 and -0.15 or 0.15
      local x1 = x0 + 50
      local pts = {{x0, y + (x0-660)*a*0.1}, {x1, y + (x1-660)*a*0.1}}
      if L:at(x0+25, y) > 0.1 then
        b:stroke(pts, {pressure={0.7,0.6}, ramps={0.1,0.1}, orient="across", clip=L})
        b:wipe(1)
        n = n + 1
      end
    end
  end
end
print(n)
