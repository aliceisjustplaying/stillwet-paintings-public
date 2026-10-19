function strips(t0, t1, p, b, y0, y1, n, opt)
  opt = opt or {}
  local clipm = opt.clip or jugBody:grow(1)
  for s = 0, n - 1 do
    local t = lerp(t0, t1, (s + 0.5) / n) + rand(-0.008, 0.008)
    local y = y0 + rand(0, 10)
    while y < y1 do
      local len = rand(45, 90)
      local pts = {}
      local yy = y
      while yy <= math.min(y + len, y1) do
        pts[#pts+1] = {lerp(edgeX(jugL, yy), edgeX(jugR, yy), t), yy}
        yy = yy + 6
      end
      if #pts >= 2 then
        b:reload(p, opt.load or 0.7)
        b:stroke(pts, {pressure=opt.pressure or {0.6, 0.45}, ramps={0.15, 0.3}, orient="across", clip=clipm})
      end
      y = y + len * rand(0.75, 0.95)
    end
  end
end
jDark = pile{{"lead white",1.5},{"raw umber",1},{"green earth",0.7},{"bone black",0.35},{"yellow ochre",0.3}}
local b = brush("filbert", 10)
strips(0.68, 0.9, jDark, b, 215, 600, 5)
strips(0.60, 0.70, jp[5], b, 205, 600, 3)
strips(0.50, 0.61, jp[4], b, 200, 600, 3)
