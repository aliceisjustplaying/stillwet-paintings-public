-- wind scoops and her footprints, glazed as blue-gray hollows over the dry snow, with a lit lip on each
local function scoop(x, y, w) return ellipse(x, y + 1.5, w, w*0.3):roughen(0.6, 4, 161, 0.8) end
local hollows = (scoop(CROSS.x + 1, CROSS.foot - 7.5, 7) + scoop(FIG.x + 0.5, FIG.foot - 0.3, 13)) - (CROSSM + FIGM)
PRINTS = {}
local steps = 17
for i = 0, steps do
  local t = i / steps
  local s = lerp(1.0, 0.36, t)
  local x = lerp(372, FIG.x - 4, t^0.85) + 16*math.sin(t*2.6) + ((i % 2 == 0) and -3.4 or 3.4)*s + randn(0, 0.7*s)
  local y = lerp(714, FIG.foot + 3, t^0.8) + randn(0, 0.5*s)
  PRINTS[#PRINTS+1] = {x, y, s}
  hollows = hollows + ellipse(x, y, 3.2*s, 1.5*s):roughen(0.35*s, 3, 170 + i, 0.4*s)
end
glaze(hollows:blur(1.2), {color="#5f6a86", coats=0.26})
local pm = nil
for _, p in ipairs(PRINTS) do local e = ellipse(p[1], p[2] - 0.3*p[3], 2.4*p[3], 1*p[3]); pm = pm and (pm + e) or e end
glaze(pm:blur(0.4), {color="#4f5874", coats=0.3})
local lip = brush{kind="round", width=1.2, point=0.5}
lip:load("#c6c5ca", 0.6)
lip:stroke({{CROSS.x - 6, CROSS.foot - 7.2}, {CROSS.x - 1, CROSS.foot - 8.4}, {CROSS.x + 3, CROSS.foot - 8.2}, {CROSS.x + 8, CROSS.foot - 6.8}}, {pressure={0.1, 0.35, 0.1}, ramps={0.4, 0.4}})
for i, p in ipairs(PRINTS) do
  local x, y, s = p[1], p[2], p[3]
  if i % 4 == 1 then lip:reload("#cfcdd0", 0.7) end
  lip:stroke({{x - 2.6*s, y + 0.9*s}, {x, y + 1.6*s}, {x + 2.6*s, y + 0.8*s}}, {pressure={0.1, 0.25 + 0.35*s, 0.05}, ramps={0.3, 0.4}})
end
