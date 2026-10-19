-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"lead white", 10}, {"bone black", 0.2}}, texture=0.3, um=120}, {apply="brush", pile={{"lead white", 6}, {"red earth", 1.2}, {"raw umber", 1}, {"yellow ochre", 0.6}}, texture=0.5, um=40}}, linen={16, 14}, seed=4471, size=900}

--@ chunk 2
ld_hz2 = pile{{"lead white", 1}, {"raw umber", 0.6}, {"rose madder", 0.3}, {"ultramarine blue", 0.25}, {"orange chrome", 0.12}, {"Naples yellow", 0.25}, name="ld_hz2"}
ld_glow = pile{{"lead white", 1}, {"Naples yellow", 0.45}, {"raw umber", 0.45}, {"rose madder", 0.2}, {"orange chrome", 0.2}, name="ld_glow"}
ld_mid2 = pile{{"raw umber", 1}, {"rose madder", 0.25}, {"ultramarine blue", 0.4}, {"lead white", 0.4}, {"burnt sienna", 0.2}, name="ld_mid2"}
ld_near2 = pile{{"raw umber", 1}, {"bone black", 0.4}, {"ultramarine blue", 0.5}, {"burnt sienna", 0.35}, {"rose madder", 0.1}, name="ld_near2"}
gm_dk = pile{{"raw umber", 1}, {"ultramarine blue", 0.35}, {"rose madder", 0.15}, {"bone black", 0.15}, {"lead white", 0.15}, name="gm_dk"}
cr_dk = pile{{"raw umber", 1}, {"bone black", 0.3}, {"burnt sienna", 0.3}, {"ultramarine blue", 0.2}, {"lead white", 0.08}, name="cr_dk"}
cr_lt = pile{{"Naples yellow", 0.8}, {"burnt sienna", 0.5}, {"raw umber", 0.3}, {"lead white", 0.4}, {"rose madder", 0.08}, name="cr_lt"}
function land_piles()
  local function gl(x, y) local d = math.sqrt(((x-760)/2.6)^2 + ((y-478)*1.2)^2) return 1 - smoothstep(20, 90, d) end
  return {{ld_hz2, function(x,y) return (1 - smoothstep(482, 530, y)) * (1 - gl(x,y)) end},
         {ld_glow, function(x,y) return gl(x,y) * (1 - smoothstep(484, 540, y)) end},
         {ld_mid2, function(x,y) local t = smoothstep(482, 530, y) return t * (1 - smoothstep(575, 660, y)) end},
         {ld_near2, function(x,y) return smoothstep(575, 660, y) + 0.4*smoothstep(150, 0, x)*smoothstep(520, 640, y) end}}
end
local gnd = rect(0, 478, 1000, 170)
work(gnd, {hand="body", tool={kind="flat", width=12, stiffness=0.6}, piles=land_piles(),
  angle=function(x,y) return 0.05*math.sin(x/60 + y/35) end, length={25, 80},
  scale_at=function(x,y) return 0.4 + 1.0*smoothstep(476, 714, y) end,
  coverage=1.7, fill=true, clip=gnd, mix_jitter=0.06, seed=191})
print("ok")

--@ chunk 3
wait(10*24*60)
function cross_shape(bx, by, h, lean, barTilt)
  local w = h * 0.075
  local ux, uy = math.sin(lean), -math.cos(lean)
  local tx, ty = math.cos(lean + barTilt), math.sin(lean + barTilt)
  local top = {bx + ux*h, by + uy*h}
  local post = ribbon({{bx, by}, {bx + ux*h*0.5, by + uy*h*0.5}, top}, {w*1.05, w, w*0.95})
  local cx, cy = bx + ux*h*0.74, by + uy*h*0.74
  local L = h * 0.29
  local bar = ribbon({{cx - tx*L, cy - ty*L}, {cx + tx*L, cy + ty*L*1.0}}, {w*0.85, w*0.9})
  return post + bar, {bx=bx, by=by, ux=ux, uy=uy, tx=tx, ty=ty, h=h, w=w, cx=cx, cy=cy, L=L}
end
DX = {0, -130, -260}
local all_m, all_c = nil, nil
geo = {}
for i, dx in ipairs(DX) do
  local cm, g = cross_shape(612 + dx, 548, 104, -0.10, 0.06)
  geo[i] = g
  local s = g.h / 100
  local cx, cy = g.bx + 6*s, g.by + 9*s
  local m = poly({{cx - 26*s, cy - 2*s}, {cx - 12*s, cy - 9*s}, {cx + 14*s, cy - 9*s}, {cx + 30*s, cy - 1*s}, {cx + 34*s, cy + 9*s}, {cx - 30*s, cy + 9*s}}, true):roughen(1.5*s, 6*s, 1)
  all_m = all_m and (all_m + m) or m
  all_c = all_c and (all_c + cm) or cm
