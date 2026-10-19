wait(24*60)
-- the far wood on the plain, right of center: a low dark band, hazed by the evening
WOODTOP = {{548,471},{566,462},{590,457},{612,452},{640,449},{668,445},{700,447},{730,441},{760,444},{792,438},{826,442},{860,436},{900,440},{940,437},{975,442},{1010,440}}
wood = fir_wood{skyline=outline{pts=WOODTOP, open=true, char="soft", lobe=6, seed=61}, foot=474,
  depth=2, count=46, recede=0.6, air=0.5, seed=62}
print(wood)
air = "#9d9aa6"
for r = 2, 1, -1 do
  local hz, s, nd = wood:haze(r), wood:scale(r), wood:needles(r)
  local base = mix("#3a4046", air, 0.35 + 0.35 * hz)
  work(nd, {hand="hatch", tool="round 0.9", length={1.5, 4}, coverage=2.6, clip=nd, angle=1.57, angle_jitter=0.4, color=base})
  local rb = brush("rigger", 0.5)
  for n, f in ipairs(wood:trees(r)) do
    if n % 6 == 1 then rb:reload(mix("#34373a", air, 0.4 + 0.3 * hz), 0.8) end
    rb:stroke(f.leader.pts, {pressure={0.8, 0.1}, ramps={0.02, 0.4}})
  end
end
