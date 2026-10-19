skyfix = pile{{"lead white",7},{"chrome yellow",0.35},{"yellow ochre",0.3},{"vermilion",0.06}, medium=0.25}
local bellish = poly({{462,370},{463,366},{466,363},{468,360},{468.6,357},{471,355.5},{473.4,357},{474,360},{476,363},{479,366},{480,370}}, true) + rect(462,369,18,11) + rect(468.8,349,4.4,8)
GHOST = ellipse(471,363,8.5,9.5) - bellish:grow(0.4)
work(GHOST, {hand="detail", pile=skyfix, tool={kind="round", width=1.5}, angle=0, coverage=4, fill=true, length={3,8}, seed=251})
treep = pile{{"smalt",1.5},{"raw umber",1.6},{"green earth",1.2},{"bone black",0.2},{"lead white",1.3}, medium=0.25}
work(TTREES, {hand="detail", pile=treep, angle=0, coverage=4, fill=true, length={3,8}, seed=252})
local SAILS = nil
for _,m in ipairs({{712,420,0.35},{794.5,423,0.85}}) do
  local L = (m[1]==712) and 15 or 13
  for k=0,3 do
    local a = m[3] + k*math.pi/2
    local dx,dy = math.cos(a), math.sin(a); local px,py = -dy, dx
    local q = poly({{m[1]+2.5*dx, m[2]+2.5*dy},{m[1]+L*dx, m[2]+L*dy},{m[1]+L*dx+2.6*px, m[2]+L*dy+2.6*py},{m[1]+4.5*dx+2.6*px, m[2]+4.5*dy+2.6*py}})
    q = q + ribbon({{m[1],m[2]},{m[1]+L*dx, m[2]+L*dy}}, 0.8)
    SAILS = SAILS and (SAILS + q) or q
  end
end
millp = pile{{"smalt",2},{"raw umber",1.4},{"bone black",0.2},{"lead white",1.6},{"vermilion",0.1}, medium=0.25}
work(MILLB + SAILS, {hand="detail", pile=millp, tool={kind="round", width=1.2, point=0.5}, angle=math.pi/2, coverage=4, fill=true, length={2,6}, seed=253})
