cap2 = outline{{270,390,"c"},{276,376},{292,362},{318,354},{350,350.5},{382,352},{408,358},{426,368},{434,380,"c"},{430,392,"c"},{404,398},{360,396},{320,400},{288,399},{270,396,"c"}, char="broken", seed=71, closed=true, amount=0.5}
local cm = cap2:mask()
-- restate the slab as granite: dark body, then a broken stipple of lighter grains
work(cm, {hand="detail", pile=stoneDark, coverage=3.5, pressure={0.6,0.9}, load=1, fill=true, angle=-0.2, angle_jitter=0.7, length={3,8}})
stipple(cm * above({{260,386},{440,384}}), {pile=stoneMid, width=2.2, coverage=0.5, pressure={0.3,0.6}, cluster=0.6, feather=0.3})
local under = cm * below({{268,388},{320,391},{360,389},{400,391},{436,387}})
work(under, {hand="detail", pile=chamber, coverage=3, pressure={0.5,0.8}, load=0.9, fill=true, angle=0})
