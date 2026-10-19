local jb = jugBody:grow(1)
local Z = jb * mask(function(x,y) if y < 200 then return 0 end; return smoothstep(0.4, 0.52, jT(x,y)) end)
local core = pile{{"lead white",1},{"raw umber",0.9},{"yellow ochre",0.3},{"bone black",0.15}}
local half = pile{{"lead white",2},{"raw umber",0.6},{"yellow ochre",0.3},{"bone black",0.05}}
local refl = pile{{"lead white",1.6},{"raw umber",0.5},{"yellow ochre",0.6},{"red earth",0.1}}
local b = brush("filbert", 12)
local function band(t0, t1, p, n, load)
  for k = 0, n-1 do
    local t = t0 + (t1 - t0) * (k + 0.5) / n
    local pts = {}
    for y = 208, 600, 14 do
      local xl, xr = edgeX(jugL, y), edgeX(jugR, y)
      pts[#pts+1] = {xl + (xr - xl) * t, y}
    end
    b:reload(p, load)
    b:stroke(pts, {pressure={0.6,0.6}, ramps={0.05,0.1}, orient="across", clip=Z})
  end
end
band(0.5, 0.62, half, 3, 0.6)
band(0.62, 0.88, core, 5, 0.7)
band(0.88, 0.99, refl, 2, 0.55)
blend(Z, {angle=1.5708, tool={kind="badger", width=16}})
