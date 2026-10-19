local sh = pile{{"raw umber",0.8},{"green earth",0.8},{"pale smalt",0.6},{"lead white",0.6},{"Prussian blue",0.1}, medium=0.1}
local m = (poly({{438,561},{452,561},{500,566},{510,569},{470,568},{440,564}}, true) + poly({{458,562},{483,562},{528,567},{536,570},{495,570},{462,566}}, true)) - FIGS
work(m, {hand="detail", pile=sh, tool={kind="round", width=1.2, point=0.5}, angle=0.08, length={3,10}, coverage=1.8, clip=true, fill=true, load=0.5})
-- the walking stick again, more pressure
local st = brush{kind="round", width=1.2, point=0.8}
st:load(pile{{"raw umber",1},{"bone black",0.5},{"lead white",0.2}, medium=0.08}, 0.7)
st:stroke({{457.5,520},{459,540},{460.5,561.5}}, {pressure={0.7,0.6}})
print(wait(0))
