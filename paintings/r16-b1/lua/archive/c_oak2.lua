barkD = pile{{"raw umber", 2}, {"bone black", 1.5}, {"green earth", 1}, {"Prussian blue", 0.1}, medium=0.1}
gn = noise{seed=31, octaves=3, period=40}
function spline(pts, step)
  local out = {}
  local n = #pts
  for i = 1, n-1 do
    local p0 = pts[math.max(1,i-1)]; local p1 = pts[i]; local p2 = pts[i+1]; local p3 = pts[math.min(n,i+2)]
    local seg = math.sqrt((p2[1]-p1[1])^2 + (p2[2]-p1[2])^2)
    local k = math.max(2, math.floor(seg/step))
    for j = 0, k-1 do
      local t = j/k; local t2, t3 = t*t, t*t*t
      local x = 0.5*((2*p1[1]) + (-p0[1]+p2[1])*t + (2*p0[1]-5*p1[1]+4*p2[1]-p3[1])*t2 + (-p0[1]+3*p1[1]-3*p2[1]+p3[1])*t3)
      local y = 0.5*((2*p1[2]) + (-p0[2]+p2[2])*t + (2*p0[2]-5*p1[2]+4*p2[2]-p3[2])*t2 + (-p0[2]+3*p1[2]-3*p2[2]+p3[2])*t3)
      out[#out+1] = {x, y, i, t}
    end
  end
  out[#out+1] = {pts[n][1], pts[n][2], n-1, 1}
  return out
end
function limbMask(L, grow)
  local sp = spline(L.pts, 3)
  local P, Wd = {}, {}
  for _, q in ipairs(sp) do
    local w = lerp(L.w[q[3]], L.w[q[3]+1] or L.w[q[3]], q[4]) * (grow or 1)
    w = w * (1 + 0.18*gn(q[1], q[2]))
    P[#P+1] = {q[1] + 1.2*gn(q[2], q[1]), q[2]}; Wd[#Wd+1] = w
  end
  return ribbon(P, Wd)
end
-- gnarlier main limbs: nudge points
oakLimbs[1].pts = {{296,594},{298,566},{302,530},{300,495},{305,462},{300,430},{304,402}}
oakLimbs[1].w = {46,33,28,27,26,25,23}
oakLimbs[2].pts = {{300,405},{286,392},{270,382},{256,364},{238,352},{226,330},{206,318},{182,305},{164,300},{148,292}}
oakLimbs[2].w = {19,16,14,12,11,9,8,6,5,4}
oakLimbs[3].pts = {{306,402},{324,388},{334,372},{344,356},{352,334},{366,322},{380,302},{402,290},{420,278},{446,272}}
oakLimbs[3].w = {18,15,13,12,11,9,8,6,5,3.5}
oakLimbs[4].pts = {{303,400},{309,372},{306,346},{312,318},{303,290},{309,262},{313,238},{304,212},{308,190},{314,160},{307,134},{309,110}}
oakLimbs[4].w = {15,13,12,11,10,9,8,6.5,5,4,3,2}
oakM2 = nil
for _, L in ipairs(oakLimbs) do
  local r = limbMask(L, 1.1)
  oakM2 = oakM2 and (oakM2 + r) or r
end
oakM2 = oakM2 + poly({{262,600},{280,584},{292,562},{314,562},{324,584},{342,600}}, true)
oakM2 = oakM2:roughen(1.2, 8, 5)
work(oakM2, {hand="detail", pile=barkD, coverage=3, fill=true, angle=-1.45, length={6,18}})
