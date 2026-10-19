-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"lead white", 10}, {"bone black", 0.2}}, texture=0.3, um=120}, {apply="brush", pile={{"lead white", 6}, {"red earth", 1.2}, {"raw umber", 1}, {"yellow ochre", 0.6}}, texture=0.5, um=40}}, linen={16, 14}, seed=4471, size=900}

--@ chunk 2
cw_dark = pile{{"bone black",1},{"raw umber",1},{"ultramarine blue",0.5}, name="cw_dark"}
fg_dark = pile{{"raw umber",1},{"bone black",0.45},{"ultramarine blue",0.55},{"rose madder",0.15},{"lead white",0.08}, name="fg_dark"}
ld_near2 = pile{{"raw umber",1},{"bone black",0.4},{"ultramarine blue",0.5},{"burnt sienna",0.35},{"rose madder",0.1}, name="ld_near2"}
gnd_fg = pile{{"raw umber",1},{"ultramarine blue",0.55},{"rose madder",0.28},{"bone black",0.2},{"lead white",0.4}, name="gnd_fg"}
local g = rect(80, 630, 340, 84)
work(g, {hand="body", tool={kind="flat", width=12}, piles={{gnd_fg, function(x,y) return 1 - smoothstep(640, 690, y) end}, {fg_dark, function(x,y) return smoothstep(650, 700, y) end}}, angle=0, coverage=1.8, fill=true, clip=true, seed=3})
bootA = poly({{157,661},{164,661},{174,664},{176,676},{177,682},{181,685},{190,688},{198,691},{206,694},{209,697},{209,700},{173,701},{173,707},{155,707},{155,701},{145,700},{144,694},{145,682},{147,673},{150,665}})
bootB = bootA:offset(0) 
bootB = poly({{293,667},{311,667},{316,672},{317,682},{319,685},{330,688},{339,691},{348,694},{352,697},{351,700},{315,701},{315,706},{299,706},{299,701},{291,700},{290,690},{290,676}})
work(bootA + bootB, {hand="detail", tool={kind="round", width=2.5}, pile=cw_dark, coverage=3.2, clip=true, angle=0, seed=5})
wait(10*24*60)
print(drying(160,690), drying(200,660))

--@ chunk 3
wait(4*24*60) print(drying(160,690), drying(300,690))

--@ chunk 4
rim_warm = pile{{"burnt sienna",1},{"Naples yellow",0.9},{"orange chrome",0.35},{"vermilion",0.12},{"lead white",0.2}, name="rim_warm"}
hat_rim = pile{{"lead white",0.6},{"ultramarine blue",0.4},{"rose madder",0.2},{"raw umber",0.4},{"bone black",0.1}, name="hat_rim"}
spur_m = pile{{"lead white",0.5},{"raw umber",0.4},{"ultramarine blue",0.2},{"bone black",0.12},{"rose madder",0.05}, name="spur_m"}
spur_glint = pile{{"lead white",1},{"Naples yellow",0.5},{"orange chrome",0.15}, name="spur_glint"}
boot_sheen = mix{{cw_dark,0.6},{rim_warm,0.4}, name="boot_sheen"}
boot_sheen_c = mix{{cw_dark,0.6},{hat_rim,0.4}, name="boot_sheen_c"}
sb = brush{kind="round", width=1.6, point=0.85, stiffness=0.55}
function sline(p, pts, load) sb:reload(p, load or 0.65) sb:gesture(pts, {wobble=0.05}) end
function rowel(cx, cy, r, n, a0, w)
  local rb = brush{kind="round", width=w or 1.3, point=0.9, stiffness=0.55}
  for i = 0, n-1 do
    local a = a0 + i * 2*math.pi/n
    rb:reload(spur_m, 0.6)
    rb:gesture({{cx + math.cos(a)*0.6, cy + math.sin(a)*0.6, 0.5}, {cx + math.cos(a)*r*0.6, cy + math.sin(a)*r*0.6, 0.35}, {cx + math.cos(a)*r, cy + math.sin(a)*r, 0.0}}, {wobble=0})
  end
