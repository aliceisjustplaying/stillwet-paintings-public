-- broaden the tops: two lesser fans off-center, so each crown ends in a broad broom, not a single point
local keep = elder2:grow(1)
local f = {nil, {0.85, 0.72}, {0.8, 0.9}, {0.9, 0.75}, {0.92, 0.85}, {0.78, 0.88}, {0.9, 0.8}, {0.82, 0.9}, {0.9, 0.8}}
local all_heads = {willow1_head}
for i = 2, 9 do
  local w, nh = willows[i], new_heads[i]
  local a = f[i]
  local mL = paint_pollard(w.kx - nh.Wd * 0.17, w.ky - nh.H * 0.1, nh.H * a[1] * 0.9, nh.Wd * 0.62, 500 + i, keep)
  local mR = paint_pollard(w.kx + nh.Wd * 0.17, w.ky - nh.H * 0.1, nh.H * a[2] * 0.9, nh.Wd * 0.62, 520 + i, keep)
  nh.m = nh.m + mL + mR
end
-- willow 1 too
local mL = paint_pollard(577.5 - 6, 496.5 - 3, 27, 22, 541, horses_keep)
local mR = paint_pollard(577.5 + 6.5, 496.5 - 3, 30, 22, 542, horses_keep)
willow1_head = willow1_head + mL + mR
print(wait(0))
