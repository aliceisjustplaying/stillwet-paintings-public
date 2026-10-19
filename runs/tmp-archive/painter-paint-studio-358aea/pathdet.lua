local edgeD = pile{{"raw umber",0.9},{"green earth",0.6},{"yellow ochre",0.6},{"lead white",0.9},{"pale smalt",0.3}, medium=0.1}
local pebL = pile{{"lead white",3},{"yellow ochre",0.4},{"raw umber",0.2}, medium=0.08}
local pebD = pile{{"raw umber",1},{"lead white",1},{"pale smalt",0.3},{"bone black",0.1}, medium=0.08}
-- shaded edges of the path: a thin darker band inside each edge
local inner = (PATH - PATH:shrink(3)) * mask(function(x,y) return y > 565 and 1 or 0 end)
work(inner, {hand="hatch", pile=edgeD, tool={kind="round", width=1.3, point=0.6}, angle=0.2, angle_jitter=0.4, length={2,6}, coverage=0.9, clip=true, threshold=0.3, seed=3401})
-- the worn centre strip of grass between two tracks, fading into distance
local strip = {}
for i=1,#PC-3 do strip[#strip+1] = PC[i] end
local ws = {}
for i=1,#strip do ws[i] = lerp(9, 0.8, ((i-1)/(#strip-1))^0.7) end
local cs = ribbon(strip, ws) * PATH:shrink(2) * mask(function(x,y) return y > 575 and 1 or 0 end)
local gC = pile{{"yellow ochre",1.3},{"green earth",1.3},{"lead white",1.2},{"Prussian blue",0.08},{"raw umber",0.2}, medium=0.1}
work(cs, {hand="hatch", pile=gC, tool={kind="round", width=1.2, point=0.8}, angle=-math.pi/2, angle_jitter=0.35, length={2,6}, coverage=0.9, pressure={0.35,0.7}, ramps={0.1,0.6}, threshold=0.4, seed=3402})
-- pebbles
local b = brush{kind="round", width=1.6, point=0.3}
for k=1,70 do
  local y = rand(575, 704)
  local x = rand(420, 620)
  if PATH:shrink(2):at(x,y) > 0.5 then
    local s = 0.25 + (y-570)/250
    b:reload(pebD, 0.4)
    b:touch(x, y + 0.6*s, {pressure=clamp(0.3*s+0.15, 0.15, 0.6)})
    b:reload(pebL, 0.4)
    b:touch(x - 0.4*s, y, {pressure=clamp(0.25*s+0.12, 0.12, 0.5)})
  end
end
-- the man's walking stick
local st = brush{kind="rigger", width=0.9, point=0.8}
st:load(pile{{"raw umber",1},{"bone black",0.3},{"lead white",0.3}, medium=0.08}, 0.6)
st:stroke({{456.5,517},{458.5,540},{460.2,561}}, {pressure={0.6,0.45}})
print(wait(0))
