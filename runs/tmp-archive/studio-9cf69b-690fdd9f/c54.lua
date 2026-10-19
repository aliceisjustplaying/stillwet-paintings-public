local crestL = {{-10,470},{20,465},{50,459},{85,450.5},{120,441.5},{150,434.5},{175,430},{200,426},{1010,426}}
local m = below(crestL) * above({{-10,482},{1010,482}}) * rect(-10,420,190,70) - oakThickM:grow(0.5)
work(m, {hand="detail", pile=moundShade, coverage=4, pressure={0.6,0.9}, load=1, fill=true, angle=-0.2, length={6,14}})
local r = brush{kind="round", width=2.4, point=1}
r:load(snowTop, 0.6)
r:stroke({{-5,469.5},{20,464.5},{50,458.5},{85,450},{120,441}}, {pressure={0.35,0.3}})
r:load(snowTop, 0.6)
r:stroke({{120,441},{150,434},{168,431}}, {pressure={0.3,0.1}})
