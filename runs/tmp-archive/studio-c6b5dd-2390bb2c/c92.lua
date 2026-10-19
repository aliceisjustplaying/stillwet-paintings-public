print(wait(2*24*60))
local top = {{-10,628}}
local x = -10
while x < 420 do
  x = x + rand(8, 22)
  local base = 628 + (x+10) * 0.08 + ((x > 250) and (x-250)*0.35 or 0)
  top[#top+1] = {x, base + rand(-7, 4)}
end
top[#top+1] = {440, 730}
fg = below(top):roughen(3, 14, 181, 0)
pFG = pile{{"raw umber",1.8},{"bone black",0.6},{"Prussian blue",0.25},{"yellow ochre",0.5},{"red earth",0.2}}
work(fg, {hand="body", tool="filbert 10", pile=pFG, angle=function(x,y) return -0.3 + 0.4*math.sin(x/30) end, angle_jitter=0.5, coverage=3.5, load=0.95, fill=true, length={15,40}, edge="soft"})
