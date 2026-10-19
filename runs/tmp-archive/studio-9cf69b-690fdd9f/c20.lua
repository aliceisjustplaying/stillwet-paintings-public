local n0 = #oak.thick
-- two great low limbs, elbowed, as an old field oak carries them
oak.thick[#oak.thick+1] = {pts={{182,352},{156,344},{128,333},{104,318},{88,302}}, ws={17,14,12,10,9}}
oak.thick[#oak.thick+1] = {pts={{208,348},{236,340},{266,330},{296,316},{322,300}}, ws={16,13,11,10,9}}
growLimb(88,302, -2.3, 90, 8, 3, 0.05)
growLimb(104,318, math.pi+0.1, 70, 6, 3, 0.02)
growLimb(322,300, -0.7, 90, 8, 3, 0.05)
growLimb(266,330, -0.05, 90, 6, 3, 0.02)
local m = ribbon({{190,450},{190,420},{192,390},{194,360},{197,336}}, {52,44,40,39,44})
m = m + poly({{150,456},{166,440},{176,420},{210,420},{220,440},{238,458}}, true)
for i = n0+1, #oak.thick do local s = oak.thick[i]; m = m + ribbon(s.pts, s.ws) end
m = m:roughen(1.0, 7, 9)
oakThickM = oakThickM + m
work(m, {hand="detail", pile=barkDark, coverage=3.5, pressure={0.6,0.9}, load=1, fill=true, angle=-math.pi/2, angle_jitter=0.5})
print(#oak.thick, #oak.thin)
