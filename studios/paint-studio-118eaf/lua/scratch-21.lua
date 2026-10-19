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

--@ chunk 3
zb_flash = pile{{"orange chrome", 1}, {"Naples yellow", 0.6}, {"burnt sienna", 0.3}, {"lead white", 0.2}, name="zb_flash"}
grip_wood = pile{{"burnt sienna", 1}, {"raw umber", 0.8}, {"bone black", 0.35}, {"Indian red", 0.2}, name="grip_wood"}
grip_dk = mix{{grip_wood, 0.5}, {cw_dark, 0.5}, name="grip_dk"}
grip_lit = mix{{grip_wood, 0.45}, {zb_flash, 0.55}, name="grip_lit"}
steel_lit = mix{{cw_dark, 0.45}, {zb_flash, 0.55}, name="steel_lit"}
function gunparts(dx, dy, hand, opts)
  opts = opts or {}
  local butt = poly(T({{438,354},{446.5,354},{446,358},{444.5,362},{441,364.6},{437,364.4},{434.5,362},{435,358}}, dx, dy), true)
  local bm = butt - hand:shrink(0.3)
  work(bm, {hand="detail", tool={kind="round", width=1.5}, pile=grip_dk, coverage=3.5, clip=bm, angle=1.3, seed=51+dx})
  local rb = brush{kind="round", width=1.5, point=0.85, stiffness=0.55}
  local function s(p, pts, load, clipm) rb:reload(p, load or 0.7) rb:gesture(T(pts, dx, dy), {wobble=0.05, clip=clipm}) end
  -- lit front strap of the grip
  s(grip_lit, {{446,356,0.3},{445.5,359,0.5},{444,362,0.4},{442,364,0.15}}, 0.6)
  -- trigger guard loop
  s(cw_dark, {{451,338.5,0.5},{455.5,340,0.6},{457.5,343.5,0.6},{455.5,346.5,0.55},{451.5,346.5,0.4}}, 0.8)
  -- ejector housing under barrel
  s(cw_dark, {{466,334,0.5},{474,333.6,0.5},{482,333.2,0.4},{484,333.2,0.15}}, 0.8)
  if opts.cyl then
    -- flash-lit front face of the cylinder
    s(steel_lit, {{465,328,0.3},{465.5,331,0.55},{465.3,334.5,0.5},{464.5,337,0.2}}, 0.6)
  end
  if opts.notch then
    local nb = brush{kind="round", width=1.2, point=0.9, stiffness=0.6}
    nb:reload(fc_dk2, 0.8) nb:gesture(T({{448,346.5,0.5},{451,346.8,0.6},{454,346.6,0.2}}, dx, dy), {wobble=0, clip=hand:grow(0.5)})
    nb:reload(fc_dk2, 0.8) nb:gesture(T({{446,351.5,0.5},{449,351.8,0.6},{452,351.4,0.2}}, dx, dy), {wobble=0, clip=hand:grow(0.5)})
  end
end
gunparts(0, 0, H1, {})
gunparts(150, 0, H3, {cyl=true, notch=true})

--@ chunk 4
function newhand(dx, dy)
  -- squarer fist: flat-ish top (thumb line), straight front with finger stack, heel at bottom-back
  local hand = poly(T({{426,337},{436,334},{446,333.5},{451,335},{454.5,339},{455.5,345},{455,351},{453,356},{448,359},{440,359.5},{432,357.5},{427,352},{425.5,344}}, dx, dy), true)
  work(hand, {hand="detail", tool={kind="round", width=2.2}, pile=fc_dk2, coverage=3.5, clip=hand, seed=61+dx+dy})
  -- grip butt: angular, flaring back at the bottom
  local butt = poly(T({{437,357},{447,357.5},{446.5,361},{445.5,364.5},{438,365.5},{434,365},{433.5,362.5},{435.5,359.5}}, dx, dy)) - hand:shrink(0.3)
  work(butt, {hand="detail", tool={kind="round", width=1.4}, pile=grip_dk, coverage=3.5, clip=butt, angle=1.3, seed=62+dx+dy})
  local rb = brush{kind="round", width=1.5, point=0.85, stiffness=0.55}
  local function s(p, pts, load, clipm) rb:reload(p, load or 0.7) rb:gesture(T(pts, dx, dy), {wobble=0.03, clip=clipm}) end
  -- trigger guard loop in front of the fist
  s(cw_dark, {{452,338.2,0.5},{456.5,339.3,0.6},{459,342.5,0.6},{457.8,345.6,0.55},{454,346.6,0.4}}, 0.8)
  -- ejector housing under barrel
  s(cw_dark, {{466,334,0.5},{474,333.6,0.5},{482,333.2,0.4},{484,333.2,0.15}}, 0.8)
  return hand
end
N2 = newhand(0, 100)
N4 = newhand(150, 100)
wait(12*24*60)
print(drying(440,445), drying(590,445), drying(440,462))

--@ chunk 5
function newlights(dx, dy, hand, variant)
  local rb = brush{kind="round", width=2.6, point=0.85, stiffness=0.55}
  local function g(p, pts, load, clipm) rb:reload(p, load or 0.7) rb:gesture(T(pts, dx, dy), {wobble=0.05, clip=clipm or hand}) end
  -- four finger knuckles stacked down the front, each its own short curved lit stroke, gaps between
  g(fc_lt2, {{450.5,339.2,0.25},{453.5,340.5,0.6},{454.6,342.6,0.35}}, 0.75)  -- index (in the guard)
  g(fc_lt2, {{451.5,345.2,0.25},{454.5,346.4,0.65},{455,348.6,0.35}}, 0.75)
  g(fc_lt2, {{450.5,350.6,0.25},{453.8,351.8,0.6},{454,354,0.3}}, 0.75)
  g(fc_lt2, {{447,355.6,0.2},{450.5,356.4,0.5},{450.8,358,0.2}}, 0.7)
  g(fc_hot, {{453.6,341,0.35},{454.3,342,0.3}}, 0.6)
  g(fc_hot, {{454.6,346.8,0.35},{455,348,0.3}}, 0.6)
  -- thumb: along the top, pointing forward under the hammer
  g(fc_lt2, {{432,336.2,0.25},{439,334.3,0.5},{446,333.6,0.5},{450,334.2,0.2}}, 0.6)
  -- grip: lit front strap edge
  local sb = brush{kind="round", width=1.4, point=0.85, stiffness=0.55}
  sb:reload(grip_lit, 0.65) sb:gesture(T({{446.5,358.5,0.3},{446,361.5,0.55},{445.2,364.2,0.35}}, dx, dy), {wobble=0.03})
  if variant == 2 then
    sb:reload(steel_lit, 0.65) sb:gesture(T({{465.3,327.5,0.25},{465.7,331,0.55},{465.5,334.5,0.5},{464.8,337,0.2}}, dx, dy), {wobble=0.03})
  end
end
newlights(0, 100, N2, 1)
newlights(150, 100, N4, 2)
