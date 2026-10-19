local L = {{505,577},{516,583},{500,598},{486,606},{476,622},{452,646},{436,668},{414,692},{398,720}}
local R = {{735,584},{716,589},{728,601},{748,618},{772,640},{800,664},{826,688},{850,720}}
local function offs(pts, dx) local o = {} for i,p in ipairs(pts) do local k = (p[2]-570)/150; o[i] = {p[1] + dx*(0.4+k), p[2] + 1} end return o end
local chan = -(mud4)
local bankRefl = pile{{"raw umber",1},{"bone black",0.3},{"cobalt blue",0.5},{"lead white",1.1}, medium=0.2}
local lip = pile{{"lead white",3},{"cobalt blue",0.45},{"red earth",0.3},{"raw umber",0.2}}
for _,side in ipairs({{L, 1}, {R, -1}}) do
  local pts, sgn = side[1], side[2]
  for j = 1, #pts-1 do
    local a, b2 = pts[j], pts[j+1]
    local k = (a[2]-570)/150
    local br = brush{kind="flat", width=2 + 5*k, stiffness=0.45}
    br:load(bankRefl, 0.55)
    br:stroke({{a[1] + sgn*(2+3*k), a[2]+1}, {b2[1] + sgn*(2+3*k), b2[2]+1}}, {pressure={0.5,0.4}, clip=chan})
  end
  for j = 2, #pts-1 do
    local a, b2 = pts[j], pts[j+1]
    local k = (a[2]-570)/150
    local br = brush{kind="round", width=1 + 2*k, point=0.3}
    br:load(lip, 0.45)
    br:stroke({{a[1] - sgn*(1.5+2*k), a[2]}, {b2[1] - sgn*(1.5+2*k), b2[2]}}, {pressure={0.4,0.3}, clip=mud4})
  end
end
