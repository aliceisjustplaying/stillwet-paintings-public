-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"lead white", 10}, {"bone black", 0.2}}, texture=0.3, um=120}, {apply="brush", pile={{"lead white", 6}, {"red earth", 1.2}, {"raw umber", 1}, {"yellow ochre", 0.6}}, texture=0.5, um=40}}, linen={16, 14}, seed=4471, size=900}

--@ chunk 2
-- rebuild the head setting on scratch: sky bg, hat, face base, then trial face
sk_mauve = pile{{"lead white", 1.5}, {"ultramarine blue", 0.4}, {"rose madder", 0.35}, {"raw umber", 0.2}}
work(rect(150,170,200,160), {hand="broad", pile=sk_mauve, coverage=2, fill=true, clip=true})
cb_hat = poly({{186,250},{205,241},{221,238},{221,214},{226,202},{238,196},{252,203},{266,196},{275,205},{279,236},{296,240},{314,248},{300,255},{260,258},{220,257},{196,256}}, true)
cb_head2 = poly({{232,256},{268,256},{272,262},{276,266},{279,271},{286,277},{280,280},{282,284},{279,287},{280,292},{275,296},{264,298},{258,302},{242,302},{236,292},{231,278}}, false):soften(0.8)
cw_dark = pile{{"bone black", 1}, {"raw umber", 1}, {"ultramarine blue", 0.5}}
skin_sh = pile{{"raw umber", 1}, {"burnt sienna", 0.6}, {"ultramarine blue", 0.2}, {"rose madder", 0.12}, {"lead white", 0.15}}
work(cb_hat, {hand="detail", pile=cw_dark, coverage=2.5, clip=true})
work(cb_head2 - cb_hat, {hand="detail", pile=skin_sh, coverage=3, clip=true})
wait(12*24*60)
print(drying(255,280))

--@ chunk 3
fc_dk = pile{{"raw umber", 1}, {"burnt sienna", 0.35}, {"ultramarine blue", 0.35}, {"bone black", 0.12}, {"rose madder", 0.1}, name="fc_dk"}
fc_md = pile{{"burnt sienna", 1}, {"raw umber", 0.6}, {"vermilion", 0.2}, {"Naples yellow", 0.3}, {"ultramarine blue", 0.08}, name="fc_md"}
fc_lt = pile{{"Naples yellow", 1}, {"orange chrome", 0.45}, {"vermilion", 0.2}, {"burnt sienna", 0.3}, {"lead white", 0.25}, name="fc_lt"}
fc_hot = pile{{"Naples yellow", 1}, {"lead white", 0.7}, {"orange chrome", 0.35}, {"cadmium yellow", 0.2}, name="fc_hot"}
hat_rim = pile{{"lead white", 0.6}, {"ultramarine blue", 0.4}, {"rose madder", 0.2}, {"raw umber", 0.4}, {"bone black", 0.1}, name="hat_rim"}
hat_glow = pile{{"burnt sienna", 1}, {"orange chrome", 0.5}, {"raw umber", 0.5}, {"bone black", 0.1}, name="hat_glow"}
local face = cb_head2 - cb_hat
-- 1 shadow base, whole face
work(face, {hand="detail", tool={kind="round", width=3}, pile=fc_dk, coverage=2.5, clip=face, seed=1})
-- 2 mid on the front half
local front = poly({{258,258},{276,262},{288,278},{284,300},{258,304},{254,284}}, true) * face
work(front, {hand="detail", tool={kind="round", width=2.5}, pile=fc_md, coverage=2, clip=face, edge="soft", seed=2})
-- 3 lit planes as gestures (round, pointed)
local rb = brush{kind="round", width=3.2, point=0.8, stiffness=0.55}
local function g(p, pts, load) rb:reload(p, load or 0.7) rb:gesture(pts, {wobble=0.2, clip=face}) end
g(fc_lt, {{272,262,0.3},{276,266,0.6},{279,271,0.7},{283,276,0.6}})          -- brow/nose ridge
g(fc_lt, {{280,281,0.5},{279,286,0.6},{278,292,0.7},{274,296,0.6},{266,299,0.3}}) -- lips, chin, jaw underside
g(fc_lt, {{270,280,0.4},{272,286,0.7},{270,292,0.6}})                            -- cheek plane
g(fc_hot, {{282,277,0.4},{284,278,0.6}}, 0.6)                                     -- nose tip
g(fc_hot, {{276,294,0.4},{271,297,0.5},{266,299,0.3}}, 0.5)                       -- chin underside
-- 4 eye, ear, hair, nostril/mouth line
g(fc_dk, {{266,268,0.9},{271,268,0.9},{272,270,0.6}}, 0.9)
g(fc_dk, {{275,284,0.6},{280,285,0.5}}, 0.8)
g(cw_dark, {{233,258,1.0},{234,270,1.0},{236,282,0.9},{240,290,0.6}}, 0.9)       -- hair at back
g(fc_md, {{246,272,0.9},{249,268,0.8},{252,274,0.8},{250,282,0.7},{246,284,0.5}}, 0.7)  -- ear
g(fc_dk, {{248,274,0.5},{249,279,0.4}}, 0.8)
-- 5 hat: cool rim top-left, warm glow under front brim
local hb = brush{kind="round", width=3, point=0.6, stiffness=0.55}
local function h(p, pts, load) hb:reload(p, load or 0.6) hb:gesture(pts, {wobble=0.3, clip=cb_hat}) end
h(hat_rim, {{223,236,0.4},{222,220,0.6},{226,206,0.6},{236,198,0.5},{246,201,0.3}})
h(hat_rim, {{190,250,0.4},{204,243,0.6},{218,240,0.4}})
h(hat_glow, {{268,255,0.3},{288,253,0.6},{304,252,0.5},{312,249,0.2}}, 0.6)
h(hat_rim, {{246,203,0.3},{254,206,0.5},{264,200,0.4}}, 0.4)   -- crown dent top

