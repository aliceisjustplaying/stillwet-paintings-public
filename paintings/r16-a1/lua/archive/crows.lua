crowP = pile{{"bone black",1.2},{"raw umber",0.6},{"smalt",0.2}, medium=0.05}
function crow_fly(x, y, span, tilt, phase)
  local b = brush{kind="round", width=math.max(1.4, span*0.12), point=1}
  b:load(crowP, 0.9)
  local s = span/2
  local c, sn = math.cos(tilt), math.sin(tilt)
  local function P(u, v) return {x + u*c - v*sn, y + u*sn + v*c} end
  local up = phase  -- wing raise: positive = wings up
  -- left wing
  b:stroke({P(-0.5,0), P(-s*0.45, -s*0.28*up - s*0.05), P(-s, -s*0.12*up + s*0.12)}, {pressure={b:pressure_for(span*0.09), 0}, ramps={0.05,0.6}})
  b:stroke({P(0.5,0), P(s*0.45, -s*0.28*up - s*0.05), P(s, -s*0.12*up + s*0.12)}, {pressure={b:pressure_for(span*0.09), 0}, ramps={0.05,0.6}})
  -- body
  b:stroke({P(-span*0.02, -span*0.04), P(0, span*0.12)}, {pressure={b:pressure_for(span*0.1), b:pressure_for(span*0.06)}})
end
crow_fly(252, 92, 17, 0.1, 1)
crow_fly(575, 64, 14, -0.15, -0.4)
crow_fly(628, 104, 11, 0.2, 0.7)
crow_fly(190, 196, 9, -0.1, -0.6)
crow_fly(700, 55, 6, 0, 1)
crow_fly(725, 72, 5, 0.1, -0.5)
-- a crow perched on the dead top of the leader, facing right
local body = poly({{412,56},{413,49},{415,45},{418,44},{420,46},{420.5,50},{419,55},{416,58},{414,58}}, true)
local head = ellipse(419.5, 42.3, 2.3, 2.1)
local tail = poly({{413,55},{410,61},{412,62},{415,57}})
local beak = poly({{421,41.5},{424.5,42.5},{421.3,43.4}})
work(body + head + tail + beak, {hand="detail", pile=crowP, coverage=4, fill=true, load=1, tool={kind="round", width=1, point=1}, pressure={0.5,0.8}})
