function shade_pollard(m, kx, ky, H, Wd, seed, keep)
  local fan = function(x, y) return -math.pi/2 + clamp((x - kx) / (Wd * 0.5), -1, 1) * 0.55 end
  local sh = m * mask(function(px, py) local u = (px - kx)/Wd*1.0 + (py - (ky - H*0.6))/H*0.9 return smoothstep(-0.05, 0.25, u) end)
  work(sh, {hand="hatch", pile=wDk, tool={kind="round", width=1.5, point=0.8}, angle=fan, length={3,8}, coverage=1.6, pressure={0.45,0.7}, ramps={0.1,0.6}, clip=m, clump=0.5, threshold=0.4, seed=seed})
  local low = m * mask(function(px, py) return smoothstep(ky - H*0.45, ky - H*0.1, py) end)
  work(low, {hand="hatch", pile=wSh, tool={kind="round", width=1.3, point=0.8}, angle=fan, length={3,7}, coverage=1.2, pressure={0.4,0.65}, ramps={0.1,0.6}, clip=m, clump=0.5, threshold=0.4, seed=seed+1})
  local rod = brush{kind="rigger", width=1.2, point=1}
  rod:load(wTd, 0.6)
  for k = 1, 12 do
    local u = rand(-0.9, 0.9)
    local a = -math.pi/2 + u * 0.6
    local L = H * rand(0.3, 0.55)
    local p0 = {kx + u * 1.5, ky + 0.5}
    local p1 = {kx + u*1.5 + L*math.cos(a), ky + 0.5 + L*math.sin(a)}
    rod:stroke({p0, p1}, {pressure={0.7, 0.05}, ramps={0.05, 0.6}, clip=keep and (m - keep) or m})
    if k % 6 == 0 then rod:load(wTd, 0.5) end
  end
  local hi = m * mask(function(px, py) local u = (px - kx)/Wd*1.0 + (py - (ky - H*0.6))/H*0.9 return 1 - smoothstep(-0.45, -0.2, u) end)
  work(hi, {hand="hatch", pile=wHi, tool={kind="round", width=1.1, point=0.9}, angle=fan, length={2,5}, coverage=0.7, pressure={0.35,0.55}, ramps={0.1,0.6}, clip=m, clump=0.7, threshold=0.4, seed=seed+2})
end
shade_pollard(willow1_head, 577.5, 496.5, 35, 37, 311, horses_keep)
print(wait(0))
