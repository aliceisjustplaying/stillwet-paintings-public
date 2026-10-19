local f, E, cx, hz = 1000, 3.4, 500, 470
local function proj(X, Z) return cx + X*f/Z, hz + f*E/Z end
printShade = pile{{"lead white",3.2},{"pale smalt",2},{"smalt",0.55},{"raw umber",0.22},{"vermilion",0.03}, medium=0.1}
printDeep  = pile{{"lead white",2},{"pale smalt",2},{"smalt",0.8},{"raw umber",0.35},{"vermilion",0.03}, medium=0.1}
-- the shallow trench the legs plough between the steps
local tp, tw = {}, {}
for Z = 12.5, 43.2, 0.5 do
  local X = lerp(3.4, 2.87, (Z-13)/30.6)
  local x, y = proj(X, Z)
  tp[#tp+1] = {x, y}; tw[#tw+1] = 0.34*f/Z
end
trench = ribbon(tp, tw):roughen(0.8, 3, 171)
work(trench, {hand="detail", pile=printShade, coverage=1.6, pressure={0.35,0.6}, load=0.5, angle=0, tool={kind="round", width=2}})
-- the steps
local m = nil
local side = 1
local Z = 12.6
while Z < 43.4 do
  local X = lerp(3.4, 2.87, (Z-13)/30.6) + side*0.12 + randn(0, 0.02)
  local x, y = proj(X, Z)
  local w = 0.19*f/Z * rand(0.85, 1.15)
  local h = 0.34*f*E/(Z*Z) + 0.35
  local e = ellipse(x, y, w/2, h/2)
  m = m and (m + e) or e
  side = -side
  Z = Z + rand(0.62, 0.78)
end
stepsM = m:roughen(0.4, 2, 172)
work(stepsM, {hand="detail", pile=printDeep, coverage=3, pressure={0.5,0.8}, load=0.8, fill=true, angle=0, tool={kind="round", width=1.6}})
