local firstDead = 173
local sh = nil
for i = 1, firstDead - 1 do
  local B = branches[i]
  local e = B.pts[#B.pts]
  if e[2] > 225 and e[2] < 450 then
    local rx = 9 + (i * 7919 % 11)
    local el = ellipse(e[1], e[2] + 4, rx, rx * 0.55)
    sh = sh and (sh + el) or el
  end
end
local masses = {{175,300,42,24},{215,285,30,18},{140,330,26,16},{195,345,34,18},{250,330,26,16},
  {420,262,40,22},{455,300,30,16},{395,315,34,18},{350,300,22,14},{430,340,30,14},
  {185,405,36,16},{240,405,30,14},{150,395,22,12},{345,375,26,14},{300,360,18,12},{270,395,20,12}}
for _, m in ipairs(masses) do sh = sh + ellipse(m[1], m[2] + 7, m[3] * 0.95, m[4] * 0.9) end
foliTops = (foliM - sh:roughen(3, 8, 77)) - oakM2
foliLight = pile{{"green earth", 2}, {"yellow ochre", 1}, {"lead white", 0.9}, {"raw umber", 1}, {"pale smalt", 0.3}, medium=0.1}
stipple(foliTops, {pile=foliLight, width=2.6, coverage=0.9, cluster={0.5, 4}, pressure={0.35, 0.75}, feather=0.4, dips={20, 0.6, 0}})
print(foliTops:area())
