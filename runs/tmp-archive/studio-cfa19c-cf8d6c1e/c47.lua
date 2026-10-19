-- distant groves on the horizon
local groves = {{8,50,424},{92,130,425},{165,250,422},{395,445,427},{455,470,429},{870,905,426},{930,990,425}}
local G = nil
for i,g in ipairs(groves) do
  local x0,x1,top = g[1],g[2],g[3]
  local pts = {{x0,436}}
  local n = math.max(3, math.floor((x1-x0)/7))
  for k=0,n do
    local x = lerp(x0,x1,k/n)
    local bump = math.sin(k/n*math.pi)^0.6
    pts[#pts+1] = {x, 436 - (436-top)*bump - rand(0,2.5)}
  end
  pts[#pts+1] = {x1,436}
  local m = poly(pts, true)
  G = G and (G + m) or m
end
grovesM = G
fg = pile{{"lead white",2},{"smalt",1.5},{"green earth",1.5},{"raw umber",0.6}, medium=0.08}
work(grovesM, {hand="detail", pile=fg, tool={kind="round", width=1.8, point=0.5}, angle=math.pi/2, coverage=3, fill=true, seed=301})
