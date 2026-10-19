fgLav = pile{{"lead white",2.2},{"smalt",1.2},{"raw umber",0.25},{"red earth",0.1},{"vermilion",0.03}, medium=0.12}
-- a scumbled, broken lower edge: short horizontal dabs of the ground's lavender, dragged over the drift's bottom
math.randomseed(71)
local b = brush{kind="filbert", width=3}
for i=1,70 do
  if b:fullness() < 0.3 then b:load(fgLav, 0.5) end
  local x = rand(742, 975); local y = rand(689, 700)
  local l = rand(4, 14)
  b:stroke({{x, y}, {x + l, y + rand(-0.8, 0.8)}}, {pressure={0.35, 0.15}, shake=0.3})
end
-- tufts across the drift
for i,t in ipairs({{770,697,1.3,14,6},{812,700,1.4,12,5},{880,699,1.3,12,5},{938,701,1.4,14,6},{850,705,1.5,10,5}}) do tuft2(t[1], t[2], t[3], t[4], 2000+i, 0.22, t[5]) end
