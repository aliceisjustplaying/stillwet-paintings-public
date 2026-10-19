birdp = pile{{"raw umber", 1}, {"bone black", 0.6}, {"pale smalt", 0.8}, {"lead white", 1.0}, medium=0.1}
local r = brush{kind="rigger", width=1.1, point=1}
local birds = {{548,318,3.2,0.1},{566,309,2.6,-0.15},{579,322,2.4,0.2},{597,313,2.0,0.0},{611,327,1.8,-0.1},{529,331,2.2,0.05}}
for i, b in ipairs(birds) do
  r:load(birdp, 0.45)
  local x, y, s, t = b[1], b[2], b[3], b[4]
  r:stroke({{x - s, y - s*0.35 + t*s}, {x - s*0.45, y - s*0.45}, {x, y}}, {pressure={0.1, 0.55}, ramps={0.4,0.1}})
  r:stroke({{x, y}, {x + s*0.45, y - s*0.5}, {x + s, y - s*0.3 - t*s}}, {pressure={0.55, 0.1}, ramps={0.1,0.4}})
end
-- two swallows closer, higher, with forked tails
local sw = brush{kind="round", width=1.4, point=1}
for _, b in ipairs({{770,228,7,1},{812,246,5.5,-1}}) do
  local x, y, s, d = b[1], b[2], b[3], b[4]
  sw:load(birdp, 0.5)
  sw:stroke({{x - s, y + s*0.25}, {x - s*0.45, y - s*0.15}, {x, y}}, {pressure={0.05, 0.6}, ramps={0.5,0.1}})
  sw:stroke({{x, y}, {x + s*0.5, y - s*0.1}, {x + s*1.05, y + s*0.35}}, {pressure={0.6, 0.05}, ramps={0.1,0.5}})
  sw:touch(x, y + 0.3, {pressure=0.6})
  sw:stroke({{x, y + 0.5}, {x - s*0.1*d, y + s*0.45}}, {pressure={0.4,0.05}})
  sw:stroke({{x, y + 0.5}, {x + s*0.18*d, y + s*0.42}}, {pressure={0.4,0.05}})
end
print(wait(0))
