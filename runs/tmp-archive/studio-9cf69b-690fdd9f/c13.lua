farWood2 = pile{{"lead white",2.5},{"pale smalt",2},{"smalt",0.6},{"raw umber",0.45},{"vermilion",0.06}, medium=0.2}
local clumps = {{640,700,449},{712,760,456},{830,905,447},{930,975,455},{600,630,458}}
local M = nil
for i,c in ipairs(clumps) do
  local x0,x1,top = c[1],c[2],c[3]
  local pts = {}
  local nn = noise{seed=20+i, period=6, octaves=2}
  for x = x0, x1, 2 do
    local t = (x-x0)/(x1-x0)
    local hgt = (472-top) * math.sin(math.pi*t)^0.5
    pts[#pts+1] = {x, 472 - hgt - 2.5*math.abs(nn(x,0))}
  end
  local m = below(pts) * rect(x0,430,x1-x0,46)
  M = M and (M + m) or m
end
woodClumps = M
work(M, {hand="detail", pile=farWood2, angle=-1.4, coverage=2.5, pressure={0.4,0.7}, load=0.7, length={3,8}})
stipple(M:rim(3,1), {pile=farWood2, width=1.6, coverage=1.2, pressure={0.25,0.5}, feather=0.6, cluster=0.5})