end
crosses_s = all_c
mounds_s = all_m - all_c
work(all_c, {hand="detail", tool={kind="round", width=2.5}, pile=cr_dk, coverage=3, clip=all_c, angle=function(x,y) return 1.5 end, seed=221})
work(mounds_s, {hand="detail", tool={kind="round", width=2.5}, pile=gm_dk, coverage=3, clip=mounds_s, angle=0, seed=231})
local rb = brush{kind="round", width=2, point=0.8, stiffness=0.55}
for i, g in ipairs(geo) do
  local side = 1
  local ox, oy = -g.uy * side * g.w * 0.35, g.ux * side * g.w * 0.35
  rb:reload(cr_lt, 0.6)
  local p0 = {g.bx + g.ux*g.h*0.05 + ox, g.by + g.uy*g.h*0.05 + oy}
  local p1 = {g.bx + g.ux*g.h*0.98 + ox, g.by + g.uy*g.h*0.98 + oy}
  rb:gesture({{p0[1], p0[2], 0.15}, {(p0[1]+p1[1])/2, (p0[2]+p1[2])/2, 0.45}, {p1[1], p1[2], 0.3}}, {wobble=0.3, clip=all_c})
  rb:reload(cr_lt, 0.5)
  local bx0, by0 = g.cx - g.tx*g.L*0.95, g.cy - g.ty*g.L*0.95 - g.w*0.3
  local bx1, by1 = g.cx + g.tx*g.L*0.95, g.cy + g.ty*g.L*0.95 - g.w*0.3
  rb:gesture({{bx0, by0, 0.2}, {bx1, by1, 0.35}}, {wobble=0.3, clip=all_c})
end
print("done")

--@ chunk 4
wait(20*24*60)
print(drying(612,520), drying(618,556), drying(500,540))

--@ chunk 5
zb_skin_dk = pile{{"green earth", 1}, {"raw umber", 0.8}, {"bone black", 0.15}, {"lead white", 0.15}, {"rose madder", 0.08}, name="zb_skin_dk"}
zb_cloth = pile{{"raw umber", 1}, {"bone black", 0.4}, {"ultramarine blue", 0.3}, {"burnt sienna", 0.2}, {"lead white", 0.08}, name="zb_cloth"}
cw_dark = pile{{"bone black", 1}, {"raw umber", 1}, {"ultramarine blue", 0.5}, name="cw_dark"}
heap_dk = mix{{gm_dk, 0.65}, {cw_dark, 0.35}, name="heap_dk"}
function grave_hand(bx, by, k, seed)
  local function P(pts) local q = {} for i, p in ipairs(pts) do q[i] = {bx + p[1]*k, by + p[2]*k, p[3]} end return q end
  local arm = ribbon(P({{0,2},{-1,-10},{-2,-20}}), {6.4*k, 5.8*k, 5.0*k})
  local palm = poly(P({{-5.2,-19},{1.4,-19.6},{2.8,-23.5},{2.2,-28.5},{-3.4,-29.5},{-6.2,-25.5}}))
  local body = arm + palm
  work(body, {hand="detail", tool={kind="round", width=2}, pile=zb_skin_dk, coverage=3.5, clip=body, angle=1.5, seed=seed})
  local fb = brush{kind="round", width=2.4*k, point=0.85, stiffness=0.55}
  local function f(pts) fb:reload(zb_skin_dk, 0.75) fb:gesture(P(pts), {wobble=0.15}) end
  f({{-3.6,-28.5,0.85},{-5.4,-33.5,0.8},{-5.6,-38,0.55},{-4.2,-40.5,0.1}})
  f({{-1.4,-29,0.85},{-1.8,-35,0.8},{-1.2,-39.8,0.55},{0.4,-41.5,0.1}})
  f({{0.8,-28.5,0.85},{2,-34,0.8},{2.8,-37.6,0.5},{2.2,-39.4,0.1}})
  f({{2.2,-26.5,0.8},{4.2,-30.5,0.75},{5.2,-33.4,0.45},{4.6,-35,0.1}})
  f({{-5.6,-21.5,0.85},{-8.6,-24.2,0.75},{-10,-27.6,0.5},{-9.4,-29.6,0.1}})
  -- tattered sleeve at the base
  local cuff = poly(P({{-4.4,3},{4.4,3},{4.4,-4},{2.6,-6.6},{1.2,-4.4},{0,-7.6},{-1.6,-5},{-3.2,-7},{-4.6,-4}}))
  work(cuff, {hand="detail", tool={kind="round", width=1.6}, pile=zb_cloth, coverage=3.5, clip=cuff, angle=1.5, seed=seed+1})
  -- broken earth at the base: a jagged dark tear and a few clods
  local tear = poly(P({{-9,2.5},{-5,0.6},{-2,1.6},{2,0.4},{6,1.8},{10,3},{6,4.6},{1,3.6},{-4,4.8}}))
  work(tear - cuff, {hand="detail", tool={kind="round", width=1.4}, pile=cw_dark, coverage=3.5, clip=tear - cuff, angle=0, seed=seed+2})
  local cb = brush{kind="round", width=2.2*k, point=0.3, stiffness=0.55}
  for _, c in ipairs({{-13,1.5},{11,-0.5},{14,3},{-8,-1},{8,6.5}}) do
    cb:reload(heap_dk, 0.7)
    cb:touch(bx + c[1]*k, by + c[2]*k, {pressure=0.6, drag={1.2*k, 0.3}})
  end
