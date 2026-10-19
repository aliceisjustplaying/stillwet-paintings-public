-- keep-out for the two horses and the load (same outlines as painted, used only to protect them)
local function hbody(dx, dy)
  local pts = {{563,515},{565,513},{575,514},{583,511},{587,507},{590,503},{591,500.5},{592,502},{594,504},{597,510},{596,511.5},{593,511},{590,510},{588,514},{588,518},{583,521.5},{568,521.5},{563.5,519}}
  local o = {} for i, q in ipairs(pts) do o[i] = {q[1] + dx, q[2] + dy} end
  return poly(o, true)
end
horses_keep = (hbody(0,0) + hbody(3.5,-1.2) + rect(560, 515, 32, 20)):grow(0.6) + load_m:grow(1) + rect(530, 480, 18, 20)
-- a fan-shaped pollard crown: spiky top of rods, rounder shoulders
function pollard_mask(kx, ky, H, Wd, seed)
  local pts = {{kx - 2, ky + 1}}
  local n = 15
  for k = 0, n do
    local t = k / n                      -- left to right over the top
    local a = math.pi * (1 - t)          -- 180 .. 0 degrees
    local rx = Wd * 0.5 * math.cos(a)
    local ry = H * (0.62 + 0.38 * math.sin(a))
    local spike = (k % 2 == 0) and 1 or 0.86
    local r = spike * (1 + 0.08 * math.sin(seed * 3.1 + k * 1.7))
    pts[#pts+1] = {kx + rx * r, ky - (ry * r) * (0.55 + 0.45 * math.sin(a)) - H * 0.25 * math.sin(a)}
  end
  pts[#pts+1] = {kx + 2, ky + 1}
  return poly(pts, false):roughen(1.0, 3, seed)
end
function paint_pollard(kx, ky, H, Wd, seed, keep)
  local m = pollard_mask(kx, ky, H, Wd, seed) - (keep or rect(0,0,1,1))
  local fan = function(x, y) return -math.pi/2 + clamp((x - kx) / (Wd * 0.5), -1, 1) * 0.55 end
  work(m, {hand="hatch", pile=wMid, tool={kind="round", width=1.5, point=0.8}, angle=fan, length={3,8}, coverage=2.2, pressure={0.45,0.7}, ramps={0.1,0.6}, clip=m, fill=true, seed=seed})
  local sh = m * mask(function(px, py) local u = (px - kx)/Wd*0.9 + (py - (ky - H*0.55))/H*0.8 return u > 0.08 and 1 or 0 end)
  work(sh, {hand="hatch", pile=wSh, tool={kind="round", width=1.4, point=0.8}, angle=fan, length={3,7}, coverage=1.3, pressure={0.4,0.65}, ramps={0.1,0.6}, clip=m, clump=0.5, seed=seed+1})
  local hi = m * mask(function(px, py) local u = (px - kx)/Wd*0.9 + (py - (ky - H*0.55))/H*0.8 return u < -0.2 and 1 or 0 end)
  work(hi, {hand="hatch", pile=wHi, tool={kind="round", width=1.2, point=0.9}, angle=fan, length={2,6}, coverage=0.8, pressure={0.35,0.55}, ramps={0.1,0.6}, clip=m, clump=0.6, seed=seed+2})
  -- a few dark rods seen in the crown's lower half
  local rod = brush{kind="rigger", width=1.0, point=1}
  rod:load(wDk, 0.6)
  for k = 1, 9 do
    local u = rand(-0.8, 0.8)
    local a = -math.pi/2 + u * 0.55
    local L = H * rand(0.35, 0.6)
    local p0 = {kx + u * 2, ky}
    local p1 = {kx + u*2 + L*math.cos(a), ky + L*math.sin(a)}
    if not keep or keep:at(p1[1], p1[2]) < 0.5 then
      rod:stroke({p0, p1}, {pressure={0.6, 0.05}, ramps={0.05, 0.7}, clip=m})
    end
  end
  return m
end
-- willow no. 1, rebuilt behind the horses
local kx, ky = 577.5, 496.5
local m1 = paint_pollard(kx, ky, 35, 37, 301, horses_keep)
local tb = brush{kind="round", width=3.2, point=0.3}
tb:load(wTg, 0.6)
tb:stroke({{kx - 1.2, 514}, {kx - 1.4, 503}, {kx - 1.0, ky + 0.5}}, {pressure={0.8, 0.75}, clip=-horses_keep})
tb:load(wTd, 0.6)
tb:stroke({{kx + 1.6, 514}, {kx + 1.5, 503}, {kx + 1.3, ky + 0.8}}, {pressure={0.6, 0.55}, clip=-horses_keep})
tb:touch(kx, ky + 0.3, {pressure=0.9, clip=-horses_keep})
willow1_head = m1
print(wait(0))
