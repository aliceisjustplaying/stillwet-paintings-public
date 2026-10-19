local bcap = BOULDER:mask():grow(1) * above(function(x) return 641 + 7*math.sin((x-770)/130*math.pi)*0 + 3*math.sin(x/11) + math.abs(x-835)*0.12 end)
work(bcap, {hand="detail", pile=capShade, coverage=4, fill=true, angle=0.1, load=1, pressure={0.6,0.9}, tool={kind="round", width=2.5, point=0.4}})
local blit = BOULDER:mask():grow(1) * above(function(x) return 630 + math.abs(x-835)*0.1 + 1.5*math.sin(x/9) end)
work(blit, {hand="detail", pile=snowTop, coverage=3.5, fill=true, angle=0.1, load=1, pressure={0.5,0.85}, tool={kind="round", width=2.2, point=0.4}})
local b2cap = BOULDER2:mask():grow(0.8) * above(function(x) return 669 + 1.2*math.sin(x/5) end)
work(b2cap, {hand="detail", pile=capShade, coverage=4, fill=true, load=1, pressure={0.6,0.9}, tool={kind="round", width=1.6, point=0.5}})
-- drifts at the boulders' feet
local bd = poly({{760,684},{775,672},{790,675},{805,671},{822,676},{840,672},{858,677},{875,672},{893,676},{905,678},{920,676},{935,679},{952,681},{962,690},{755,692}}, true)
work(bd, {hand="detail", pile=snowG, coverage=4, fill=true, angle=0, load=1, pressure={0.6,0.9}, tool={kind="round", width=2.5, point=0.4}})
-- stump: snow on the broken top, and around the foot
local stop = poly({{53,628},{55,619},{60,622},{64,616},{69,620},{74,614},{78,619},{84,618},{86,627},{80,624},{72,626},{64,625},{58,627}}, true)
work(stop, {hand="detail", pile=capShade, coverage=4, fill=true, load=1, pressure={0.5,0.85}, tool={kind="round", width=1.5, point=0.5}})
local sd = poly({{36,660},{45,654},{56,652},{70,655},{84,653},{97,655},{108,660},{100,664},{40,664}}, true)
work(sd, {hand="detail", pile=snowG, coverage=4, fill=true, load=1, pressure={0.6,0.9}, tool={kind="round", width=2, point=0.4}})
-- roots: a thin lip of snow on each
local tb = brush{kind="round", width=1.4, point=0.8}
tb:load(snowTop, 0.7)
tb:stroke({{366,511},{374,508},{382,505.5},{386,501}}, {pressure={tb:pressure_for(1.0), tb:pressure_for(0.6)}})
tb:stroke({{421,501},{427,504},{436,506.5},{445,510}}, {pressure={tb:pressure_for(0.6), tb:pressure_for(1.0)}})
tb:stroke({{830,508},{836,506},{840,503}}, {pressure={tb:pressure_for(0.9), tb:pressure_for(0.6)}})
tb:stroke({{859,503},{865,505.5},{870,507.5}}, {pressure={tb:pressure_for(0.6), tb:pressure_for(0.9)}})
-- trail's dark far wall, restated near the oak
local path = {{385,560},{450,527},{497,502}}
local sh, wsK = {}, {}
for i,p in ipairs(path) do local s = clamp((p[2]-462)/252, 0.05, 1.2); sh[i] = {p[1]-3*s, p[2]-2.5*s}; wsK[i] = 9*s + 1 end
work(ribbon(sh, wsK):roughen(1.2, 7, 33) * rect(400,500,90,60), {hand="detail", pile=trailK, coverage=2.5, fill=true, angle=-0.5, tool={kind="filbert", width=2.5}, pressure={0.4,0.7}})
