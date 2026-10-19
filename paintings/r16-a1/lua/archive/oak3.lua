math.randomseed(4242)
OAKX = tree_new(OAK.cx, OAK.spread, OAK.o)
for _,l in ipairs(OAK.limbs) do
  local n = #l.pts
  if n >= 2 and not l.main and l.ws[n] > 1.2 and not l.dead then
    local e, d = l.pts[n], l.pts[n-1]
    local ang = math.atan(e[2]-d[2], e[1]-d[1])
    tree_grow(OAKX, e[1], e[2], ang, 10*l.ws[n] + 15, l.ws[n]*0.95, l.order, false)
  end
end
print(tree_stats(OAKX))
print(tree_paint_thin(OAKX, barkD, 99, function(l) return l.ws[1] >= 1.6 end))
print(tree_paint_thin(OAKX, twigP, 99, function(l) return l.ws[1] < 1.6 end))
OAKXT = tree_twigs(OAKX, 5, 1.2, {8, 24}, 98)
print(tree_paint_thin(OAKXT, twigP, 99, nil, 0.6))
