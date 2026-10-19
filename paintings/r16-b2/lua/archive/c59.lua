gdeep = pile{{"green earth",2},{"raw umber",1.5},{"Prussian blue",0.15},{"bone black",0.1},{"smalt",0.3}, medium=0.3}
local inner = GROVEALL:shrink(4)
for id=1,4 do
  local w = WINFO[id]
  local hx, hy = w.hx, w.hy
  local ang = function(x,y) return math.atan(y-(hy+w.s*0.05), x-hx) end
  work(inner * w.C, {hand="hatch", pile=gdeep, tool={kind="round", width=math.max(1.2, w.s*0.01), point=0.8}, angle=ang, angle_jitter=0.3, coverage=1.6, fill=false, length={w.s*0.025, w.s*0.06}, pressure={0.4,0.8},
    load_at=function(x,y) return clamp(0.3 + (y-400)/150, 0.15, 0.9) end, seed=590+id})
end
-- trunks at the foot of the grove
local tb = brush{kind="round", width=2.4, point=0.5}
for i,t in ipairs({{28,3.2},{70,2.6},{112,3.4},{150,2.2},{196,3},{233,2.4},{275,2.8},{318,2.2},{352,1.8}}) do
  tb:load(gdeep, 0.6)
  local x = t[1]
  tb:stroke({{x, 499},{x+rand(-1,1), 490},{x+rand(-2,2), 481}}, {pressure={t[2]/3.4, 0.2}})
end
