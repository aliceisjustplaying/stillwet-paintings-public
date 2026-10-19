-- wall colour cut back along the lit contour
local outside = (wall - (jugBody + spout)) * rect(0, 150, 360, 371)
local b = brush("filbert", 7)
local seg = {}
for y = 205, 515, 6 do seg[#seg+1] = {edgeX(jugL, y) - 6, y} end
local i = 1
while i < #seg do
  local j = math.min(#seg, i + 6)
  local pts = {}
  for k = i, j do pts[#pts+1] = seg[k] end
  b:reload(bgOlive, 0.6)
  b:stroke(pts, {pressure={0.55,0.5}, ramps={0.15,0.15}, orient="across", clip=outside})
  i = j
end
-- jug shadow side: broken strokes, low load, no blending
local s = brush("filbert", 9)
strips(0.64, 0.9, jp[5], s, 212, 604, 5, {load=0.45, pressure={0.5,0.4}})
strips(0.7, 0.86, jDark, s, 240, 600, 3, {load=0.35, pressure={0.45,0.35}})
strips(0.53, 0.65, jp[4], s, 205, 604, 3, {load=0.4, pressure={0.45,0.35}})
