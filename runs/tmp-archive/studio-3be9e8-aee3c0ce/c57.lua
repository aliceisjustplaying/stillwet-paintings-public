local b = brush{kind="flat", width=12, stiffness=0.6}
local keep = kHandle2:grow(1)
for pass = 1, 2 do
  for off = 19, 72, 5 do
    b:stroke({{750, 697 + off + pass*2}, {870, 713 + off + pass*2}, {990, 729 + off + pass*2}}, {pressure={0.8,0.8}, ramps={0.05,0.05}, orient="across", clip=front - keep})
    b:wipe(1)
  end
end
for y = 700, 745, 6 do
  b:stroke({{938, y}, {995, y + 8}}, {pressure={0.8,0.8}, ramps={0.05,0.05}, orient="across", clip=front - keep})
  b:wipe(1)
end
