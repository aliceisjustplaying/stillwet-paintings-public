-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ engine 8
--@ knife-skim
--@ limbs-join-nearest
--@ blend-feather
--@ brush-skim
--@ blend-at-masks
--@ glaze-film
--@ liquid-film-levels
--@ rag-lift
--@ full-palette-refuses
--@ drain

--@ chunk 1
canvas{aspect=0.8, ground={{apply="knife", pile={{"lead white", 10}, {"yellow ochre", 0.4}, {"raw umber", 0.15}}, texture=0.25, um=120}}, linen={18, 15}, seed=4417, size=480}

--@ chunk 2
amber = pile{{"yellow ochre",3},{"red earth",1},{"lead white",1}, name="amber"}
birch = pile{{"lead white",8},{"yellow ochre",0.25},{"chrome yellow",0.05}, name="birch"}
birch_mid = pile{{"lead white",5},{"raw umber",0.4},{"yellow ochre",0.3},{"smalt",0.4}, name="birch_mid"}
lent = pile{{"bone black",1},{"raw umber",1.2}, name="lent"}
barkglaze = pile{{"raw umber",1},{"smalt",0.6}, medium=0.6, name="barkglaze"}
work(rect(100, 100, 400, 500), {hand="body", tool={kind="flat", width=10}, length={20,50}, coverage=4, fill=true, clip=true, pile=amber})
local tr = rect(200, 100, 30, 500):roughen(1.5, 12, 3)
local tr2 = rect(350, 100, 22, 500):roughen(1.5, 12, 4)
work(tr + tr2, {hand="body", tool={kind="flat", width=7}, length={20,50}, coverage=3, fill=true, clip=true, angle=-math.pi/2, piles={{birch,1},{birch_mid,function(x,y) return (x > 220 or x > 365) and 0.6 or 0.1 end}}})
local lb = brush{kind="round", width=4, point=0.6}
for y = 120, 580, 22 do
  lb:reload(lent, 0.5)
  lb:gesture({{203, y, 0.2}, {212, y + 1, 0.6}, {222, y, 0.1}})
  lb:reload(lent, 0.5)
  lb:gesture({{352, y + 8, 0.2}, {360, y + 9, 0.6}, {368, y + 8, 0.1}})
end
wait(60*24*60)
work(tr + tr2, {hand="glaze", pile=barkglaze, coverage=1, angle=-math.pi/2, tool={kind="filbert", width=12}})
wait(60*24*60)
print(drying(210, 300))

--@ chunk 3
gray_l = mix{{birch_mid, 0.6}, {lent, 0.15}, {birch, 0.25}, name="gray_l"}
local fb = brush{kind="flat", width=6, stiffness=0.5}
local covered = {142, 164, 252, 274, 296, 406, 428, 494, 560}
for _, y in ipairs(covered) do
  fb:reload(birch_mid, 0.5)
  fb:stroke({{212 + rand(-2, 2), y - 7}, {212 + rand(-2, 2), y + 8}}, {pressure={0.45, 0.35}, orient="across", clip=rect(198, 100, 36, 500)})
end
-- grayer short marks in place of two
local gb = brush{kind="round", width=3, point=0.6}
for _, y in ipairs({{186}, {340}, {472}}) do
  gb:reload(gray_l, 0.5)
  gb:gesture({{206, y[1], 0.2}, {213, y[1] + 1, 0.5}, {218, y[1], 0.1}})
end
-- chevron scars clumped near y 200-230 and 380
local cb = brush{kind="round", width=4, point=0.6}
for _, c in ipairs({{214, 214}, {212, 384}}) do
  cb:reload(lent, 0.6)
  cb:gesture({{c[1] - 12, c[2] - 6, 0.1}, {c[1] - 4, c[2], 0.6}, {c[1], c[2] + 3, 0.8}, {c[1] + 4, c[2], 0.6}, {c[1] + 12, c[2] - 6, 0.1}})
end
-- a broken dark patch on the shadow side
local pb = brush{kind="filbert", width=5}
pb:reload(lent, 0.5)
pb:stroke({{226, 300}, {227, 312}, {225, 322}}, {pressure={0.5, 0.2}})
pb:reload(lent, 0.5)
pb:stroke({{224, 510}, {226, 518}}, {pressure={0.5, 0.2}})
