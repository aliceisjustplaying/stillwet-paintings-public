-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 1}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 8}, {"yellow ochre", 0.4}, {"raw umber", 0.12}}, um=45}}, linen={15, 13}, seed=1774, size=700}

--@ chunk 2
local function line(knots, step, amp, nseed)
  local n = noise{seed=nseed, octaves=4, period=45}
  local out = {}
  for i = 1, #knots - 1 do
    local a, b = knots[i], knots[i+1]
    local steps = math.max(1, math.floor(math.abs(b[1]-a[1]) / step))
    for s = 0, steps - 1 do
      local t = s / steps
      local u = t*t*(3-2*t)
      local x = a[1] + (b[1]-a[1]) * t
      local y = a[2] + (b[2]-a[2]) * u + amp * n(x, a[2])
      out[#out+1] = {x, y}
    end
  end
  out[#out+1] = {knots[#knots][1], knots[#knots][2]}
  return out
end
lineF = line
eshadow = pile{{"lead white", 4}, {"smalt", 2}, {"cobalt blue", 0.3}, {"rose madder", 0.3}, {"raw umber", 0.2}, name="eshadow"}
mist_far = pile{{"lead white", 6}, {"smalt", 1.2}, {"rose madder", 0.25}, {"raw umber", 0.1}, name="mist_far"}
mist_bright = pile{{"lead white", 8}, {"smalt", 0.8}, {"rose madder", 0.2}, {"Naples yellow", 0.3}, name="mist_bright"}
local piles = {{eshadow, function(x,y) return clamp((400-y)/100,0,1) end}, {mist_far, function(x,y) return math.max(0, 1-math.abs(y-400)/80) end}, {mist_bright, function(x,y) return clamp((y-400)/80,0,1) end}}
work(rect(0,250,1000,300), {hand="broad", piles=piles, angle=0, coverage=3.5, load=1.0, fill=true, clip=true, angle_jitter=0.04, tool={kind="filbert", width=22, lay=1.6}})
blend(rect(0,250,1000,300), {angle=0, tool={kind="badger", width=60}})
R1 = line({{-5,352},{120,346},{260,356},{380,349},{470,358},{560,352},{690,343},{800,350},{900,341},{1005,348}}, 6, 2.5, 21)
ridge1 = pile{{"lead white", 4}, {"smalt", 2}, {"cobalt blue", 0.3}, {"rose madder", 0.4}, {"raw umber", 0.35}, name="ridge1"}
local q = {}
for _, p in ipairs(R1) do q[#q+1] = p end
q[#q+1] = {1005, 400}; q[#q+1] = {-5, 400}
local m = poly(q)
-- fade toward the base: a mask that is full at the crest and dies by y=395
local fade = m:times(function(x, y) return clamp((400 - y) / 30, 0, 1) end)
-- left half: wet into wet, edge firm, then blend the base only
work(fade * rect(0,0,500,714), {hand="body", pile=ridge1, angle=0, coverage=2.5, fill=true, clip=m, load_at=function(x,y) return clamp((400-y)/40, 0.15, 1) end})
blend(rect(0, 372, 500, 40), {angle=0, tool={kind="badger", width=30}})
print(drying(300,360))

--@ chunk 3
print(wait(4*24*60), drying(700, 300), drying(700, 380), drying(700, 500))
local q = {}
for _, p in ipairs(R1) do q[#q+1] = p end
q[#q+1] = {1005, 400}; q[#q+1] = {-5, 400}
local m = poly(q)
local fade = m:times(function(x, y) return clamp((400 - y) / 30, 0, 1) end)
work(fade * rect(500,0,500,714), {hand="body", pile=ridge1, angle=0, coverage=2.5, fill=true, clip=m, load_at=function(x,y) return clamp((400-y)/40, 0.15, 1) end})
blend(rect(500, 372, 500, 40), {angle=0, tool={kind="badger", width=30}})

--@ chunk 4
ridge1b = pile{{"lead white", 3}, {"smalt", 2.5}, {"cobalt blue", 0.4}, {"rose madder", 0.45}, {"raw umber", 0.5}, name="ridge1b"}
ridge2 = pile{{"lead white", 2}, {"smalt", 2.5}, {"cobalt blue", 0.4}, {"rose madder", 0.4}, {"raw umber", 0.9}, {"Prussian blue", 0.1}, name="ridge2"}
local R1b = {}
for _, p in ipairs(R1) do R1b[#R1b+1] = {p[1], p[2] + 70} end
local q = {}
for _, p in ipairs(R1b) do q[#q+1] = p end
q[#q+1] = {1005, 500}; q[#q+1] = {-5, 500}
local m = poly(q)
work(m * rect(0,0,500,714), {hand="body", pile=ridge1b, angle=0, coverage=2.5, fill=true, clip=m})
work(m * rect(500,0,500,714), {hand="body", pile=ridge2, angle=0, coverage=2.5, fill=true, clip=m})

--@ chunk 5
for i=1,8 do print(wait(24*60), drying(700, 300), drying(700, 380), drying(700, 470)) end

--@ chunk 6
local R1c = {}
for _, p in ipairs(R1) do R1c[#R1c+1] = {p[1], p[2] - 50} end
local q = {}
for _, p in ipairs(R1c) do q[#q+1] = p end
q[#q+1] = {1005, 340}; q[#q+1] = {-5, 340}
local m = poly(q)
work(m * rect(0,0,500,714), {hand="body", pile=ridge1b, angle=0, coverage=2.5, fill=true, clip=m})
work(m * rect(500,0,500,714), {hand="body", pile=ridge2, angle=0, coverage=2.5, fill=true, clip=m})

--@ chunk 7
for i=1,8 do local t = wait(24*60); if drying(300, 290) == "dry" and drying(700,290)=="dry" then print("dry at", t) break end end
mist_veil = pile{{"lead white", 8}, {"smalt", 0.7}, {"rose madder", 0.15}, {"Naples yellow", 0.3}, thinner=0.5, name="mist_veil"}
-- band mask at the ridge's base: full at y 330, fading upward to 300
local band = mask(function(x, y) return clamp((y - 298) / 32, 0, 1) * clamp((345 - y)/10, 0, 1) end)
work(band * rect(0,0,500,714), {hand="glaze", pile=mist_veil, angle=0, coverage=1.5, clip=band})
work(band * rect(500,0,500,714), {hand="scumble", pile=mist_veil, angle=0, coverage=1.5, clip=band})

--@ chunk 8
local band = mask(function(x, y) return clamp((y - 298) / 32, 0, 1) * clamp((345 - y)/10, 0, 1) end)
mist_veil3 = pile{{"lead white", 8}, {"smalt", 0.7}, {"rose madder", 0.15}, {"Naples yellow", 0.3}, thinner=0.3, name="mist_veil3"}
local A = band * rect(0,0,330,714)
local B = band * rect(330,0,330,714)
local C = band * rect(660,0,340,714)
work(A, {hand="glaze", pile=mist_veil, angle=0, coverage=4, clip=A, pressure={0.4,0.6}})
work(B, {hand="body", pile=mist_veil3, angle=0, coverage=2, clip=B, load=0.4, tool={kind="filbert", width=12}})
stipple(C, {pile=mist_veil3, width=4, coverage=function(x,y) return 3*clamp((y-298)/32,0,1) end, feather=0.5, clip=C})

--@ chunk 9
wait(14*24*60)
print(drying(300, 450), drying(700, 520))
-- graded ridge over dry mist: crest color to mist color at foot
local R = {}
for _, p in ipairs(R1) do R[#R+1] = {p[1], p[2] + 160} end
local q = {}
for _, p in ipairs(R) do q[#q+1] = p end
q[#q+1] = {1005, 600}; q[#q+1] = {-5, 600}
local m = poly(q)
local function crest(x) local best = 1e9; for _, p in ipairs(R) do if math.abs(p[1]-x) < 4 then best = math.min(best, p[2]) end end; return best end
local piles = {{ridge1b, function(x,y) return clamp(1 - (y - 505)/45, 0, 1) end}, {mist_bright, function(x,y) return clamp((y - 505)/45, 0, 1) end}}
work(m * rect(0,0,500,714), {hand="body", pile=ridge1b, piles=piles, angle=0, coverage=3, fill=true, clip=m})
blend(m * rect(0,0,500,714), {angle=0, tool={kind="badger", width=40}})
work(m * rect(500,0,500,714), {hand="body", piles=piles, angle=0, coverage=3, fill=true, clip=m})
print("ok")
