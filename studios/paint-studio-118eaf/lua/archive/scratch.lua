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
function T(pts, dx, dy) local q = {} for i, p in ipairs(pts) do q[i] = {p[1]+dx, p[2]+dy, p[3]} end return q end
function replica(dx, dy, seed)
  local gun2 = ribbon(T({{452,333},{470,332},{488,331}}, dx, dy), {5.5,5,5}) + ellipse(457+dx,336+dy,8,6) + poly(T({{446,330},{452,327},{455,332}}, dx, dy), true)
  local hand = poly(T({{426,337},{438,333},{450,335},{454,342},{452,350},{446,356},{438,358},{430,356},{426,348}}, dx, dy), true)
  local trig = ribbon(T({{446,342},{454,344},{458,341}}, dx, dy), 3)
  local sleeve = ribbon(T({{268,320},{300,326},{340,334},{380,340},{410,344},{428,346}}, dx, dy), {38,33,29,27,25,22})
  local bg = rect(380+dx, 300+dy, 130, 80)
  work(bg, {hand="body", tool={kind="filbert", width=6, stiffness=0.35},
    piles={{fl_halo, function(x,y) return smoothstep(430+dx, 470+dx, x) end}, {sk_patch, function(x,y) return 1 - smoothstep(430+dx, 470+dx, x) end}},
    coverage=2.2, fill=true, clip=bg, seed=seed})
  local sl = sleeve * bg - hand
  work(sl, {hand="detail", tool={kind="round", width=2.5}, pile=cw_coat_dk, coverage=3, clip=sl, angle=0.13, seed=seed+1})
  work(hand, {hand="detail", tool={kind="round", width=2.5}, pile=fc_dk2, coverage=3, clip=hand, seed=seed+2})
  local gun = gun2 + trig
  work(gun - hand, {hand="detail", tool={kind="round", width=1.5}, pile=cw_dark, coverage=3, clip=gun - hand, seed=seed+3})
  return hand
end
function hand_lights(dx, dy, hand)
  local rb = brush{kind="round", width=3, point=0.8, stiffness=0.55}
  local function g(p, pts, load) rb:reload(p, load or 0.7) rb:gesture(T(pts, dx, dy), {wobble=0.15, clip=hand}) end
  g(fc_lt2, {{448,337,0.5},{452,341,0.7},{453,346,0.7},{451,351,0.6},{447,356,0.4}}, 0.8)
  g(fc_hot, {{451,341,0.4},{452,346,0.45}}, 0.7)
  g(fc_lt2, {{432,337,0.35},{439,334,0.55},{446,334,0.5}}, 0.6)
end
H1 = replica(0, 0, 11)
H2 = replica(0, 100, 21)
H3 = replica(150, 0, 31)
H4 = replica(150, 100, 41)
wait(10*24*60)
hand_lights(0, 0, H1) hand_lights(0, 100, H2) hand_lights(150, 0, H3) hand_lights(150, 100, H4)
wait(14*24*60)
print(drying(440,345), drying(590,445), drying(470,332))