end
-- boot A: band, shank, rowel 6 spikes r 3.6
sline(spur_m, {{165,693.2,0.3},{156,694,0.55},{147,694.6,0.55},{141,695.6,0.45},{138.5,696.2,0.3}})
rowel(136, 696.5, 3.8, 6, 0.25, 1.3)
-- boot B: band, shank, rowel 8 spikes r 4.2 thinner
sline(spur_m, {{310,693.2,0.3},{300,694,0.55},{291,694.6,0.55},{285,695.6,0.45},{282.5,696.2,0.3}})
rowel(280, 696.5, 4.2, 8, 0.1, 1.1)
-- sheens
sb:reload(boot_sheen, 0.6) sb:gesture({{178,684.5,0.1},{186,686.5,0.4},{196,689.6,0.5},{204,692.6,0.45},{208.5,696,0.15}}, {wobble=0.05})
sb:reload(boot_sheen_c, 0.6) sb:gesture({{320,684.8,0.1},{330,687.6,0.4},{340,690.6,0.5},{348,693.4,0.45},{351.5,696.5,0.15}}, {wobble=0.05})

--@ chunk 5
local g = rect(430, 630, 340, 84)
work(g, {hand="body", tool={kind="flat", width=12}, piles={{gnd_fg, function(x,y) return 1 - smoothstep(640, 690, y) end}, {fg_dark, function(x,y) return smoothstep(650, 700, y) end}}, angle=0, coverage=1.8, fill=true, clip=true, seed=13})
local function sh(pts, dx) local q = {} for i, p in ipairs(pts) do q[i] = {p[1]+dx, p[2]} end return q end
bootA2 = poly(sh({{157,661},{164,661},{174,664},{176,676},{177,682},{181,685},{190,688},{198,691},{206,694},{209,697},{209,700},{173,701},{173,707},{155,707},{155,701},{145,700},{144,694},{145,682},{147,673},{150,665}}, 350))
bootB2 = poly(sh({{293,667},{311,667},{316,672},{317,682},{319,685},{330,688},{339,691},{348,694},{352,697},{351,700},{315,701},{315,706},{299,706},{299,701},{291,700},{290,690},{290,676}}, 350))
work(bootA2 + bootB2, {hand="detail", tool={kind="round", width=2.5}, pile=cw_dark, coverage=3.2, clip=true, angle=0, seed=15})
wait(14*24*60)
print(drying(510,690), drying(650,690))

--@ chunk 6
wait(3*24*60) print(drying(510,690), drying(500,700))
spur_dim = mix{{spur_m,0.55},{cw_dark,0.45}, name="spur_dim"}
-- boot A2 (dx 350): short heel band curving up to the ankle, dimmer; rowel brighter, glint
local dx = 350
sb:reload(spur_dim, 0.6) sb:gesture({{dx+156,692.5,0.25},{dx+150,694,0.5},{dx+145.5,695,0.5},{dx+141,696,0.45},{dx+138.5,696.4,0.3}}, {wobble=0.05})
rowel(dx+136, 696.6, 3.8, 6, 0.25, 1.3)
local gb = brush{kind="round", width=1.2, point=0.8, stiffness=0.55}
gb:reload(spur_glint, 0.55) gb:touch(dx+137.3, 695.6, {pressure=0.35})
sb:reload(boot_sheen, 0.6) sb:gesture({{dx+178,684.5,0.1},{dx+186,686.5,0.4},{dx+196,689.6,0.5},{dx+204,692.6,0.45},{dx+208.5,696,0.15}}, {wobble=0.05})
-- boot B2: band only as a short glint at the heel, rowel 5 spikes r 3.6 width 1.4
sb:reload(spur_dim, 0.6) sb:gesture({{dx+300,692.8,0.25},{dx+294,694.2,0.5},{dx+289.5,695.2,0.5},{dx+285,696.2,0.4},{dx+282.5,696.6,0.3}}, {wobble=0.05})
rowel(dx+280, 696.8, 3.6, 5, -0.3, 1.4)
gb:reload(spur_glint, 0.55) gb:touch(dx+281.2, 695.8, {pressure=0.35})
sb:reload(boot_sheen, 0.6) sb:gesture({{dx+320,684.8,0.1},{dx+330,687.6,0.4},{dx+340,690.6,0.5},{dx+348,693.4,0.45},{dx+351.5,696.5,0.15}}, {wobble=0.05})
