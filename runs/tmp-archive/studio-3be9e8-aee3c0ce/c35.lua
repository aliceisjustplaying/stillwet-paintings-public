local jb = jugBody:grow(1)
function jZone(t0, t1, t2, t3, y0, y1)
  return jb * mask(function(x,y)
    if y < y0 or y > y1 then return 0 end
    local t = jT(x,y)
    local ey = smoothstep(y0, y0+25, y) * (1 - smoothstep(y1-25, y1, y))
    return smoothstep(t0, t1, t) * (1 - smoothstep(t2, t3, t)) * ey
  end)
end
local A = jZone(-0.1, 0.0, 0.5, 0.62, 170, 610)
work(A, {hand="scumble", pile=jp[2], clip=A, coverage=1.6, angle=1.5708, angle_jitter=0.3, load=0.5})
local B = jZone(0.1, 0.18, 0.36, 0.46, 250, 520)
work(B, {hand="scumble", pile=jp[1], clip=B, coverage=1.3, angle=1.5708, angle_jitter=0.3, load=0.5})
local C = jZone(0.48, 0.55, 0.66, 0.74, 200, 600)
work(C, {hand="scumble", pile=jp[4], clip=C, coverage=1.2, angle=1.5708, angle_jitter=0.3, load=0.4})
local D = jZone(0.84, 0.92, 1.05, 1.1, 340, 600)
work(D, {hand="scumble", tool="filbert 6", pile=jp[7], clip=D, coverage=1.2, angle=1.5708, angle_jitter=0.3, load=0.35})
