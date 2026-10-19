-- darker, cooler weight in the bank and a few warm grass notes catching the last light along its top
local nzb = noise{seed=201, octaves=3, period=60}
local dark = fg:shrink(12) * mask(function(x,y) return nzb(x,y) > 0.1 and 1 or 0 end)
pFG2 = pile{{"raw umber",1.4},{"bone black",0.9},{"Prussian blue",0.35},{"yellow ochre",0.2}}
work(dark, {hand="body", tool="filbert 8", pile=pFG2, angle=-0.4, angle_jitter=0.6, coverage=2.5, load=0.9, length={10,30}, clip=fg:shrink(4)})
local r = brush{kind="rigger", width=1.8, point=1}
pGrass = pile{{"yellow ochre",2},{"raw umber",0.8},{"red earth",0.3},{"lead white",0.4}}
local function edgeY(x)
  for y = 560, 714, 2 do if fg:at(x, y) > 0.5 then return y end end
  return 714
end
local xs = uneven(55, 5, 400, 0.7, 0.7, 202)
for i, x in ipairs(xs) do
  local y0 = edgeY(x) + rand(3, 12)
  local h = rand(10, 28)
  local lean = randn(0.1, 0.3)
  if i % 3 == 1 then r:reload(pGrass, 0.6) end
  r:stroke({{x, y0}, {x + h*0.3*lean, y0 - h*0.5}, {x + h*lean, y0 - h}}, {pressure={0.55, 0}, ramps={0.02, 0.7}})
end
