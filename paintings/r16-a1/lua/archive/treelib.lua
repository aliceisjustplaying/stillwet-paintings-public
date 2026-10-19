function tree_new(cx, spread, o) return {limbs={}, cx=cx, spread=spread, o=o} end
function tree_grow(T, x, y, ang, len, w, order, dead, depthcap)
  local o = T.o
  local pts, ws = {{x,y}}, {w}
  local travelled, side = 0, (math.random()<0.5) and 1 or -1
  local seg = math.max(2.5, math.min(o.seglen, len/3.5))
  local nodes = 0
  while travelled < len and w >= o.wmin do
    local s = seg * rand(0.7, 1.3)
    ang = ang + randn(0, o.zig)
    local tgt = -math.pi/2 + clamp((x - T.cx)/T.spread, -1, 1) * o.fan
    if order >= o.droop_order then tgt = tgt + o.droop * (tgt > -math.pi/2 and 1 or -1) end
    ang = ang + (tgt - ang) * o.trop
    x = x + s*math.cos(ang); y = y + s*math.sin(ang)
    travelled = travelled + s
    w = w * (1 - o.taper*s/len)
    pts[#pts+1] = {x, y}; ws[#ws+1] = w
    nodes = nodes + 1
    local canbranch = not (dead and order >= 3) and (depthcap == nil or order < depthcap)
    if canbranch and travelled < len*0.97 and math.random() < o.branchp and w > o.wmin*1.25 then
      local cw = w * rand(o.cmin, o.cmax)
      local nw = math.sqrt(math.max(w*w - cw*cw*0.9, o.wmin^2))
      side = -side
      local ca = ang + side*rand(0.4, 1.05)
      local clen = (len - travelled)*rand(0.5, 0.9) + len*0.12
      tree_grow(T, x, y, ca, clen, cw, order+1, dead, depthcap)
      w = nw
      ang = ang - side*rand(0.05, 0.3)
    end
  end
  T.limbs[#T.limbs+1] = {pts=pts, ws=ws, order=order, dead=dead}
end
-- add a hand-placed limb (explicit polyline + widths) and sprout branches along it
function tree_main(T, pts, ws, order, dead, sprout)
  T.limbs[#T.limbs+1] = {pts=pts, ws=ws, order=order, dead=dead, main=true}
  if sprout then
    for i=2,#pts do
      local a, b = pts[i-1], pts[i]
      local ang = math.atan(b[2]-a[2], b[1]-a[1])
      local nb = sprout.n or 1
      for k=1,nb do
        if math.random() < (sprout.p or 0.8) then
          local t = rand(0.2, 1)
          local x, y = lerp(a[1],b[1],t), lerp(a[2],b[2],t)
          local w = lerp(ws[i-1], ws[i], t)
          local side = (math.random()<0.5) and 1 or -1
          local cw = w * rand(sprout.cmin or 0.3, sprout.cmax or 0.6)
          tree_grow(T, x, y, ang + side*rand(0.5,1.1), sprout.len * rand(0.6,1.1), cw, order+1, dead)
        end
      end
    end
    -- continue from the tip
    local a, b = pts[#pts-1], pts[#pts]
    if not dead and sprout.tip then
      tree_grow(T, b[1], b[2], math.atan(b[2]-a[2], b[1]-a[1]), sprout.tip, ws[#ws], order, dead)
    end
  end
end
function tree_stats(T)
  local n, x0, y0, x1, y1 = 0, 1e9, 1e9, -1e9, -1e9
  for _,l in ipairs(T.limbs) do n = n + #l.pts; for _,p in ipairs(l.pts) do x0=math.min(x0,p[1]); x1=math.max(x1,p[1]); y0=math.min(y0,p[2]); y1=math.max(y1,p[2]) end end
  return string.format("limbs %d pts %d box %.0f,%.0f - %.0f,%.0f", #T.limbs, n, x0,y0,x1,y1)
end
-- the thick parts as one mask
function tree_thick_mask(T, wthr)
  local m
  for _,l in ipairs(T.limbs) do
    if l.ws[1] >= wthr then
      local r = ribbon(l.pts, l.ws)
      m = m and (m + r) or r
    end
  end
  return m
end
-- paint the thin limbs as strokes; filter(l) picks which
function tree_paint_thin(T, p, wthr, filter, loadv)
  local bm = brush{kind="round", width=4, point=1}
  local bt = brush{kind="rigger", width=2, point=1}
  bm:load(p, 0.8); bt:load(p, 0.8)
  local n = 0
  for _,l in ipairs(T.limbs) do
    if l.ws[1] < wthr and (filter == nil or filter(l)) and #l.pts >= 2 then
      local b = (l.ws[1] > 1.6) and bm or bt
      if b:fullness() < 0.35 then b:load(p, loadv or 0.7) end
      local p0 = b:pressure_for(math.max(l.ws[1], 0.6))
      local p1 = b:pressure_for(math.max(l.ws[#l.ws], 0.6))
      b:stroke(l.pts, {pressure={p0, p1*0.6}, ramps={0.02, 0.25}, shake=0.3})
      n = n + 1
    end
  end
  return n
end
