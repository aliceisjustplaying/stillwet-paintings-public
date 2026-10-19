-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 3}, {"yellow ochre", 1}, {"raw umber", 0.4}}, texture=0.1, um=40}}, linen={24, 22}, seed=5, size=600}

--@ chunk 2
dkA = pile{{"rose madder", 0.4}, {"ultramarine blue", 0.5}, {"burnt sienna", 0.3}, {"lead white", 0.5}, turps=0.2, name="dkA"}
dkB = pile{{"ultramarine blue", 0.6}, {"burnt sienna", 0.7}, {"permanent alizarin", 0.4}, {"bone black", 0.1}, {"lead white", 0.15}, turps=0.15, name="dkB"}
dkC = pile{{"burnt sienna", 0.8}, {"ultramarine blue", 0.6}, {"bone black", 0.3}, {"permanent alizarin", 0.2}, turps=0.1, name="dkC"}
fgR = rect(0, 452, 1000, 298)
work(fgR, {hand="broad", coverage=1.2, fill=true, angle=0.03, piles={
  {dkA, function(x,y) return clamp(1 - (y-455)/50, 0, 1) end},
  {dkB, function(x,y) return clamp(1 - math.abs(y-560)/120, 0, 1) end},
  {dkC, function(x,y) return clamp((y-580)/140, 0, 1) end}}})
print("SCRATCH-27 (fresh): dark base laid on sea band y452-750", drying(566,480), drying(200,600))

--@ chunk 3
wait(5760)
print("scratch-27 base after 4 days", drying(566,480), drying(200,600), drying(800,700))

--@ chunk 4
PATHENV = poly({{628,440},{664,440},{722,650},{520,650}}, true)
seaCoatM = rect(0, 452, 1000, 298) - PATHENV
cTop = pile{{"rose madder", 0.3}, {"ultramarine blue", 0.2}, {"lead white", 1.2}, {"pale cadmium", 0.15}, turps=0.4, name="cTop"}
cMid = pile{{"ultramarine blue", 0.8}, {"permanent alizarin", 0.5}, {"lead white", 0.9}, turps=0.4, name="cMid"}
cLow = pile{{"Prussian blue", 0.4}, {"ultramarine blue", 0.8}, {"permanent alizarin", 0.3}, {"lead white", 0.4}, turps=0.3, name="cLow"}
work(seaCoatM, {hand="broad", coverage=1.2, fill=true, clip=true, angle=0.02, edge="soft", piles={
  {cTop, function(x,y) return clamp(1 - (y-452)/60, 0, 1) end},
  {cMid, function(x,y) return clamp(1 - math.abs(y-560)/120, 0, 1) end},
  {cLow, function(x,y) return clamp((y-580)/140, 0, 1) end}}})
print("SCRATCH-27: sea coat laid over dry dark base", drying(566,480), drying(200,600))

--@ chunk 5
wait(4320)
print("scratch-27 sea coat after 3 days", drying(566,480), drying(200,600), drying(800,700))

--@ chunk 6
seaVio = pile{{"ultramarine blue", 0.8}, {"permanent alizarin", 0.5}, {"rose madder", 0.2}, {"lead white", 0.7}, name="seaVio"}
ovalM = ellipse(566, 480, 50, 16)
work(ovalM, {hand="body", pile=seaVio, coverage=1.5, fill=true, clip=true, edge="soft", load=1.0})
print("SCRATCH-27: dark bar (seaVio, ellipse 50x16) laid on dry sea", drying(566,480))

--@ chunk 7
wait(7200)
print("scratch-27 dark bar after 5 days", drying(566,480), drying(540,478), drying(590,482))

--@ chunk 8
wait(4320)
print("scratch-27 dark bar after 8 days", drying(566,480), drying(540,478), drying(590,482))

--@ chunk 9
wait(2880)
print("scratch-27 dark bar after 10 days", drying(566,480), drying(540,478), drying(590,482))

--@ chunk 10
lilG = pile{{"rose madder", 0.3}, {"ultramarine blue", 0.3}, {"lead white", 1.1}, turps=0.25, name="lilG"}
grTeal = pile{{"cerulean blue", 0.5}, {"ultramarine blue", 0.2}, {"lead white", 1.1}, turps=0.25, name="grTeal"}
peachR = pile{{"pale cadmium", 0.3}, {"rose madder", 0.3}, {"lead white", 1.2}, turps=0.25, name="peachR"}
b3 = brush("flat", 3)
n = 0
local specs = {{lilG, 14}, {grTeal, 10}, {peachR, 5}}
for _, s in ipairs(specs) do
  b3:load(s[1], 0.3)
  for i = 1, s[2] do
    local y = 462 + math.random() * 40
    local x = 500 + math.random() * 130
    local len = 26 + math.random() * 50
    b3:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 0.4}}, {pressure = 0.07 + 0.04 * math.random()})
    n = n + 1
  end
