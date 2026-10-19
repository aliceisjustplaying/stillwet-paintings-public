birdP = pile{{"raw umber",1},{"bone black",0.4},{"smalt",0.3},{"lead white",0.3}}
local r = brush{kind="rigger", width=1.5, point=1}
local birds = {{468,300,7},{497,286,6},{522,311,5},{548,296,4}}
for i, bd in ipairs(birds) do
  local x, y, s = bd[1], bd[2], bd[3]
  local tilt = rand(-0.15, 0.15)
  r:reload(birdP, 0.5)
  r:stroke({{x - s, y - s*0.25 + tilt*s}, {x - s*0.45, y - s*0.45}, {x, y}}, {pressure={0.1, 0.5}, ramps={0.3,0.1}})
  r:reload(birdP, 0.5)
  r:stroke({{x, y}, {x + s*0.45, y - s*0.5}, {x + s, y - s*0.2 - tilt*s}}, {pressure={0.5, 0.1}, ramps={0.1,0.3}})
end
-- two poplars breaking the top of the far clump
local pop1 = outline{{741,431},{743,412},{745,398},{747,412},{750,431}, closed=true, char="soft", amount=0.5, seed=161}:mask()
local pop2 = outline{{896,420},{899,396},{902,384},{905,398},{908,420}, closed=true, char="soft", amount=0.5, seed=162}:mask()
work(pop1 + pop2, {hand="detail", pile=treeD, angle=-1.5, coverage=3, fill=true, clip=true})
