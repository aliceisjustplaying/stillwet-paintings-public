tFrontL = pile{{"raw umber",2},{"yellow ochre",0.8},{"bone black",0.4},{"lead white",0.9}}
local F = front * rect(0, 692, 1000, 110) - kHandle2:grow(1)
work(F, {hand="body", tool="filbert 12", pile=tFront, coverage=2, angle=0, angle_jitter=0.03, length={60,150}, edge="firm", fill=true, clip=F})
local left = F * mask(function(x,y) return 1 - smoothstep(150, 450, x) end)
work(left, {hand="body", tool="filbert 12", pile=tFrontL, coverage=1.2, angle=0, length={60,140}, threshold=0.4, clip=F})
local sb = brush("filbert", 10)
for i = 0, 2 do
  sb:reload(kShadow, 0.7)
  sb:stroke({{782, 705 + i*5}, {860, 716 + i*5}, {935, 726 + i*5}}, {pressure={0.6,0.5}, ramps={0.1,0.3}, orient="across", clip=F})
end
blend(F, {angle=0.02})
