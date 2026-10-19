function tree_twigs(T, wmax, per, lenr, seed)
  math.randomseed(seed)
  local TT = tree_new(T.cx, T.spread, {wmin=0.55, zig=0.45, trop=0.05, fan=0.9, seglen=5, taper=0.35, branchp=0.45, cmin=0.6, cmax=0.85, droop_order=99, droop=0})
  local src = {}
  for _,l in ipairs(T.limbs) do if not l.dead and l.ws[1] < wmax and #l.pts >= 2 then src[#src+1] = l end end
  for _,l in ipairs(src) do
    for i=2,#l.pts do
      local a, b = l.pts[i-1], l.pts[i]
      local segl = math.sqrt((b[1]-a[1])^2 + (b[2]-a[2])^2)
      local k = math.floor(segl/10*per + math.random())
      local ang = math.atan(b[2]-a[2], b[1]-a[1])
      for j=1,k do
        local t = rand(0.1, 1)
        local x, y = lerp(a[1],b[1],t), lerp(a[2],b[2],t)
        local w = lerp(l.ws[i-1], l.ws[i], t)
        local side = (math.random()<0.5) and 1 or -1
        tree_grow(TT, x, y, ang + side*rand(0.4,1.2), rand(lenr[1], lenr[2]), math.min(w*0.7, rand(0.8,1.3)), 5, false)
      end
    end
    -- a brush of twigs at the tip
    local e = l.pts[#l.pts]; local d = l.pts[#l.pts-1]
    local ang = math.atan(e[2]-d[2], e[1]-d[1])
    for j=1,math.random(2,4) do tree_grow(TT, e[1], e[2], ang + rand(-0.7,0.7), rand(lenr[1], lenr[2])*1.2, rand(0.7,1.0), 5, false) end
  end
  return TT
end
OAKT = tree_twigs(OAK, 5, 1.2, {8, 26}, 99)
print(tree_stats(OAKT))
