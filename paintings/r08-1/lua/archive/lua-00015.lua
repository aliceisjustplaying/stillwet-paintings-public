dry()
-- seat things in the snow: small drifts over the feet (opaque lead-white body, shaded like the bank)
local function drift(x, y, w, h, seed)
  return poly({{x - w, y + 1}, {x - w*0.55, y - h*0.55}, {x - w*0.1, y - h}, {x + w*0.35, y - h*0.8}, {x + w, y + 1}, {x + w*0.2, y + h*0.5}, {x - w*0.4, y + h*0.4}}, true):roughen(0.5, 5, seed, 0.4)
end
local cf = CROSS.foot
local drifts = drift(CROSS.x + 0.5, cf - 1, 9, 5, 151) + drift(FIG.x, FIG.foot + 0.5, 15, 2.6, 152)
work(drifts, {hand="detail", tool="round 1.5", length={3, 9}, coverage=4, medium=0.08, load=0.9, angle=0.05, color=snowcol, edge={soft=0.6, lost=0.4, period=10, seed=15}})
-- the far bank's snow drawn up round the oak's foot and the willows' feet
local far = drift(OAK.x - 1, OAK.foot + 2, 8, 2.2, 153)
for i, w in ipairs(WILLOWS) do far = far + drift(w[1], farbank(w[1]) + 5, 6*w[2], 1.8, 154 + i) end
work(far, {hand="detail", tool="round 1.2", length={2, 7}, coverage=4, medium=0.08, load=0.9, angle=0, color=function(x, y) return shift(sample(x, farbank(x) + 3, 1.5), -0.01, 0, -0.004) end, edge={soft=0.6, lost=0.4, period=10, seed=16}})
-- snow on the cross: the top of the upright and the upper edges of the arms
local lean, ct, by = CROSS.lean, CROSS.top, CROSS.beam
local sb = brush{kind="round", width=1.6, point=0.4}
sb:load("#dcd6d0", 0.9)
sb:stroke({{CROSS.x + lean - 2.5, ct + 0.6}, {CROSS.x + lean, ct - 0.8}, {CROSS.x + lean + 2.6, ct + 0.5}}, {pressure={0.8, 0.5}})
sb:stroke({{CROSS.x - 25.5 + lean*0.75, by - 1.3}, {CROSS.x - 14 + lean*0.75, by - 1.9}, {CROSS.x - 3.5 + lean*0.75, by - 2.1}}, {pressure={0.55, 0.7, 0.3}, ramps={0.1, 0.3}})
sb:stroke({{CROSS.x + 4.5 + lean*0.75, by - 2.4}, {CROSS.x + 16 + lean*0.75, by - 2.6}, {CROSS.x + 26.5 + lean*0.75, by - 2.8}}, {pressure={0.4, 0.7, 0.5}, ramps={0.2, 0.2}})
