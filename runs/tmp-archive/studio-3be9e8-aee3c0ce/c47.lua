lp = {
  pile{{"yellow ochre",2},{"raw umber",1.1},{"green earth",0.7},{"chrome yellow",0.5}},
  pile{{"yellow ochre",2},{"chrome yellow",1.2},{"raw umber",0.4},{"green earth",0.3}},
  pile{{"chrome yellow",3},{"yellow ochre",1}},
  pile{{"chrome yellow",3},{"lead white",0.6}},
  pile{{"chrome yellow",2},{"lead white",2.2}},
}
function lemonPaint(cx, cy, rx, ry, rot, clipm, b, step)
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
    local nz = math.sqrt(w)
    local d = u*Lx + v*Ly + nz*Lz
    local k
    if d < 0.12 then k = 1 elseif d < 0.35 then k = 2 elseif d < 0.62 then k = 3 elseif d < 0.85 then k = 4 else k = 5 end
    if v > 0.75 and k <= 2 and u > -0.5 then k = 2 end
    return k
  end
  local segs = {}
  local v = -0.97
  while v < 0.97 do
    local vv = v + rand(-0.03, 0.03)
    local umax = math.sqrt(math.max(0, 1 - vv*vv)) + 0.05
    local cur, pts = nil, {}
    local u = -umax
    while u <= umax do
      local k = idx(u + rand(-0.04,0.04), vv)
      if k ~= cur or #pts > 5 then
        if cur and #pts >= 2 then segs[#segs+1] = {k=cur, pts=pts} end
        pts = (#pts > 0) and {pts[#pts]} or {}
        cur = k
      end
      pts[#pts+1] = P(u, vv)
      u = u + 0.1
    end
    if cur and #pts >= 2 then segs[#segs+1] = {k=cur, pts=pts} end
    v = v + step
  end
  for k = 1, 5 do
    for _, sg in ipairs(segs) do
      if sg.k == k then
        b:reload(lp[k], 0.7)
        b:stroke(sg.pts, {pressure={0.6, 0.5}, ramps={0.15, 0.3}, orient="across", clip=clipm})
      end
    end
  end
  return #segs
end
local b = brush("filbert", 7)
print(lemonPaint(722, 553, 68, 38, 0.05, lemon2:grow(1) - lemon1, b, 0.13))
print(lemonPaint(610, 592, 78, 47, -0.08, lemon1:grow(1), b, 0.11))
