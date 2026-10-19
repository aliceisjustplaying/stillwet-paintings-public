-- a lightning scar: the dead leader's bare wood torn down into the trunk, a dark rim of callus along it
local scar = poly({{236,262},{250,262},{252,280},{247,296},{245,315},{241,334},{238,350},{236,334},{234,312},{232,292},{233,276}}, true):roughen(1.2, 4, 23)
work(scar * oakLive, {hand="detail", tool={kind="round", width=1.5, point=0.6}, pile=deadwood, load=1, pressure={0.6, 0.9}, coverage=4, fill=true, clip=true, angle=-math.pi/2, angle_jitter=0.3})
local r = brush{kind="round", width=1.8, point=1}
local fur = pile{{"bone black",1.5},{"raw umber",0.8},{"smalt",0.3}, medium=0.2}
r:load(fur, 0.8)
r:stroke({{235,264},{233,278},{232,293},{234,313},{237,334},{238,351}}, {pressure={0.6, 0.2}})
r:load(fur, 0.8)
r:stroke({{251,264},{253,281},{248,297},{246,316},{242,335},{238,351}}, {pressure={0.6, 0.2}})
-- grain in the dead wood
local g = brush{kind="rigger", width=0.8, point=1}
local grain = pile{{"raw umber",1},{"bone black",0.6},{"lead white",0.8}, medium=0.3}
for i = 1, 7 do
  g:load(grain, 0.5)
  local x = rand(237, 247)
  g:stroke({{x, 268}, {x - 1 + rand(-1, 1), 290}, {x - 3 + rand(-1, 1), 315}}, {pressure={0.4, 0.05}, clip=scar})
end
