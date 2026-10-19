local b = brush{kind="round", width=3.2, point=0.2}
b:load(treeP2, 0.7)
local holesC = {{818,390,6,5},{862,389,8,5},{907,391,6,3.5}}
for hi,h in ipairs(holesC) do
  for i = 1, 16 do
    local a = rand(0, math.pi*2); local r = rand(0.1, 0.9)
    local x = h[1] + h[3]*r*math.cos(a); local y = h[2] + h[4]*r*math.sin(a)
    if not (hi == 2 and y > h[2] + 1 and math.abs(x - h[1] - 3) < 3) then
      b:touch(x, y, {pressure=rand(0.4,0.7), drag={randn(0,0.5), rand(0,1.5)}})
    end
    if i % 8 == 0 then b:load(treeP2, 0.6) end
  end
end