--@ chunk 4
function head_masks(dx, dy)
  local function P(t) local o = {} for i, p in ipairs(t) do o[i] = {p[1]+dx, p[2]+dy} end return o end
  local hat = poly(P{{186,250},{205,241},{221,238},{221,214},{226,202},{238,196},{252,203},{266,196},{275,205},{279,236},{296,240},{314,248},{300,255},{260,258},{220,257},{196,256}}, true)
  local head = poly(P{{232,256},{270,257},{272,262},{274,266},{273,270},{278,273},{285,278},{280,281},{282,284},{279,287},{281,289},{278,292},{281,296},{276,300},{264,301},{258,303},{242,302},{236,292},{231,278}}, false):soften(0.6)
  return hat, head
end
local hat, head = head_masks(300, 0)
work(rect(450,170,200,160), {hand="broad", pile=sk_mauve, coverage=2, fill=true, clip=true})
work(hat, {hand="detail", pile=cw_dark, coverage=2.5, clip=true})
work(head - hat, {hand="detail", pile=skin_sh, coverage=3, clip=true})
wait(12*24*60)
fc_dk2 = pile{{"raw umber", 1}, {"bone black", 0.22}, {"burnt sienna", 0.3}, {"ultramarine blue", 0.3}, {"rose madder", 0.08}, name="fc_dk2"}
fc_lt2 = pile{{"Naples yellow", 1}, {"orange chrome", 0.55}, {"vermilion", 0.25}, {"burnt sienna", 0.15}, {"lead white", 0.2}, name="fc_lt2"}
local face = head - hat
work(face, {hand="detail", tool={kind="round", width=3}, pile=fc_dk2, coverage=2.5, clip=face, seed=11})
local rb = brush{kind="round", width=3.5, point=0.8, stiffness=0.55}
local function g(p, pts, load) local q = {} for i, v in ipairs(pts) do q[i] = {v[1]+300, v[2], v[3]} end rb:reload(p, load or 0.75) rb:gesture(q, {wobble=0.2, clip=face}) end
g(fc_lt2, {{270,259,0.35},{272,264,0.6},{274,268,0.5}})
g(fc_lt2, {{276,272,0.5},{280,275,0.7},{284,278,0.6}})
g(fc_lt2, {{279,282,0.5},{280,286,0.55},{279,290,0.55},{278,294,0.6},{276,298,0.6},{268,301,0.45},{260,302,0.2}})
g(fc_hot, {{283,277,0.45},{284,279,0.4}}, 0.6)
g(fc_hot, {{278,296,0.4},{272,300,0.4}}, 0.5)
g(fc_lt2, {{268,284,0.3},{270,290,0.45},{268,296,0.3}}, 0.5)  -- cheek/jaw plane, fainter
g(cw_dark, {{265,267,0.9},{270,268,0.8}}, 0.9)                -- eye slit
local hb = brush{kind="round", width=3, point=0.6, stiffness=0.55}
local function h(p, pts, load) local q = {} for i, v in ipairs(pts) do q[i] = {v[1]+300, v[2], v[3]} end hb:reload(p, load or 0.6) hb:gesture(q, {wobble=0.3, clip=hat}) end
h(hat_glow, {{268,256,0.3},{288,254,0.7},{304,252,0.6},{313,249,0.2}}, 0.7)
h(hat_rim, {{223,236,0.35},{222,220,0.5},{226,206,0.5},{236,198,0.4}}, 0.5)
