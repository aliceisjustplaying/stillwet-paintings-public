local b = brush{kind="flat", width=10, stiffness=0.6}
local keep = kHandle2:grow(2)
local n = 0
for pass = 1, 2 do
  for off = 16, 70, 6 do
    local pts = {{755, 697 + off}, {870, 713 + off}, {985, 729 + off}}
    b:stroke(pts, {pressure={0.7,0.7}, ramps={0.05,0.05}, orient="across", clip=front - keep})
    b:wipe(1)
    n = n + 1
  end
end
print(n)
