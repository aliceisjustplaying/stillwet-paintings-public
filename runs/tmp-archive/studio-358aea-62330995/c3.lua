-- a white stork walking in the meadow between the first and second pollards, foraging to the left
local body = poly({{176,500},{178,497.2},{183,496.4},{190,497.5},{195,500.2},{197.5,503},{193,503.6},{186,505},{180,504.4},{176.5,502.5}}, true)
local neck = poly({{176.5,500.5},{175.2,496},{173.2,491.5},{172.6,489.2},{174.4,488.4},{175.8,490.6},{178,495},{180,498}}, true)
local head = ellipse(173.6, 489.1, 1.7, 1.35)
STORK_W = body + neck + head
local white = pile{{"lead white",4},{"yellow ochre",0.25},{"pale smalt",0.05}, medium=0.05}
local whiteS = pile{{"lead white",2.2},{"raw umber",0.35},{"pale smalt",0.5},{"yellow ochre",0.15}, medium=0.05}
work(STORK_W, {hand="detail", pile=white, tool={kind="round", width=0.9, point=0.6}, angle=0.1, length={2,5}, coverage=4, clip=true, fill=true, edge="found", load=0.9})
-- shade on the belly and under the neck
local shade = STORK_W * mask(function(x,y) return smoothstep(500.5, 504, y) end)
work(shade, {hand="detail", pile=whiteS, tool={kind="round", width=0.8, point=0.6}, angle=0.1, length={2,4}, coverage=1.4, clip=true, threshold=0.3})
print(wait(0))
