-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 6}, {"yellow ochre", 0.35}, {"raw umber", 0.12}}, um=35}}, linen={16, 14}, seed=1774, size=650}

--@ chunk 2
s_top  = pile{{"lead white",1.5},{"smalt",1.2},{"cobalt blue",0.8},{"raw umber",0.12}, name="s_top"}
s_glow = pile{{"lead white",5},{"Naples yellow",1.5},{"yellow ochre",0.25},{"vermilion",0.05}, name="s_glow"}
local sky = rect(0,0,1000,470)
work(sky, {hand="broad", piles={{s_top,function(x,y) return clamp(1-y/400,0,1) end},{s_glow,function(x,y) return clamp(y/400,0,1) end}}, angle=0, ruler=true, coverage=2.2, fill=true, clip=sky, seed=3})
blend(sky, {angle=0})
wait(3*24*60)
local raw = {
  {{{305,548},{304,520},{301,490},{299,455},{300,425},{305,405}}, {58,46,40,37,35,33}},
  {{{292,418},{270,388},{248,372},{224,340},{206,302},{180,283},{161,246},{150,216},{141,188},{147,163}}, {22,18,16,13,11,9,7,5,3.5,2}},
  {{{224,340},{190,346},{161,336},{136,343},{111,331},{91,335}}, {9,7,5.5,4,2.8,1.6}},
  {{{206,302},{216,267},{206,236},{221,202},{213,172}}, {7.5,6,4.5,3,1.8}},
  {{{161,246},{132,240},{116,216},{96,206}}, {5,3.8,2.6,1.4}},
  {{{305,412},{312,372},{305,332},{318,292},{314,252},{326,217},{323,186}}, {25,21,18,15,13,12,11}},
  {{{305,334},{281,302},{272,271},{255,246},{258,216},{246,190}}, {9,7.5,6,4.5,3,1.8}},
  {{{318,292},{345,266},{352,236},{372,216},{378,186}}, {8,6.5,5,3.5,2}},
  {{{323,192},{335,167},{331,142}}, {4,2.8,1.4}},
  {{{316,412},{350,393},{381,388},{411,371},{441,362},{469,341},{501,332},{531,316},{561,311}}, {23,18,15.5,13,10.5,8.5,6,4,2}},
  {{{381,388},{403,404},{430,410},{448,425}}, {6,4.5,3,1.6}},
  {{{411,371},{419,336},{411,301},{426,269},{421,241}}, {8,6.5,5,3.5,2}},
  {{{469,341},{479,311},{501,291},{506,263}}, {5.5,4,3,1.6}},
  {{{501,332},{521,345},{546,346}}, {3.5,2.5,1.3}},
  {{{318,404},{344,361},{360,321},{385,291},{391,251},{410,226},{416,196}}, {16,13,11,9,7,5,3}},
  {{{385,291},{361,266},{356,236}}, {4.5,3.2,1.8}},
  {{{300,457},{276,448},{266,451}}, {15,12,11}},
}
oak = {}
for i, br in ipairs(raw) do
  local pts = {}
  for j, p in ipairs(br[1]) do pts[j] = {p[1], p[2] - 58} end
  oak[i] = {pts, br[2]}
end
oak_roots = {{252,497},{266,489},{279,475},{290,456},{318,456},{328,474},{343,488},{362,498},{330,500},{290,501}}
local tm = nil
for _, br in ipairs(oak) do local r = ribbon(br[1], br[2]); tm = tm and (tm + r) or r end
tm = tm + poly(oak_roots, true)
oak_mask = tm:roughen(1.0, 5, 3)
t_dark = pile{{"raw umber",1.3},{"bone black",0.8},{"Prussian blue",0.1},{"red earth",0.1}, name="t_dark"}
t_warm = pile{{"raw umber",1.6},{"bone black",0.5},{"red earth",0.2},{"yellow ochre",0.1}, name="t_warm"}
local nz = noise{seed=77, period=40}
work(oak_mask, {hand="detail", piles={{t_dark, function(x,y) return 0.6 + 0.4*nz(x,y) end},{t_warm, function(x,y) return 0.4 - 0.4*nz(x,y) end}}, coverage=2.6, fill=true, angle=-math.pi/2, seed=271})
print(wait(2*24*60))

