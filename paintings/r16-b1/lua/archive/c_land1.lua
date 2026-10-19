hillN = noise{seed=7, octaves=3, period=160}
function hillY(x) return 424 - 8*math.sin(x/150+1) - 5*math.sin(x/53) + 4*hillN(x, 0) - 7*math.exp(-((x-880)/90)^2) end
function flatY(x) return 441 + 2*math.sin(x/70) end
function bankY(x) return 578 + 16*math.sin((x-120)/280) - 6*math.cos(x/90) + (x>300 and x<700 and 8 or 0) end
hillsM = below(function(x) return hillY(x) end) - below(function(x) return flatY(x) end)
landM = below(function(x) return flatY(x) end)
-- river (in perspective: thin bands near horizon)
riverTop = {{1000,470},{900,468},{800,466},{700,463},{600,460},{520,457},{450,455},{400,454}}
riverBot = {{400,456},{450,459},{520,464},{600,471},{700,478},{800,486},{900,494},{1000,500}}
local pts = {}
for _, p in ipairs(riverTop) do pts[#pts+1] = p end
for _, p in ipairs(riverBot) do pts[#pts+1] = p end
riverM = poly(pts, true)
bankM = below(function(x) return bankY(x) end)
meadowM = landM - bankM
hillP = pile{{"lead white", 5}, {"smalt", 2}, {"vermilion", 0.25}, {"raw umber", 0.3}, medium=0.2}
work(hillsM:grow(2), {hand="body", pile=hillP, angle=0, coverage=2.5, fill=true, clip=true, length={20,50}})
