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
R1 = line({{-5,352},{120,346},{260,356},{380,349},{470,358},{560,352},{690,343},{800,350},{900,341},{1005,348}}, 6, 2.5, 21)
R2 = line({{-5,292},{70,276},{170,266},{240,272},{310,293},{360,302},{430,330},{500,357},{560,378},{610,392}}, 5, 3, 22)
R3 = line({{420,462},{470,458},{520,450},{580,438},{650,423},{720,410},{790,396},{860,390},{930,377},{1005,372}}, 5, 3, 23)
FG = line({{-5,474},{30,466},{75,458},{110,466},{160,486},{230,494},{310,497},{390,498},{450,497},{500,496},{535,499},{555,508},{570,530},{582,570},{595,630},{606,720}}, 5, 2.5, 24)
function closed_below(pts, bottom)
  local q = {}
  for _, p in ipairs(pts) do q[#q+1] = p end
  q[#q+1] = {pts[#pts][1], bottom}; q[#q+1] = {pts[1][1], bottom}
  return poly(q)
end
local function gp(v, c)
  local t = {{"lead white", v + 0.001}, {"bone black", 1 - v + 0.001}}
  if c and c > 0 then t[#t+1] = {"smalt", c} end
  return pile(t)
end
local function fill(m, p) work(m, {hand="body", pile=p, coverage=2.5, fill=true, clip=true, angle=0}) end
fill(rect(0,0,1000,170), gp(0.45, 0.6))
fill(rect(0,170,1000,110), gp(0.8, 0.3))
fill(rect(0,280,1000,90), gp(0.65, 0.4))
fill(closed_below(R1, 420), gp(0.55, 0.4))
fill(closed_below(R2, 420), gp(0.42, 0.4))
fill(rect(0, 395, 1000, 330), gp(0.7, 0.3))
fill(closed_below(R3, 470), gp(0.3, 0.4))
fill(rect(0, 465, 1000, 260), gp(0.66, 0.3))
local q = {}
for _, p in ipairs(FG) do q[#q+1] = p end
q[#q+1] = {-5, 720}
fill(poly(q), gp(0.1, 0))
local spr = {{650,520,0.15},{700,468,0.12},{748,446,0.1},{800,482,0.14},{852,452,0.1},{905,495,0.15},{958,462,0.12},{620,600,0.12}}
for _, s in ipairs(spr) do
  local x, y, v = s[1], s[2], s[3]
  fill(poly({{x, y}, {x+28, y+190}, {x-28, y+190}}), gp(v + 0.05, 0.2))
end
fill(poly({{478,419},{484,422},{485,430},{491,436},{493,470},{486,498},{470,498},{463,470},{465,436},{472,430},{472,422}}), gp(0.05,0))
fill(ellipse(604,300,15,15), pile{{"lead white", 6}, {"Naples yellow", 1}})
print("ok")
