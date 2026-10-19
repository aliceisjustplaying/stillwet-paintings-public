clumps = nil
local cnt = 0
for i, p in ipairs(edgepts) do
  if math.random() < 0.5 and p[2] < 445 then
    local top = (p[2] < 200 and p[1] < 140)
    local base = top and -math.pi/2 or (-0.6 + rand(-0.5, 0.5))
    local rr = rand(7, 16)
    local d = rr * rand(0.4, 1.0)
    local cx, cy = p[1] + d*math.cos(base), p[2] + d*math.sin(base)
    local m = ellipse(cx, cy, rr*rand(0.9,1.4), rr*rand(0.6,0.9)):roughen(rr*0.35, rr*0.6, 100+i, 0)
    clumps = clumps and (clumps + m) or m
    cnt = cnt + 1
  end
end
print(cnt)
clumps = clumps - trees
stipple(clumps, {pile=pDark2, width=5, coverage=2.8, pressure={0.6,0.9}, dips={16,0.8,0.2}, drag={2.5, 0.8}, twist=0.5, cluster={0.3,5}, clip=clumps:grow(2)})
trees = trees + clumps
