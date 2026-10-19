-- shadow into the land: the foreground dusk, soft undulations across the snow, and the oak's faint long shadow
landShade2 = pile{{"smalt",1.5},{"Prussian blue",0.3},{"bone black",0.35},{"red earth",0.25},{"raw umber",0.1}, medium=0.9}
local un = noise{seed=851, period=90, octaves=3, kind="billow", stretch={0.08, 4}}
local nn = noise{seed=852, period=60, octaves=2}
local function segd(px, py, ax, ay, bx, by)
  local vx, vy = bx - ax, by - ay
  local t = clamp(((px - ax) * vx + (py - ay) * vy) / (vx * vx + vy * vy), 0, 1)
  return math.sqrt((px - ax - t * vx)^2 + (py - ay - t * vy)^2), t
end
local m = landm - merem:grow(1) - figM:grow(1.5) - postM:grow(1.5) - sprMask:grow(2) - oakLive:grow(1) - pathM:shrink(2)
work(m, {hand="glaze", pile=landShade2, angle=0.05, angle_jitter=0.06, clip=true,
   load_at=function(x, y)
     local fg = 0.55 * smoothstep(610, 714, y) ^ 1.2
     local und = 0
     if y > 420 and y < 650 then und = 0.22 * math.max(0, un(x, y) + 0.1) * (0.5 + (y - 420) / 460) end
     local d, t = segd(x, y, 240, 450, 40, 600)
     local sh = 0
     if y > 440 then sh = 0.35 * (1 - smoothstep(4 + 30 * t, 14 + 50 * t, d)) * (1 - 0.6 * t) end
     return (fg + und + sh) * (0.85 + 0.25 * nn(x, y))
   end,
   pressure={0.3, 0.5}, coverage=1.6, seed=853})
