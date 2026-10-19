local firstDead
for i, B in ipairs(branches) do if B.pts[1][1] == 309 and B.pts[1][2] == 262 then firstDead = i; break end end
print("firstDead", firstDead, #branches)
local cm = nil
local k = 0
for i = 1, firstDead - 1 do
  local B = branches[i]
  local e = B.pts[#B.pts]
  if e[2] > 225 and e[2] < 450 then
    k = k + 1
    local rx = rand(9, 20); local ry = rx * rand(0.5, 0.75)
    local el = ellipse(e[1] + rand(-3,3), e[2] - ry*0.3, rx, ry)
    cm = cm and (cm + el) or el
  end
end
-- larger hand-placed masses along the living boughs
local masses = {{175,300,42,24},{215,285,30,18},{140,330,26,16},{195,345,34,18},{250,330,26,16},
  {420,262,40,22},{455,300,30,16},{395,315,34,18},{350,300,22,14},{430,340,30,14},
  {185,405,36,16},{240,405,30,14},{150,395,22,12},{345,375,26,14},{300,360,18,12},{270,395,20,12}}
for _, m in ipairs(masses) do cm = cm + ellipse(m[1], m[2], m[3], m[4]) end
foliM = cm:roughen(6, 14, 11):roughen(2.5, 5, 12)
print(k)
