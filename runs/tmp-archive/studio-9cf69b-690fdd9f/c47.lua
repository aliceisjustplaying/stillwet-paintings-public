local dTop = {{272,420},{282,416.5},{292,414},{305,415.5},{322,413},{340,416.5},{355,414},{370,415.5},{388,412},{404,414.5},{420,413},{434,417},{446,422},{460,420},{476,424},{486,430}}
driftDolmen = below(dTop) * above({{260,440},{500,440}}) * rect(262,400,230,45)
local tTop = {{140,452},{156,446},{168,440},{176,436.5},{186,438},{196,437.5},{206,435},{214,434},{224,438},{240,442},{252,441}}
driftTrunk = below(tTop) * above({{130,470},{260,470}}) * rect(135,425,125,45)
work(driftDolmen + driftTrunk, {hand="detail", pile=moundShade, coverage=4, pressure={0.6,0.9}, load=1, fill=true, angle=0, angle_jitter=0.2, length={4,12}})
-- the lit lip of each drift
local r = brush{kind="round", width=2.2, point=1}
r:load(snowTop, 0.6)
r:stroke(dTop, {pressure={0.35,0.25}})
r:load(snowTop, 0.6)
r:stroke(tTop, {pressure={0.35,0.25}})
