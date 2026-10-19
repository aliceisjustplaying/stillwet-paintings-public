lp = {
  pile{{"yellow ochre",2},{"raw umber",1.2},{"green earth",0.7},{"chrome yellow",0.4}},
  pile{{"yellow ochre",2},{"raw umber",0.7},{"green earth",0.4},{"chrome yellow",0.8}},
  pile{{"yellow ochre",1.5},{"chrome yellow",1.5},{"raw umber",0.3},{"green earth",0.2}},
  pile{{"chrome yellow",3},{"yellow ochre",1}},
  pile{{"chrome yellow",3},{"yellow ochre",0.3},{"lead white",0.3}},
  pile{{"chrome yellow",3},{"lead white",1}},
  pile{{"chrome yellow",2},{"lead white",2.5}},
}
local th = {0.05, 0.2, 0.35, 0.5, 0.65, 0.82}
function lemonPaint2(cx, cy, rx, ry, rot, clipm, b, step)
  local Lx, Ly, Lz = -1, -0.75, 0.9
  local ln = math.sqrt(Lx*Lx+Ly*Ly+Lz*Lz); Lx, Ly, Lz = Lx/ln, Ly/ln, Lz/ln
  local c, s = math.cos(rot), math.sin(rot)
  local function P(u, v)
    local x = u * rx
    local y = v * ry + 0.12 * ry * (1 - u*u)
    return {cx + c*x - s*y, cy + s*x + c*y}
  end
  local function idx(u, v)
    local w = math.max(0, 1 - u*u - v*v)
    local d = u*Lx + v*Ly + math.sqrt(w)*Lz + rand(-0.05, 0.05)
    local k = 7
    for i = 1, 6 do if d < th[i] then k = i; break end end
    if v > 0.8 and k < 2 then k = 2 end
    return k
  end
  local segs = {}
  local v = -0.98
  while v < 0.98 do
    local vv = v + rand(-0.02, 0.02)
    local umax = math.sqrt(math.max(0, 1 - vv*vv)) + 0.06
    local cur, pts = nil, {}
    local u = -umax + rand(0, 0.05)
    while u <= umax do
      local k = idx(u, vv)
      if k ~= cur or #pts > 4 then
        if cur and #pts >= 2 then segs[#segs+1] = {k=cur, pts=pts} end
        pts = (#pts > 0) and {pts[#pts]} or {}
        cur = k
      end
      pts[#pts+1] = P(u, vv)
      u = u + 0.08
    end
    if cur and #pts >= 2 then segs[#segs+1] = {k=cur, pts=pts} end
    v = v + step
  end
  for k = 1, 7 do
    for _, sg in ipairs(segs) do
      if sg.k == k then
        b:reload(lp[k], 0.65)
        b:stroke(sg.pts, {pressure={0.55, 0.45}, ramps={0.2, 0.3}, orient="across", clip=clipm})
      end
    end
  end
  return #segs
end
local b = brush("filbert", 7)
print(lemonPaint2(722, 553, 68, 38, 0.05, lemon2:grow(1) - lemon1, b, 0.085))
print(lemonPaint2(610, 592, 78, 47, -0.08, lemon1:grow(1), b, 0.075))
