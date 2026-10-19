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
R1 = line({{-5,352},{120,346},{260,356},{380,349},{470,358},{560,352},{690,343},{800,350},{900,341},{1005,348}}, 6, 2.5, 21)
R2 = line({{-5,292},{70,276},{170,266},{240,272},{310,293},{360,302},{430,330},{500,357},{560,378},{610,392}}, 5, 3, 22)
R3 = line({{470,458},{520,450},{580,438},{650,423},{720,410},{790,396},{860,390},{930,377},{1005,372}}, 5, 3, 23)
FG = line({{-5,452},{40,446},{95,462},{150,486},{220,498},{300,503},{380,506},{450,508},{520,512},{560,520},{590,548},{612,600},{630,660},{640,720}}, 5, 2.5, 24)
local function closed_below(pts, bottom)
  local q = {}
  for _, p in ipairs(pts) do q[#q+1] = p end
  q[#q+1] = {pts[#pts][1], bottom}; q[#q+1] = {pts[1][1], bottom}
  return poly(q)
end
local g = function(v) return pile{{"lead white", v}, {"bone black", 1-v}} end
sky = everywhere()
local p1 = pile{{"lead white", 3}, {"smalt", 2}, {"rose madder", 0.3}}
work(rect(0,0,1000,360), {hand="broad", pile=p1, coverage=2, fill=true, clip=true, angle=0})
work(closed_below(R1, 420), {hand="body", pile=pile{{"lead white", 3}, {"smalt", 2}, {"raw umber", 0.5}}, coverage=2, fill=true, clip=true, angle=0})
work(closed_below(R2, 420) , {hand="body", pile=pile{{"lead white", 2}, {"smalt", 2}, {"raw umber", 0.8}}, coverage=2, fill=true, clip=true, angle=0})
work(rect(0, 400, 1000, 80), {hand="body", pile=pile{{"lead white", 4}, {"smalt", 1}, {"rose madder", 0.2}}, coverage=2, fill=true, clip=true, angle=0})
work(closed_below(R3, 470) , {hand="body", pile=pile{{"lead white", 1}, {"smalt", 2}, {"raw umber", 1.2}, {"Prussian blue", 0.2}}, coverage=2, fill=true, clip=true, angle=0})
work(rect(0, 460, 1000, 260), {hand="body", pile=pile{{"lead white", 3}, {"smalt", 1}, {"rose madder", 0.2}}, coverage=2, fill=true, clip=true, angle=0})
local fgm = closed_below(FG, 720) + rect(0, 452, 1, 270)
local q = {}
for _, p in ipairs(FG) do q[#q+1] = p end
q[#q+1] = {0, 720}
work(poly(q), {hand="body", pile=pile{{"raw umber", 3}, {"bone black", 1}, {"Prussian blue", 0.3}}, coverage=2, fill=true, clip=true, angle=0})
print("ok")
