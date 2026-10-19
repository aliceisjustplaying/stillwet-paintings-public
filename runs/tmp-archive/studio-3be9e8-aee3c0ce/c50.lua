inDark = pile{{"raw umber",1.4},{"bone black",0.4},{"lead white",0.5},{"green earth",0.4}}
inMid = pile{{"lead white",1.5},{"raw umber",0.9},{"yellow ochre",0.3},{"green earth",0.3}}
local cx, cy, rx, ry = 362, 191, 57, 11
local function E(a, sx, sy) return {cx + (rx*(sx or 1))*math.cos(a), cy + (ry*(sy or 1))*math.sin(a)} end
opening = ellipse(cx, cy, rx-3, ry-2)
local b = brush("filbert", 5)
-- interior: dark left, mid right
for i = 0, 5 do
  local yy = cy - 7 + i * 2.6
  local half = (rx-4) * math.sqrt(math.max(0, 1 - ((yy-cy)/(ry-2))^2))
  b:reload(inDark, 0.7)
  b:stroke({{cx - half, yy}, {cx + half*0.35, yy}}, {pressure={0.5,0.5}, ramps={0.1,0.2}, clip=opening})
  b:reload(inMid, 0.7)
  b:stroke({{cx + half*0.25, yy}, {cx + half, yy}}, {pressure={0.5,0.5}, ramps={0.2,0.1}, clip=opening})
end
-- front rim: light, lit left
local r = brush{kind="round", width=4, point=0.3}
local pts = {}
for a = math.pi*0.98, math.pi*0.2, -0.08 do pts[#pts+1] = E(a, 1.0, 1.15) end
r:reload(jp[1], 0.8)
r:stroke({pts[1],pts[2],pts[3],pts[4],pts[5],pts[6]}, {pressure={0.8,0.7}, ramps={0.1,0.2}})
r:reload(jp[3], 0.8)
local rest = {}
for i = 6, #pts do rest[#rest+1] = pts[i] end
r:stroke(rest, {pressure={0.7,0.6}, ramps={0.1,0.3}})
-- back rim: thin line
local back = {}
for a = math.pi*1.05, math.pi*1.95, 0.08 do back[#back+1] = E(a, 1.0, 1.1) end
local h = brush{kind="round", width=3, point=0.5}
h:reload(jp[2], 0.6)
h:stroke(back, {pressure={0.5,0.4}, ramps={0.2,0.3}})
-- spout lip
local sp = brush("filbert", 6)
sp:reload(jp[1], 0.8)
sp:stroke({{306,188},{290,182},{274,176},{262,174}}, {pressure={0.7,0.3}, ramps={0.1,0.4}})
sp:reload(jp[4], 0.6)
sp:stroke({{305,198},{290,192},{276,184}}, {pressure={0.5,0.2}, ramps={0.1,0.5}})
