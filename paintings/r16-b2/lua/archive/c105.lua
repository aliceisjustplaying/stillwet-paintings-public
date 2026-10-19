local crowns = {{334,426,12,17},{350,431,10,13},{364,436,8,9},{322,424,7,12}}
local C = nil
for _,c in ipairs(crowns) do
  for k=1,55 do
    local a = rand(0, 2*math.pi); local r = math.sqrt(rand(0,1))
    local x = c[1] + math.cos(a)*r*c[3]; local y = c[2] + math.sin(a)*r*c[4]
    local e = ellipse(x, y, rand(1.5,3.2), rand(1.2,2.6))
    C = C and C + e or e
  end
end
C = C * above(function(x) return 446 end) - TOWN2:grow(0.4)
work(C, {hand="detail", pile=gdeep, tool={kind="round", width=1.1, point=0.6}, angle=-1.2, angle_jitter=1.0, coverage=4, fill=true, length={1.5,4}, seed=1051})
