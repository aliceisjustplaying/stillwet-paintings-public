-- deepen the oak's trunk and big boughs toward the evening silhouette; cooler and darker on the left of the trunk
barkDark = pile{{"bone black",1.2},{"raw umber",1},{"smalt",0.6},{"lead white",0.1}, medium=0.45}
local thick = (oakLive - footM:grow(0)) * above(function(x) return 441 end)
work(thick, {hand="detail", tool={kind="round", width=3, point=0.5}, pile=barkDark, load=0.9, pressure={0.5, 0.8}, coverage=2.5, fill=true, clip=true,
   angle=-math.pi/2, angle_jitter=0.4,
   load_at=function(x, y) return 0.5 + 0.4 * smoothstep(250, 210, x) end})
-- fissured bark on the trunk: long wavy dark furrows, and pale ridges catching the sky on the right flank
local r = brush{kind="round", width=1.6, point=1}
local fur = pile{{"bone black",1.5},{"raw umber",0.8},{"smalt",0.3}, medium=0.2}
local ridge = pile{{"lead white",2},{"raw umber",1},{"bone black",0.4},{"smalt",0.4}, medium=0.2}
for i = 1, 26 do
  local x0 = rand(210, 266)
  local y0 = rand(300, 440)
  local L = rand(14, 40)
  if oakLive:at(x0, y0) > 0.5 then
    local pts = {}
    for k = 0, 4 do pts[#pts+1] = {x0 + 1.5 * math.sin(k * 1.3 + i) + (k * 0.3), y0 - L * k / 4} end
    r:load(fur, 0.7)
    r:stroke(pts, {pressure={0.55, 0.2}, ramps={0.2, 0.3}, clip=oakLive})
  end
end
for i = 1, 16 do
  local x0 = rand(246, 268)
  local y0 = rand(305, 438)
  local L = rand(8, 22)
  if oakLive:at(x0, y0) > 0.5 and oakLive:at(x0 + 3, y0) < 0.5 then x0 = x0 - 3 end
  if oakLive:at(x0, y0) > 0.5 then
    r:load(ridge, 0.5)
    r:stroke({{x0, y0}, {x0 + 0.8, y0 - L / 2}, {x0 + 0.3, y0 - L}}, {pressure={0.35, 0.1}, ramps={0.3, 0.4}, clip=oakLive})
  end
end
