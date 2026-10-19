print(wait(30*60)); print(drying(640,470), drying(700,470))
shade_pollard(willow1_head, 577.5, 496.5, 35, 37, 611, horses_keep)
for i = 2, 9 do
  local w, nh = willows[i], new_heads[i]
  shade_pollard(nh.m, w.kx, w.ky, nh.H, nh.Wd * 1.1, 620 + i, elder2:grow(1))
end
print(wait(0))
