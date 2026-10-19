local rim = (rc:grow(10) - rc:shrink(10)) - refl2:grow(4)
blend(rim, {angle=1.5, angle_jitter=0.2, tool="badger 14", length={15,35}, clip=false})
-- thin sky-colour ripple lines across the reflected cloud to break it
pRip = pile{{"lead white",5},{"pale smalt",1},{"yellow ochre",0.15},{"vermilion",0.05}}
local b = brush{kind="flat", width=3, stiffness=0.4}
for i = 1, 16 do
  local y = rand(545, 680)
  local x0 = rand(470, 900)
  local L = rand(60, 220)
  b:reload(pRip, 0.35)
  b:stroke({{x0, y}, {x0 + L*0.5, y + rand(-1,1)}, {x0 + L, y + rand(-1,1)}}, {pressure={0.3, 0.1}, ramps={0.2,0.5}, orient="across"})
end
