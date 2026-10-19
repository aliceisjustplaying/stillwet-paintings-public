mudDD2 = pile{{"raw umber",1},{"bone black",0.3},{"smalt",0.2},{"red earth",0.2},{"lead white",0.12}}
sheen = pile{{"lead white",2},{"smalt",0.5},{"red earth",0.3},{"raw umber",0.3},{"yellow ochre",0.3}}
local sp = spit2:shrink(3)
work(sp, {hand="body", pile=mudDD2, angle=function(x,y) return 0.1 + x/2000 end, angle_jitter=0.08, coverage=2.5, length={30,90}, fill=true, clip=spit2})
-- wet sheen streaks on the mud, following the bank
local b = brush("filbert", 4)
local streaks = {{10,585,120},{60,600,150},{-10,622,90},{140,618,110},{30,648,160},{200,640,90},{240,625,40},{90,575,60}}
for i, s in ipairs(streaks) do
  b:reload(sheen, 0.3)
  local x0, y0, L = s[1], s[2], s[3]
  b:stroke({{x0,y0},{x0+L*0.5,y0+L*0.08+2},{x0+L,y0+L*0.18}}, {pressure={0.3,0.05}, ramps={0.15,0.5}, clip=spit2:shrink(8)})
end
