-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"lead white", 10}, {"bone black", 0.2}}, texture=0.3, um=120}, {apply="brush", pile={{"lead white", 6}, {"red earth", 1.2}, {"raw umber", 1}, {"yellow ochre", 0.6}}, texture=0.5, um=40}}, linen={16, 14}, seed=4471, size=900}

--@ chunk 2
fl_halo = pile{{"lead white", 3}, {"Naples yellow", 1}, {"cadmium yellow", 0.6}, name="fl_halo"}
sk_patch = pile{{"lead white", 2.5}, {"Naples yellow", 0.8}, {"orange chrome", 0.6}, {"yellow ochre", 0.3}, {"vermilion", 0.11}, {"raw umber", 0.03}, name="sk_patch"}
cw_dark = pile{{"bone black", 1}, {"raw umber", 1}, {"ultramarine blue", 0.5}, name="cw_dark"}
cw_coat_dk = pile{{"raw umber", 1}, {"bone black", 0.35}, {"ultramarine blue", 0.45}, {"burnt sienna", 0.4}, {"lead white", 0.05}, name="cw_coat_dk"}
fc_dk2 = pile{{"raw umber", 1}, {"bone black", 0.22}, {"burnt sienna", 0.3}, {"ultramarine blue", 0.3}, {"rose madder", 0.08}, name="fc_dk2"}
fc_lt2 = pile{{"Naples yellow", 1}, {"orange chrome", 0.55}, {"vermilion", 0.25}, {"burnt sienna", 0.15}, {"lead white", 0.2}, name="fc_lt2"}
fc_hot = pile{{"Naples yellow", 1}, {"lead white", 0.7}, {"orange chrome", 0.35}, {"cadmium yellow", 0.2}, name="fc_hot"}
cb_gun2 = ribbon({{452,333},{470,332},{488,331}}, {5.5,5,5}) + ellipse(457,336,8,6) + poly({{446,330},{452,327},{455,332}}, true)
cb_hand2 = poly({{426,337},{438,333},{450,335},{454,342},{452,350},{446,356},{438,358},{430,356},{426,348}}, true)
cb_trig = ribbon({{446,342},{454,344},{458,341}}, 3)
cb_sleeve = ribbon({{268,320},{300,326},{340,334},{380,340},{410,344},{428,346}}, {38,33,29,27,25,22})
local bg = rect(380, 300, 130, 80)
work(bg, {hand="body", tool={kind="filbert", width=6, stiffness=0.35},
  piles={{fl_halo, function(x,y) return smoothstep(430, 470, x) end}, {sk_patch, function(x,y) return 1 - smoothstep(430, 470, x) end}},
  coverage=2.2, fill=true, clip=bg, seed=11})
local sl = cb_sleeve * rect(380, 300, 60, 80) - cb_hand2
work(sl, {hand="detail", tool={kind="round", width=2.5}, pile=cw_coat_dk, coverage=3, clip=sl, angle=0.13, seed=12})
work(cb_hand2, {hand="detail", tool={kind="round", width=2.5}, pile=fc_dk2, coverage=3, clip=cb_hand2, seed=13})
local gun = cb_gun2 + cb_trig
work(gun - cb_hand2, {hand="detail", tool={kind="round", width=1.5}, pile=cw_dark, coverage=3, clip=gun - cb_hand2, seed=14})
wait(10*24*60)
local hand = cb_hand2
local rb = brush{kind="round", width=3, point=0.8, stiffness=0.55}
local function g(p, pts, load, clipm) rb:reload(p, load or 0.7) rb:gesture(pts, {wobble=0.15, clip=clipm or hand}) end
g(fc_lt2, {{448,337,0.5},{452,341,0.7},{453,346,0.7},{451,351,0.6},{447,356,0.4}}, 0.8)
g(fc_hot, {{451,341,0.4},{452,346,0.45}}, 0.7)
g(fc_lt2, {{432,337,0.35},{439,334,0.55},{446,334,0.5}}, 0.6)
wait(14*24*60)
print(drying(440,345), drying(440,365), drying(470,332))

--@ chunk 3
zb_flash = pile{{"orange chrome", 1}, {"Naples yellow", 0.6}, {"burnt sienna", 0.3}, {"lead white", 0.2}, name="zb_flash"}
gun_glint = pile{{"lead white", 1}, {"Naples yellow", 0.6}, {"cadmium yellow", 0.25}, name="gun_glint"}
grip_wood = pile{{"burnt sienna", 1}, {"raw umber", 0.8}, {"bone black", 0.35}, {"Indian red", 0.2}, name="grip_wood"}
grip_lit = mix{{grip_wood, 0.5}, {zb_flash, 0.5}, name="grip_lit"}
steel_lit = mix{{cw_dark, 0.5}, {zb_flash, 0.5}, name="steel_lit"}
-- grip butt poking out below the fist, angled back
local butt = poly({{446,353},{448,357},{447,361},{443,364.5},{437,365},{433,362.5},{433,358},{437,355}}, true)
local bm = butt - cb_hand2:shrink(0.5)
work(bm, {hand="detail", tool={kind="round", width=1.6}, pile=grip_wood, coverage=3.5, clip=bm, angle=1.2, seed=21})
-- butt cap: dark steel line along the bottom
local rb = brush{kind="round", width=1.6, point=0.85, stiffness=0.55}
local function s(p, pts, load, clipm) rb:reload(p, load or 0.7) rb:gesture(pts, {wobble=0.05, clip=clipm}) end
s(cw_dark, {{434,362.5,0.6},{438,365,0.7},{443,364.6,0.6},{446.5,361.5,0.4}}, 0.8)
-- trigger guard loop in front of the fist
s(cw_dark, {{451,338.5,0.55},{455.5,340,0.65},{457.5,343.5,0.65},{455.5,346.5,0.6},{451.5,346.5,0.45}}, 0.8)
-- ejector housing under barrel
s(cw_dark, {{466,333.8,0.55},{474,333.4,0.55},{482,333,0.45},{484,333,0.2}}, 0.8)
print(drying(440,360))