end
print("ripples over dry bar, scratch-27", n, drying(566,480))

--@ chunk 11
lilG = pile{{"rose madder", 0.3}, {"ultramarine blue", 0.3}, {"lead white", 1.1}, turps=0.25, name="lilG"}
grTeal = pile{{"cerulean blue", 0.5}, {"ultramarine blue", 0.2}, {"lead white", 1.1}, turps=0.25, name="grTeal"}
teal2 = pile{{"cerulean blue", 0.6}, {"raw umber", 0.15}, {"lead white", 1.0}, turps=0.2, name="teal2"}
peachR = pile{{"pale cadmium", 0.3}, {"rose madder", 0.3}, {"lead white", 1.2}, turps=0.25, name="peachR"}
LOWREG = rect(0, 540, 1000, 150) - PATHENV
b7 = brush("flat", 3)
n = 0
local cur = nil
for i = 1, 70 do
  local y = 540 + (math.random() ^ 1.15) * 150
  local t = (y - 540) / 150
  local x = math.random() * 1000
  if LOWREG:at(x, y) > 0.5 then
    local cx = 646 - (y - 440) * 0.12
    local pick
    if math.abs(x - cx) < 150 and math.random() < 0.5 then pick = peachR
    elseif math.random() < 0.5 then pick = lilG
    elseif math.random() < 0.6 then pick = teal2
    else pick = grTeal end
    if pick ~= cur or i % 9 == 0 then b7:reload(pick, 0.3); cur = pick end
    local len = 18 + 56 * t + math.random() * (12 + 36 * t)
    b7:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 0.4}}, {pressure = 0.07 + 0.04 * math.random()})
    n = n + 1
  end
end
print("lower sea ripple trial on scratch-27", n, drying(200,600))

--@ chunk 12
b8 = brush("flat", 3)
n = 0
local cur = nil
for i = 1, 30 do
  local y = 618 + (math.random() ^ 1.1) * 74
  local t = (y - 540) / 150
  local x = math.random() * 1000
  if LOWREG:at(x, y) > 0.5 then
    local pick = (math.random() < 0.5) and lilG or teal2
    if pick ~= cur or i % 10 == 0 then b8:reload(pick, 0.32); cur = pick end
    local len = 40 + math.random() * (30 + 40 * t)
    b8:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 0.5}}, {pressure = 0.12 + 0.05 * math.random()})
    n = n + 1
  end
end
print("near band, heavier, on scratch-27", n, drying(200,650))

--@ chunk 13
print("scratch mid sea", drying(800,470), drying(900,500), drying(760,520), "scratch low", drying(200,600))

--@ chunk 14
mR = rect(690, 452, 310, 84) - PATHENV
lilR = pile{{"rose madder", 0.3}, {"ultramarine blue", 0.3}, {"lead white", 1.1}, turps=0.25, name="lilR"}
grR = pile{{"cerulean blue", 0.5}, {"ultramarine blue", 0.2}, {"lead white", 1.1}, turps=0.25, name="grR"}
tlR = pile{{"cerulean blue", 0.6}, {"raw umber", 0.15}, {"lead white", 1.0}, turps=0.2, name="tlR"}
pcR = pile{{"pale cadmium", 0.3}, {"rose madder", 0.3}, {"lead white", 1.2}, turps=0.25, name="pcR"}
bm = brush("flat", 3)
n = 0
cur = nil
for i = 1, 28 do
  local y = 452 + math.random() * 78
  local t = (y - 452) / 78
  local x = 690 + math.random() * 300
  if mR:at(x, y) > 0.5 then
    local pick
    local r = math.random()
    if r < 0.3 then pick = lilR elseif r < 0.6 then pick = grR elseif r < 0.85 then pick = tlR else pick = pcR end
    if pick ~= cur then bm:reload(pick, 0.3); cur = pick end
    local len = 14 + 30 * t + math.random() * (10 + 20 * t)
    bm:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 0.4}}, {pressure = 0.07 + 0.03 * math.random()})
    n = n + 1
  end
end
print("right-mid glints trial on scratch", n, drying(800,470))
