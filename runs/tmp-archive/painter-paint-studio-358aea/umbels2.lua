local flowerP = pile{{"lead white",6},{"yellow ochre",0.12},{"green earth",0.1}, medium=0.05}
local flowerS = pile{{"lead white",2.5},{"green earth",0.6},{"pale smalt",0.4},{"raw umber",0.15}, medium=0.05}
local U = {{62,704,120,0.06},{92,706,96,-0.05},{35,708,80,0.12},{905,706,110,-0.07},{948,708,132,0.03},{870,710,70,0.1},{640,706,58,-0.04}}
for i,u in ipairs(U) do
  local x, y, h, lean = u[1], u[2], u[3], u[4]
  local tx, ty = x + lean*h, y - h
  local R = h*0.14
  -- the umbel is a flattish dome of small clusters
  local m = nil
  for k=1,9 do
    local a = -math.pi/2 + (k-5)*0.27
    local cx, cy = tx + math.cos(a)*R, ty + math.sin(a)*R*0.55 - R*0.15
    local e = ellipse(cx, cy, R*0.28, R*0.2)
    m = m and (m + e) or e
  end
  stipple(m, {pile=flowerS, width=1.5, coverage=1.5, pressure={0.4,0.7}, cluster=0.5})
  local top = m * mask(function(xx,yy) return yy < ty - R*0.35 and 1 or 0.4 end)
  stipple(top, {pile=flowerP, width=1.4, coverage=function(xx,yy) return 2.2*top:at(xx,yy) end, pressure={0.4,0.7}, cluster=0.5})
end
print(wait(0))
