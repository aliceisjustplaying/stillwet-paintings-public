local refl = pile{{"raw umber",1},{"green earth",0.5},{"smalt",0.35},{"lead white",0.5},{"bone black",0.1}, medium=0.15}
local rf = brush{kind="flat", width=1.5, stiffness=0.5}
local N = #creek_line
for i=2,N-1 do
  local p, a, b = creek_line[i], creek_line[i-1], creek_line[i+1]
  local tx, ty = b[1]-a[1], b[2]-a[2]; local l = math.sqrt(tx*tx+ty*ty); tx, ty = tx/l, ty/l
  local nx, ny = -ty, tx
  local y = p[2]
  if y > 470 then
    local w = 1 + 0.5*(y-441)
    local k = (y-441)/280
    for side=-1,1,2 do
      local ex, ey = p[1] + side*nx*w/2, p[2] + side*ny*w/2
      -- dark reflection just inside the water
      if math.random() < 0.7 then
        rf:reload(refl, 0.45)
        local ix, iy = ex - side*nx*(1+3*k), ey - side*ny*(1+3*k)
        local len = 3 + 14*k
        rf:stroke({{ix - len*0.5, iy}, {ix + len*0.5, iy + rand(-0.5,0.5)}}, {pressure={0.4,0.2}})
      end
      -- tufts on the bank, leaning a bit toward the water
      if math.random() < 0.8 then
        local lean = -side*nx*0.35
        local bb = brush{kind="rigger", width=1.0+2.2*k, point=1}
        local pl = (math.random()<0.5) and gr_dk or gr_olive
        bb:load(pl, 0.75)
        local L = 4 + 32*k
        for j=1,math.random(3,6) do
          local ang = -math.pi/2 + lean + randn(0,0.3)
          blade(bb, ex + side*nx*rand(0.5,3) + rand(-2,2), ey + side*ny*rand(0.5,3) + rand(0,2), L*rand(0.6,1.2), ang, randn(0, L*0.15), rand(0.5,0.85))
          if bb:fullness() < 0.2 then bb:load(pl, 0.6) end
        end
      end
    end
  end
end
