wood = fir_wood{skyline=outline{pts=WOODTOP, open=true, char="soft", lobe=10, seed=31}, foot={{500,461},{650,463},{800,462},{1005,466}},
  depth=3, count=15, horizon=HZ, recede=0.6, air=0.5, seed=32}
print(wood)
woodair = "#bdb3b3"
function woodrow(r)
  local h, s, nd = wood:haze(r), wood:scale(r), wood:needles(r)
  work(nd, {hand="hatch", tool=string.format("round %.1f", math.max(0.9, 1.6 * s)), length={2, 6 * s + 1}, coverage=2.4,
    clip=nd, angle=1.57, angle_jitter=0.5, pal=snowpal, color=mix("#2c3238", woodair, 0.25 + 0.6 * h)})
  local rb = brush("rigger", math.max(0.5, 1.2 * s))
  for n, f in ipairs(wood:trees(r)) do
    if n % 5 == 1 then rb:reload(mix("#262428", woodair, 0.2 + 0.6 * h), 0.85) end
    rb:stroke(f.leader.pts, {pressure={0.8, 0.15}, ramps={0.02, 0.3}})
  end
  if r == 1 then
    local hb = brush("round", 1.8 * s + 0.3)
    wood:paint(hb, r, {color=mix("#1f252a", woodair, 0.2), lit={0, 0.55}})
    wood:paint(hb, r, {color=mix("#4a4c52", woodair, 0.3), lit={0.55, 1}, every=6})
  end
end
woodrow(3); woodrow(2)
local fl = wood:floor():roughen(4, 16, 34, 2)
work(fl, {hand="body", coverage=3, clip=fl, angle=0, hug=false, pal=snowpal,
  color=function(x, y) return mix("#6e6d78", "#a9a7b2", smoothstep(448, 464, y)) end})
woodrow(1)
