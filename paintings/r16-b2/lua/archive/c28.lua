local CL = nil
for _,c in ipairs({{250,24,9},{870,32,10},{930,22,8},{352,14,11},{662,20,10}}) do
  local n = math.floor(c[2]/1.8)
  for i=1,n do
    local x = c[1] + rand(-c[2], c[2])
    local f = 1 - 0.55*(math.abs(x-c[1])/c[2])^1.5
    local hh = c[3] * (0.65 + 0.45*math.random()) * f
    local rx = rand(2,3.8)
    local e = ellipse(x, 446 - hh + rx*0.9, rx, rx*1.05) + rect(x-rx*0.8, 446-hh+rx, rx*1.6, hh-rx+1)
    CL = CL and (CL + e) or e
  end
end
DCL2 = CL:roughen(0.6, 3, 281) - TOWN2
work(DCL2, {hand="detail", pile=treep, tool={kind="round", width=1.3, point=0.5}, angle=math.pi/2, coverage=4, fill=true, length={2,6}, seed=282})
