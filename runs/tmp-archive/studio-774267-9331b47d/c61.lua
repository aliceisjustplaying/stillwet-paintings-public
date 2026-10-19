local s1 = body.ellipsoid({815, 606, 0}, {66, 38, 44}):turn({815, 606, 0}, 0, 0, -0.08):rough(4, 50, 3)
local s2 = body.ellipsoid({905, 622, 0}, {24, 14, 18}):rough(2, 30, 4)
local s3 = body.ellipsoid({735, 626, 0}, {15, 9, 12}):rough(1.5, 20, 5)
local s4 = body.ellipsoid({960, 612, 0}, {10, 6, 8}):rough(1, 15, 6)
BF = form{{s1}, {s2}, {s3}, {s4}, light={from={-1, -0.55}, front=0.45, ambient=0.18}}
local ground = function(x) return 620 + 0.06*(x - 815) + 3*math.sin(x/17) end
local cut = below(function(x) return 628 + 3*math.sin(x/13) end)
local sil = BF:silhouette{parts={1,2,3,4}} - cut - below(function(x) return x < 850 and 618 + 3*math.sin(x/11) or 634 end)
BOULD = sil
-- cast shadow on the grass to the right
local cs = pile{{"green earth", 1.2}, {"raw umber", 0.9}, {"Prussian blue", 0.1}, {"bone black", 0.1}, medium=0.3}
local shad = (poly({{840, 612}, {900, 590}, {960, 596}, {1010, 610}, {1010, 632}, {860, 630}}, true) + poly({{920, 626}, {950, 618}, {990, 624}, {960, 632}}, true)) - sil
work(shad:soften(2), {hand="body", tool="filbert 5", pile=cs, angle=0.05, length={15,40}, coverage=1.8, fill=true, edge="soft", seed=6101})
local dk = pile{{"raw umber", 0.6}, {"pale smalt", 0.8}, {"bone black", 0.15}, {"lead white", 0.4}, medium=0.08}
local md = pile{{"lead white", 1}, {"raw umber", 0.5}, {"pale smalt", 0.45}, {"yellow ochre", 0.2}, medium=0.08}
local lt = pile{{"lead white", 2}, {"yellow ochre", 0.4}, {"raw umber", 0.2}, {"red earth", 0.05}, medium=0.08}
work(sil, {hand="body", tool="filbert 4", pile=dk, angle=BF:field("across"), length={6,16}, coverage=2.5, fill=true, clip=true, seed=6102})
local litm = BF:lit{parts={1,2,3,4}, soft=0.15} * sil
work(litm, {hand="body", tool="filbert 3", pile=md, angle=BF:field("across"), length={5,14}, coverage=2.2, fill=true, clip=true, seed=6103})
local hi = mask(function(x, y) return (BF:value(x, y) > 0.72) and 1 or 0 end) * sil
work(hi, {hand="detail", tool={kind="round", width=2, point=0.4}, pile=lt, angle=BF:field("across"), coverage=1.8, fill=true, seed=6104})
print(BF:value(790, 590), BF:value(850, 610), sil:area())
