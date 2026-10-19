-- the footpath: from the bottom edge up the rise, past the couple, over the crest
PATHPTS = {{505, 660}, {490, 636}, {462, 612}, {420, 592}, {375, 578}, {340, 570}, {310, 561}, {285, 545}, {270, 528}, {262, 512}, {258, 503}}
local ws = {46, 40, 32, 24, 18, 15, 12, 9, 7, 5, 3.5}
local pts, wd = {}, {}
-- densify
for i=1,#PATHPTS-1 do
  for s=0,9 do
    local t = s/10
    pts[#pts+1] = {lerp(PATHPTS[i][1], PATHPTS[i+1][1], t), lerp(PATHPTS[i][2], PATHPTS[i+1][2], t)}
    wd[#wd+1] = lerp(ws[i], ws[i+1], t) * (0.85 + 0.3*math.random())
  end
end
pts[#pts+1] = PATHPTS[#PATHPTS]; wd[#wd+1] = ws[#ws]
PATHM = ribbon(pts, wd):roughen(2, 10, 51) * below(function(x) return fg(x) + 2 end)
local pp = pile{{"yellow ochre", 1.2}, {"lead white", 0.7}, {"raw umber", 0.5}, {"red earth", 0.15}, {"green earth", 0.3}, medium=0.15}
work(PATHM, {hand="body", tool="filbert 5", pile=pp, angle=function(x, y) return -0.45 end, angle_jitter=0.3, length={10,30}, coverage=2, fill=true, edge="soft", seed=3701})
-- worn ruts, darker, and the lit upper-left edge
local rut = pile{{"raw umber", 1}, {"yellow ochre", 0.6}, {"green earth", 0.4}, {"lead white", 0.2}, medium=0.2}
local b = brush{kind="round", width=2.2, point=0.6}
b:load(rut, 0.5)
local r1, r2 = {}, {}
for i,p in ipairs(pts) do
  local w = wd[i]
  if i % 3 == 1 then
    r1[#r1+1] = {p[1] - 0.18*w, p[2] + 0.05*w}
    r2[#r2+1] = {p[1] + 0.2*w, p[2] + 0.08*w}
  end
end
b:stroke(r1, {pressure={0.5, 0.05}, ramps={0.05, 0.4}, shake=1})
b:load(rut, 0.5)
b:stroke(r2, {pressure={0.55, 0.05}, ramps={0.05, 0.4}, shake=1})
