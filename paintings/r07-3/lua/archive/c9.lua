-- the far shore and the town against the glow: dark and cool at the top, lost into the mist on the water
farpal = pal:only{"lead white", "pale smalt", "cobalt blue", "raw umber", "bone black", "red earth", "yellow ochre"}
local base = HZ + 2
local shoreP = {}
for _, p in ipairs(SHORE) do shoreP[#shoreP+1] = {p[1], p[2]} end
shoreP[#shoreP+1] = {1005, base}; shoreP[#shoreP+1] = {-5, base}
landM = poly(shoreP)
TOWN2 = {}
for _, p in ipairs(TOWN) do
  if p[1] < 486 or p[1] > 514 then TOWN2[#TOWN2+1] = p
  elseif p[1] == 488 and p[2] == 403 then
    for _, q in ipairs({{491,403},{491,372},{490,371},{490,367},{493,366},{493,362},{500,329},{507,362},{507,366},{510,367},{510,371},{509,372},{509,403}}) do TOWN2[#TOWN2+1] = q end
  end
end
local townP = {}
for _, p in ipairs(TOWN2) do townP[#townP+1] = {p[1], p[2]} end
townP[#townP+1] = {TOWN2[#TOWN2][1], base}; townP[#townP+1] = {TOWN2[1][1], base}
townM = poly(townP)
-- low groves on the shore, drawn by a soft hand, none alike
GROVES = {
  outline{pts={{112,428},{118,421},{128,418},{141,419},{150,416},{162,420},{168,427}}, open=true, char="soft", lobe=5, seed=61},
  outline{pts={{300,423},{306,416},{318,414},{331,415},{338,419},{352,418},{360,421}}, open=true, char="soft", lobe=4, seed=62},
  outline{pts={{672,422},{680,416},{694,413},{708,416},{716,414},{730,418},{742,424}}, open=true, char="soft", lobe=5, seed=63},
  outline{pts={{880,428},{888,423},{899,422},{906,425}}, open=true, char="soft", lobe=3, seed=64},
}
groveM = nil
for _, o in ipairs(GROVES) do local m = o:below(base); groveM = groveM and (groveM + m) or m end
local farcol = function(x, y)
  local t = smoothstep(398, base, y)
  return mix(mix("#4d4f60", "#5a5a68", smoothstep(330, 400, y)), "#8f8c8f", t * t)
end
-- the land sliver and groves: short level strokes of a small filbert
work(landM + groveM, {hand="detail", tool="filbert 3", angle=0, angle_jitter=0.15, length={4, 14}, coverage=4, medium=0.25, pal=farpal,
  color=farcol, edge={found=0.3, soft=0.5, lost=0.2, period=30, seed=65}})
-- the town: roofs level, the tower upright, found against the light
work(townM, {hand="detail", tool="round 1.2", angle=function(x, y) return (x > 488 and x < 512) and 1.57 or 0.05 end,
  length={3, 10}, coverage=3.6, medium=0.2, pal=farpal, color=farcol, edge={found=0.8, soft=0.2, period=25, seed=66}})
blend(landM + groveM + townM, {angle=0, coverage=0.8, clip=true})
local t = timesheet(); print(string.format("sitting %.0f min", t.sitting))
