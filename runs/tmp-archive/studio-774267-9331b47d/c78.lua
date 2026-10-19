local sil = BOULD
local ang = BF:field("across")
local base = pile{{"raw umber", 0.8}, {"pale smalt", 0.8}, {"bone black", 0.25}, {"lead white", 0.5}, {"yellow ochre", 0.1}, medium=0.08}
local dark = pile{{"raw umber", 1}, {"smalt", 0.4}, {"bone black", 0.4}, {"lead white", 0.12}, medium=0.08}
local lit = pile{{"lead white", 1.2}, {"raw umber", 0.5}, {"yellow ochre", 0.3}, {"pale smalt", 0.2}, medium=0.08}
local hi = pile{{"lead white", 1.8}, {"yellow ochre", 0.4}, {"raw umber", 0.15}, {"red earth", 0.05}, medium=0.08}
work(sil, {hand="body", tool="filbert 3", pile=base, angle=ang, length={5,14}, coverage=3, fill=true, clip=true, seed=7801})
local sh = sil * mask(function(x, y) return (BF:value(x, y) < 0.4) and 1 or 0 end)
work(sh, {hand="body", tool="filbert 3", pile=dark, angle=ang, length={5,14}, coverage=2.5, fill=true, clip=true, seed=7802})
local lm = sil * mask(function(x, y) return (BF:value(x, y) > 0.6) and 1 or 0 end)
work(lm, {hand="scumble", tool="filbert 3", pile=lit, angle=ang, length={4,10}, coverage=1.6, clip=true, seed=7803})
local hm = sil * mask(function(x, y) return (BF:value(x, y) > 0.8) and 1 or 0 end)
work(hm, {hand="detail", tool={kind="round", width=1.4, point=0.4}, pile=hi, angle=ang, coverage=1.2, seed=7804})
print(sh:area(), lm:area(), hm:area())
