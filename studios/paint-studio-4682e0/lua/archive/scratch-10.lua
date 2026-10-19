-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
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
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 1}}, texture=0.25, um=70}, {apply="brush", pile={{"lead white", 3}, {"yellow ochre", 1.2}, {"raw umber", 1}, {"red earth", 0.35}}, um=25}}, linen={16, 14}, seed=1873, size=700}

--@ chunk 2
skyP = pile{{"lead white", 8}, {"Naples yellow", 1}, {"lemon chrome", 0.25}, name="sky"}
facP = pile{{"lead white", 5}, {"Naples yellow", 1}, {"raw umber", 0.12}, {"ultramarine blue", 0.06}, name="facade"}
zombP = pile{{"bone black", 1}, {"raw umber", 1.2}, {"green earth", 1.2}, name="zomb"}
veilA = pile{{"lead white", 2}, {"raw umber", 0.5}, {"yellow ochre", 0.6}, {"burnt sienna", 0.2}, medium=0.6, name="veilA"}
deepD = pile{{"bone black", 1}, {"raw umber", 1}, {"ultramarine blue", 0.4}, turps=0.3, name="deepD"}
local base = rect(50, 50, 600, 500)
work(base, {hand="body", tool={kind="filbert", width=10, lay=2.5}, piles={{skyP,1},{facP,1}}, coverage=2.5, fill=true, clip=base, angle=1.57, length={15,40}})
wait(20*24*60)
-- dark figure parts, dry
fig = ellipse(400, 200, 40, 50) + ribbon({{390, 230}, {330, 240}, {280, 245}}, {16, 12, 9})
work(fig, {hand="detail", tool={kind="round", width=3}, piles={{zombP, 1}, {deepD, 0.4}}, coverage=4, fill=true, clip=fig, angle=0.15, length={4, 12}})
wait(20*24*60)
print(drying(400,200))

--@ chunk 3
-- same sequence as the painting this morning
local lz = rect(250, 120, 220, 300) - fig
work(lz, {hand="body", tool={kind="filbert", width=8, lay=2.5}, piles={{facP, 1}, {skyP, 0.6}}, coverage=2.5, fill=true, clip=lz, angle=1.57, angle_jitter=0.2, length={10, 26}})
-- wet dark repaint of the figure
work(fig, {hand="detail", tool={kind="round", width=3}, piles={{zombP, 1}, {deepD, 0.4}}, coverage=4, fill=true, clip=fig, angle=0.5, length={4, 10}})
-- spirit rag wipes along the edge of the head
local liftM = (ellipse(400, 200, 46, 56) - ellipse(400, 200, 40, 50))
for i = 1, 4 do
  local r = rag{width=8}; r:dip(0.95)
  r:wipe(liftM, {pressure=0.95, angle=({0.2, 1.57, 0.9, -0.6})[i], passes=1, refold=0.4})
end
local arm = fig * mask(function(x, y) return x > 330 and 1 or 0 end)
for i = 1, 4 do
  local r = rag{width=8}; r:dip(0.95)
  r:wipe(arm, {pressure=0.95, angle=({0.15, 1.57, 0.6, -0.5})[i], passes=1, refold=0.35})
end
local function tv(x, y) return 0.7 * (1 - smoothstep(280, 310, x)) end
work(fig, {hand="detail", tool={kind="round", width=2.5}, piles={{zombP, 1}, {deepD, 0.3}, {veilA, tv}}, coverage=5, fill=true, clip=fig, angle=0.15, length={4, 12}})
local nz = noise{seed=71, period=40, octaves=3, kind="billow"}
local cx, cy, a = 290, 240, -0.55
local sd = function(x, y)
  local u, v = x - cx, y - cy
  local along = u * math.cos(a) + v * math.sin(a)
  local across = -u * math.sin(a) + v * math.cos(a)
  local e = math.exp(-((along / 85)^2 + (across / 55)^2) * 1.6)
  return e * (0.55 + 0.6 * nz:at01(x, y))
end
local dh = rect(255, 125, 210, 290) - fig:grow(1)
stipple(dh, {pile=veilA, width=10, coverage=function(x, y) return 2.6 * sd(x, y) end, feather=1, pressure={0.2, 0.5}, dips={30, 0.4, 0}, clip=dh})
local bl = dh:shrink(1.5)
blend(bl, {angle=-0.55}); blend(bl, {angle=1.0})
local rows = {}
for y = 120, 420, 10 do
  local s = string.format("%3d ", y)
  for x = 250, 470, 5 do
    local d = drying(x, y)
    s = s .. (d == "open" and "." or d == "setting" and "S" or d == "tacky" and "t" or "d")
  end
  print(s)
end

--@ chunk 4
local m = rect(600, 100, 100, 100)
work(m, {hand="body", tool={kind="filbert", width=8, lay=2.5}, pile=facP, coverage=2.5, fill=true, clip=m, angle=1.57, length={10, 26}})
local m2 = rect(600, 300, 100, 100)
work(m2, {hand="body", tool={kind="filbert", width=8}, pile=zombP, coverage=2.5, fill=true, clip=m2, angle=1.57, length={10, 26}})
-- age until setting
local t = 0
while drying(650, 350) == "open" and t < 200 do wait(60); t = t + 1 end
print("hours", t, drying(650, 150), drying(650, 350))

--@ chunk 5
local k = knife{width=8}
k:scrape({{650, 310}, {650, 380}}, {pressure=1, angle=0})
wait(1)
print(drying(650, 350))
