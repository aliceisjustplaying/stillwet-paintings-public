local drift = poly({{352,516},{368,511},{380,508},{392,509},{403,507.5},{414,508.5},{426,507},{438,509},{452,512},{468,517},{472,545},{348,545}}, true)
work(drift, {hand="detail", pile=crest, coverage=4, fill=true, angle=0, load=1, pressure={0.6,0.9}, tool={kind="round", width=2.5, point=0.4}})
blend(drift:grow(4) - drift:shrink(4), {angle=0})
-- the right oak
local drift2 = poly({{820,508},{832,505},{842,506},{850,505},{860,506},{870,504},{882,507},{886,520},{818,520}}, true)
work(drift2, {hand="detail", pile=crest, coverage=4, fill=true, angle=0, load=1, pressure={0.6,0.9}, tool={kind="round", width=2, point=0.4}})
