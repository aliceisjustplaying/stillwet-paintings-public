local lip = {{437,381.5},{432,381},{423,378},{414,374.5},{405,372.5},{398,376},{390,373.5},{378,373},{370,375.5},{362,373.5},{350,374.5},{338,374},{331,376.5},{322,374.5},{311,375.5},{303,378.5},{296,377},{288,380},{280,382},{272,386.5}}
local upper = {{272,383},{285,372},{300,366},{330,362},{360,361},{390,362},{414,366},{430,373},{437,379}}
local pts = {}
for _,p in ipairs(upper) do pts[#pts+1] = p end
for _,p in ipairs(lip) do pts[#pts+1] = {p[1], p[2] + randn(0, 0.4)} end
local m = poly(pts, true):roughen(0.5, 2.5, 161)
work(m, {hand="detail", pile=snowSide2, coverage=4.5, pressure={0.7,1.0}, load=1, fill=true, angle=0, tool={kind="round", width=1.6}})
-- broken shadow under the lip
local r = brush{kind="round", width=2, point=1}
r:load(chamber, 0.5)
local i = 1
while i < #lip do
  if math.random() < 0.55 then
    local a, b = lip[i], lip[i+1]
    r:stroke({{a[1], a[2] + 1.4}, {b[1], b[2] + 1.4}}, {pressure={0.28, 0.12}})
  end
  i = i + 1
end
