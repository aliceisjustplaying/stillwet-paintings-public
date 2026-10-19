print(drying(600,650), drying(560,690), drying(590,560))
local pinkw = pile{{"lead white",2.2},{"red earth",0.2},{"vermilion",0.06},{"smalt",0.3},{"raw umber",0.2}, medium=0.2}
local glint = pile{{"lead white",5},{"chrome yellow",0.35},{"vermilion",0.06}, medium=0.15}
local f = brush{kind="flat", width=3, stiffness=0.5}
local inner = creek:shrink(3)
for i=1,22 do
  local y = rand(672, 714); local x = rand(470, 660)
  if inner:at(x,y) > 0.5 then
    f:reload(pinkw, rand(0.3,0.45))
    local len = rand(15, 45)
    f:stroke({{x-len/2, y},{x, y+rand(-0.4,0.4)},{x+len/2, y}}, {pressure={0.35,0.15}, ramps={0.3,0.4}, clip=inner})
  end
end
local g = brush{kind="flat", width=1.6, stiffness=0.5}
for i=1,26 do
  local y = 500 + 150*rand(0,1)^1.3; local x = rand(500, 680)
  if inner:at(x,y) > 0.5 then
    g:reload(glint, rand(0.25,0.4))
    local len = 3 + (y-470)*0.12*rand(0.5,1.2)
    g:stroke({{x-len/2, y},{x+len/2, y+rand(-0.3,0.3)}}, {pressure={0.3,0.1}, ramps={0.3,0.5}, clip=inner})
  end
end
