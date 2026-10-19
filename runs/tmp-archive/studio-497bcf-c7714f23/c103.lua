eD = pile{{"green earth", 2}, {"raw umber", 1.5}, {"Prussian blue", 0.35}, {"yellow ochre", 0.5}, {"bone black", 0.12}, {"lead white", 0.2}, medium=0.1}
eStem = pile{{"raw umber", 1.5}, {"lead white", 0.8}, {"pale smalt", 0.4}, {"bone black", 0.2}, medium=0.1}
elder_br = {
  {{955,716},{945,660},{925,610},{900,575},{878,560}},
  {{960,716},{958,650},{950,590},{940,540},{930,515}},
  {{968,716},{972,640},{975,580},{985,530},{996,500}},
  {{975,716},{990,660},{1000,620},{1010,600}},
  {{950,716},{925,685},{895,660},{868,648}},
  {{958,690},{930,640},{905,625},{886,612}},
}
local rb = brush{kind="round", width=4, point=0.5}
for i, b in ipairs(elder_br) do
  rb:load(eStem, 0.7)
  rb:stroke(b, {pressure={0.9, 0.15}, ramps={0.02,0.5}})
end
eclumps = {}
for i, b in ipairs(elder_br) do
  for k = 2, #b do
    local p, q = b[k-1], b[k]
    for u = 0.2, 1.0, 0.4 do
      local x, y = lerp(p[1], q[1], u), lerp(p[2], q[2], u)
      eclumps[#eclumps+1] = {x = x + rand(-10, 10), y = y + rand(-8, 6), r = rand(10, 17) * (0.8 + 0.4*(y - 480)/230)}
    end
  end
end
local sil
for i, c in ipairs(eclumps) do
  local e = ellipse(c.x, c.y, c.r*1.2, c.r*0.85)
  sil = sil and (sil + e) or e
end
elder = sil:roughen(3, 7, 141) * rect(0, 0, 1000, 714)
stipple(elder, {pile=eD, width=3.2, coverage=4, pressure={0.45,0.75}, clip=elder, cluster=0.3})
print(#eclumps, wait(0))
