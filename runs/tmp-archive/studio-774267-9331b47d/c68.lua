local sil = BOULD
local shade = sil - BF:lit{parts={1,2,3,4}, soft=0.1}
local deep = pile{{"raw umber", 1}, {"smalt", 0.5}, {"bone black", 0.3}, {"lead white", 0.15}, medium=0.2}
local midg = pile{{"raw umber", 0.7}, {"pale smalt", 0.7}, {"lead white", 0.6}, {"bone black", 0.08}, {"yellow ochre", 0.15}, medium=0.15}
-- overall mid-tone over everything but the brightest crown
local notop = sil * mask(function(x, y) return (BF:value(x, y) < 0.66) and 1 or 0 end)
work(notop, {hand="scumble", tool="filbert 3", pile=midg, angle=BF:field("across"), length={5,12}, coverage=1.6, clip=true, seed=6801})
work(shade, {hand="body", tool="filbert 3", pile=deep, angle=BF:field("across"), length={5,14}, coverage=2, clip=true, fill=true, seed=6802})
-- granite speckle and lichen
local spk = pile{{"bone black", 0.6}, {"raw umber", 0.6}, {"lead white", 0.2}, medium=0.1}
local wspk = pile{{"lead white", 2}, {"yellow ochre", 0.15}, medium=0.1}
local lich = pile{{"yellow ochre", 1}, {"lead white", 0.8}, {"green earth", 0.5}, {"chrome yellow", 0.08}, medium=0.1}
stipple(sil:shrink(1), {pile=spk, width=0.9, coverage=0.25, cluster=0.3, seed=6803})
stipple(BF:lit{parts={1,2,3,4}, soft=0.1} * sil:shrink(1.5), {pile=wspk, width=0.8, coverage=0.2, cluster=0.3, seed=6804})
local ln = noise{seed=44, octaves=3, period=14}
stipple(sil:shrink(2) * mask(function(x, y) return (ln(x, y) > 0.3) and 1 or 0 end), {pile=lich, width=1.1, coverage=0.8, cluster=0.6, seed=6805})
-- a crack across the big stone
local cr = brush{kind="round", width=0.8, point=1}
cr:load(pile{{"bone black", 0.8}, {"raw umber", 0.5}, medium=0.1}, 0.4)
cr:stroke({{790, 578}, {796, 590}, {793, 602}, {801, 614}}, {pressure={0.5, 0.1}, shake=1})
cr:stroke({{825, 572}, {829, 580}}, {pressure={0.4, 0.05}, shake=1})
