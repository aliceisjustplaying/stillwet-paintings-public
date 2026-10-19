local T = table_top - lemons
local b = brush("filbert", 10)
for _, s in ipairs({{{555,640},{610,645},{670,642}}, {{560,650},{615,654},{672,650}}, {{690,592},{740,596},{792,590}}, {{700,600},{745,603},{795,598}}}) do
  b:reload(tTop2, 0.7)
  b:stroke(s, {pressure={0.6,0.6}, ramps={0.2,0.2}, orient="across", clip=T})
end
local function arc(cx, cy, rx, ry, a0, a1)
  local pts = {}
  for a = a0, a1, -0.12 do pts[#pts+1] = {cx + rx*math.cos(a), cy + ry*math.sin(a) + 1} end
  return pts
end
local cs = brush("filbert", 5)
cs:reload(kShadow, 0.7)
cs:stroke(arc(610, 592, 72, 46, 2.2, 0.5), {pressure={0.25,0.55}, ramps={0.4,0.15}, clip=T})
cs:reload(kShadow, 0.7)
cs:stroke({{700,588},{720,591},{745,589},{770,583},{778,576}}, {pressure={0.25,0.5}, ramps={0.4,0.2}, clip=T})
