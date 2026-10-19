-- a low far wood on the left of the far bank, bare, a gray-violet mass in the haze
local wl = outline{{-10, HZ-8}, {60, HZ-19}, {120, HZ-14}, {190, HZ-24}, {250, HZ-17}, {320, HZ-21}, {380, HZ-10}, {430, HZ-4}, {460, HZ+1},
  open=true, char="soft", lobe=9, seed=91}
WOOD = wl:below(HZ + 6) * above(function(x) return farbank(x) + 1 end)
work(WOOD, {hand="hatch", tool="round 1.6", length={3, 9}, coverage=2.8, medium=0.2, angle=-1.45, angle_jitter=0.35,
  color=function(x, y) return mix("#8d8790", "#9c9599", 0) end, edge={soft=0.6, lost=0.4, period=30, seed=9}})
