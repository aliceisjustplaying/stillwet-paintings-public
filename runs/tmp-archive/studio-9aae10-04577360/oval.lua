snowG = pile{{"lead white",4.5},{"smalt",0.9},{"vermilion",0.06},{"raw umber",0.12},{"yellow ochre",0.05}, medium=0.1}
local ov = poly({{340,520},{360,514},{380,512},{430,511},{465,514},{480,522},{482,548},{340,550}}, true)
work(ov, {hand="body", pile=snowG, angle=-0.03, coverage=2.5, fill=true, length={20,50}, edge="soft", tool={kind="filbert", width=6}})
blend(ov:grow(3), {angle=0, clip=true})
-- trail through here: near-side light band and the dark far wall
local path = {{385,560},{450,527},{497,502}}
local c, wsP, sh, wsK = {}, {}, {}, {}
for i,p in ipairs(path) do local s = clamp((p[2]-462)/252, 0.05, 1.2); c[i] = p; wsP[i] = 20*s + 1.5; sh[i] = {p[1]-3*s, p[2]-2.5*s}; wsK[i] = 9*s + 1 end
local zone = rect(400, 500, 90, 60)
work(ribbon(c, wsP):roughen(1.2, 8, 31) * zone, {hand="detail", pile=trailP, coverage=2.5, fill=true, angle=-0.5, tool={kind="filbert", width=3}, pressure={0.4,0.7}})