end
grave_hand(636, 553, 0.85, 501)
grave_hand(636 - 130, 553, 0.65, 511)
print(drying(636,540))

--@ chunk 6
zb_skin_gdk = mix{{zb_skin_dk, 0.6}, {zb_cloth, 0.4}, name="zb_skin_gdk"}
function grave_hand2(bx, by, k, seed, skin)
  local function P(pts) local q = {} for i, p in ipairs(pts) do q[i] = {bx + p[1]*k, by + p[2]*k, p[3]} end return q end
  local arm = ribbon(P({{0,2},{-1,-10},{-2,-20}}), {6.4*k, 5.8*k, 5.0*k})
  local palm = poly(P({{-5.2,-19},{1.4,-19.6},{2.8,-23.5},{2.2,-28.5},{-3.4,-29.5},{-6.2,-25.5}}))
  local body = arm + palm
  work(body, {hand="detail", tool={kind="round", width=2}, pile=skin, coverage=3.5, clip=body, angle=1.5, seed=seed})
  local fb = brush{kind="round", width=2.4*k, point=0.85, stiffness=0.55}
  local function f(pts) fb:reload(skin, 0.75) fb:gesture(P(pts), {wobble=0.15}) end
  f({{-3.6,-28.5,0.85},{-5.4,-33.5,0.8},{-5.6,-38,0.55},{-4.2,-40.5,0.1}})
  f({{-1.4,-29,0.85},{-1.8,-35,0.8},{-1.2,-39.8,0.55},{0.4,-41.5,0.1}})
  f({{0.8,-28.5,0.85},{2,-34,0.8},{2.8,-37.6,0.5},{2.2,-39.4,0.1}})
  f({{2.2,-26.5,0.8},{4.2,-30.5,0.75},{5.2,-33.4,0.45},{4.6,-35,0.1}})
  f({{-5.6,-21.5,0.85},{-8.6,-24.2,0.75},{-10,-27.6,0.5},{-9.4,-29.6,0.1}})
  local cuff = poly(P({{-4.4,3},{4.4,3},{4.4,-4},{2.6,-6.6},{1.2,-4.4},{0,-7.6},{-1.6,-5},{-3.2,-7},{-4.6,-4}}))
  work(cuff, {hand="detail", tool={kind="round", width=1.6}, pile=zb_cloth, coverage=3.5, clip=cuff, angle=1.5, seed=seed+1})
  local tear = poly(P({{-9,2.5},{-5,0.6},{-2,1.6},{2,0.4},{6,1.8},{10,3},{6,4.6},{1,3.6},{-4,4.8}}))
  work(tear - cuff, {hand="detail", tool={kind="round", width=1.4}, pile=cw_dark, coverage=3.5, clip=tear - cuff, angle=0, seed=seed+2})
  local cb = brush{kind="round", width=2.2*k, point=0.3, stiffness=0.55}
  for _, c in ipairs({{-13,1.5},{11,-0.5},{14,3},{-8,-1},{8,6.5}}) do
    cb:reload(heap_dk, 0.7)
    cb:touch(bx + c[1]*k, by + c[2]*k, {pressure=0.6, drag={1.2*k, 0.3}})
  end
  return body
end
gh3 = grave_hand2(636 - 260, 553, 0.75, 521, zb_skin_gdk)
print(drying(636,540))

--@ chunk 7
wait(14*24*60)
print(drying(634,540), drying(504,540))
gh_rim = mix{{zb_skin_gdk, 0.4}, {cr_lt, 0.6}, name="gh_rim"}
local function rimline(bx, by, k)
  local function P(pts) local q = {} for i, p in ipairs(pts) do q[i] = {bx + p[1]*k, by + p[2]*k, p[3]} end return q end
  local rb = brush{kind="round", width=1.4, point=0.9, stiffness=0.55}
  rb:reload(gh_rim, 0.6)
  rb:gesture(P({{2.2,-4,0.1},{1.6,-12,0.45},{0.6,-19.5,0.5},{2.4,-24,0.3}}), {wobble=0.1})
  rb:reload(gh_rim, 0.5)
  rb:gesture(P({{1.6,-30,0.3},{2.8,-35,0.35},{2.6,-38.5,0.05}}), {wobble=0.1})
end
rimline(636, 553, 0.85)        -- right replica (k .85, skin_dk)
rimline(636 - 260, 553, 0.75)  -- left replica (gdk, same as painting)
print("ok")
