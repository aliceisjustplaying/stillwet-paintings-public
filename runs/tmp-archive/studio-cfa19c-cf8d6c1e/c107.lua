function horseMask(x, y, L, f)
  local function P(u, v) return {x + f*u*L, y + v*L} end
  local m = poly({P(0.52,-0.52), P(0.3,-0.6), P(0.0,-0.58), P(-0.28,-0.62), P(-0.42,-0.58), P(-0.58,-0.36), P(-0.72,-0.1), P(-0.78,0.0), P(-0.7,0.02), P(-0.62,-0.12), P(-0.46,-0.3), P(-0.34,-0.32), P(0.0,-0.33), P(0.36,-0.33), P(0.5,-0.38)}, true)
  for i,u in ipairs({-0.34, -0.26, 0.36, 0.45}) do
    local du = (i==1 or i==3) and -0.02 or 0.03
    m = m + ribbon({P(u, -0.36), P(u+du*0.5, -0.18), P(u+du, 0.0)}, 0.06*L)
  end
  m = m + ribbon({P(0.52,-0.52), P(0.58,-0.35), P(0.57,-0.15)}, 0.06*L)
  return m:grow(0.8)
end
local mx, my, wx, wy = 328, 573, 344, 577
local function M(u, v) return {mx + u, my - v} end
local function W(u, v) return {wx + u, wy - v} end
figM = (poly({M(-3.6,15.5), M(-3.3,-0.5), M(-0.9,-0.5), M(-0.4,15.5)}) + poly({M(0.6,15.5), M(1.0,-0.5), M(3.4,-0.5), M(3.8,15.5)})
  + poly({M(-2.2,43), M(-5.5,41.8), M(-6.8,39.5), M(-7.4,30), M(-7.8,22), M(-7.2,14.5), M(0,14), M(7.2,14.5), M(7.6,22), M(7.2,30), M(6.8,39.5), M(5.5,41.8), M(2.2,43)}, true)
  + ellipse(mx, my-44, 1.8, 1.4) + ellipse(mx+0.2, my-47, 3.0, 3.5) + ellipse(mx+0.4, my-50, 4.1, 1.9)
  + poly({W(-3.4,31), W(-4.2,24), W(-6.2,12), W(-8.2,1.5), W(-7.5,-0.5), W(7.8,-0.5), W(8.6,1.5), W(6.6,12), W(4.6,24), W(3.8,31)}, true)
  + poly({W(-2,39.5), W(-5.6,37.5), W(-6.4,33), W(-5.2,27), W(0,24.5), W(5.4,27), W(6.4,33), W(5.6,37.5), W(2,39.5)}, true)
  + ellipse(wx, wy-40.2, 1.5, 1.2) + ellipse(wx-0.2, wy-43.2, 2.7, 3.1) + ellipse(wx-0.2, wy-46.2, 1.7, 1.4)):grow(0.7)
horsesM = horseMask(440, 552, 17, -1) + horseMask(515, 566, 18, 1)
print(figM:area(), horsesM:area())