--@ chunk 3
function crooked(x, y, ang, len, w0, w1, jit)
  jit = jit or 0.38
  local pts, ws = {{x,y}}, {w0}
  local n = math.max(3, math.floor(len/9 + 0.5))
  local a = ang
  local cx, cy = x, y
  for i=1,n do
    local seg = len/n * rand(0.75, 1.25)
    a = a + randn(0, jit)
    a = a + 0.35*(ang - a) + 0.05*((-math.pi/2) - a)
    cx, cy = cx + seg*math.cos(a), cy + seg*math.sin(a)
    pts[#pts+1] = {cx, cy}
    ws[#ws+1] = lerp(w0, w1, (i/n)^0.8)
  end
  return pts, ws
end
local function along(pts, ws, fn, spacing, minw)
  local acc = rand(0.3, 1.0)*spacing
  for i=1,#pts-1 do
    local x0,y0,x1,y1 = pts[i][1],pts[i][2],pts[i+1][1],pts[i+1][2]
    local dx,dy = x1-x0, y1-y0
    local d = math.sqrt(dx*dx+dy*dy)
    local la = math.atan(dy, dx)
    local s = acc
    while s < d do
      local t = s/d
      local wl = lerp(ws[i], ws[i+1], t)
      if wl >= minw then fn(x0+dx*t, y0+dy*t, la, wl, i + t) end
      s = s + spacing*rand(0.6, 1.4)
    end
    acc = s - d
  end
end
local function upside(la)
  local s1 = la - math.pi/2
  return (math.sin(s1) < 0) and -1 or 1
end
function grow_crown(limbs, opts)
  local out = {}
  for li, L in ipairs(limbs) do
    along(L[1], L[2], function(x, y, la, wl, pos)
      local side = upside(la); if math.random() < 0.3 then side = -side end
      local a = la + side*rand(0.45, 1.05)
      a = a + 0.25*((-math.pi/2) - a)
      local w0 = math.min(opts.maxw or 6, wl*rand(0.4, 0.6))
      local len = rand(0.7, 1.3) * (opts.len or 45) * math.min(1.5, 0.5 + wl/12)
      local ox, oy = x + math.cos(a)*wl*0.3, y + math.sin(a)*wl*0.3
      local pts, ws = crooked(ox, oy, a, len, w0, 0.9, 0.4)
      out[#out+1] = {pts, ws, level=2}
      -- tertiaries off the distal part
      local k = math.random(1, 3)
      for j=1,k do
        local idx = math.random(math.max(2, #pts-3), #pts-1)
        local p = pts[idx]
        local pa = math.atan(pts[idx+1][2]-p[2], pts[idx+1][1]-p[1])
        local s2 = (math.random()<0.5) and -1 or 1
        local a2 = pa + s2*rand(0.4, 1.0); a2 = a2 + 0.2*((-math.pi/2) - a2)
        local p2, w2 = crooked(p[1], p[2], a2, rand(12, 28), math.max(1.0, ws[idx]*0.7), 0.8, 0.45)
        out[#out+1] = {p2, w2, level=3}
      end
    end, opts.spacing or 34, opts.minw or 3.5)
  end
  return out
end
local limbs = {}
for i=2,16 do limbs[#limbs+1] = oak[i] end
crown = grow_crown(limbs, {spacing=34, len=42, minw=3.5, maxw=6})
print(#crown)
local sm = nil
for _, b in ipairs(crown) do local r = ribbon(b[1], b[2]); sm = sm and (sm + r) or r end
crown_mask = sm:roughen(0.5, 4, 9) - oak_mask
local nz = noise{seed=79, period=40}
work(crown_mask, {hand="detail", piles={{t_dark, function(x,y) return 0.6 + 0.4*nz(x,y) end},{t_warm, function(x,y) return 0.4 - 0.4*nz(x,y) end}}, coverage=2.6, fill=true, seed=301})

--@ chunk 4
rg_s = brush{kind="rigger", width=1.6, point=1}
t_twig = pile{{"raw umber",1.2},{"bone black",0.8},{"Prussian blue",0.08},{"red earth",0.05}, medium=0.15, name="t_twig"}
function fine(x, y, ang, len, pl)
  local pts = {}
  local n = 3
  local cx, cy, a = x, y, ang
  pts[1] = {cx, cy, 0.42}
  for i=1,n do
    local seg = len/n * rand(0.7, 1.3)
    a = a + randn(0, 0.4); a = a + 0.15*((-math.pi/2) - a)
    cx, cy = cx + seg*math.cos(a), cy + seg*math.sin(a)
    pts[#pts+1] = {cx, cy, (i==n) and 0.05 or lerp(0.42, 0.3, i/n)}
  end
  if rg_s:fullness() < 0.45 then rg_s:reload(pl, 0.7) end
  rg_s:gesture(pts, {wobble=0.15, ramps={0.02, 0.35}})
  return cx, cy, a
end
rg_s:reload(t_twig, 0.7)
local dead = {}
local cnt = 0
for bi, b in ipairs(crown) do
  local pts = b[1]
  local tip = pts[#pts]; local pre = pts[#pts-1]
  local a = math.atan(tip[2]-pre[2], tip[1]-pre[1])
  if math.random() < 0.75 then
    local k = math.random(2, 4)
    for j=1,k do
      local aa = a + randn(0, 0.6)
      fine(tip[1], tip[2], aa, rand(7, 16), t_twig)
      cnt = cnt + 1
    end
  end
end
print(cnt)
