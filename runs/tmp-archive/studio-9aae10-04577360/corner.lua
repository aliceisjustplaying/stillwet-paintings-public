local sh = poly({{545.5,458},{546.5,452},{550,448},{557,445.5},{568,444.5},{582,446},{582,452},{570,450.5},{560,451.5},{552,454},{548,458}}, true)
work(sh, {hand="detail", pile=capShade, coverage=4, fill=true, angle=0.4, load=1, pressure={0.6,0.9}, tool={kind="round", width=1.2, point=0.5}})
local tb = brush{kind="round", width=1.2, point=0.8}
tb:load(snowTop, 0.6)
tb:stroke({{547,452},{550,448.3},{557,445.8},{568,444.8},{580,445.8}}, {pressure={tb:pressure_for(0.7), tb:pressure_for(1.0)}})
