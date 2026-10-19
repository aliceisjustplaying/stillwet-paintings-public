math.randomseed(1810)
OAK2 = tree_new(868, 130, {wmin=0.6, zig=0.32, trop=0.07, fan=0.95, seglen=16, taper=0.3, branchp=0.5, cmin=0.45, cmax=0.8, droop_order=99, droop=0})
tree_main(OAK2, {{850,504},{848,460},{846,420},{848,380},{852,345}}, {30,26,24,22,21}, 1, false, nil)
tree_main(OAK2, {{848,352},{831,320},{819,302}}, {13,12,11}, 2, true, nil)
tree_main(OAK2, {{855,348},{868,310},{880,275},{886,240},{882,205},{890,170},{895,150}}, {16,14,12,10,8,6,4.5}, 2, false, {len=70, p=0.9, n=2, tip=45, cmin=0.3, cmax=0.55})
tree_main(OAK2, {{848,392},{825,380},{800,372},{775,356},{752,348}}, {9,8,7,6,5}, 2, false, {len=50, p=0.9, n=2, tip=40, cmin=0.3, cmax=0.6})
tree_main(OAK2, {{874,287},{905,272},{935,262},{962,246},{985,238}}, {8,7,6,5,4}, 2, false, {len=50, p=0.9, n=2, tip=35, cmin=0.3, cmax=0.6})
tree_main(OAK2, {{881,242},{863,212},{851,187},{846,166}}, {5,4,3.5,3}, 2, true, {len=15, p=0.5, n=1, cmin=0.35, cmax=0.5})
-- extend blunt ends
local ext = tree_new(OAK2.cx, OAK2.spread, OAK2.o)
for _,l in ipairs(OAK2.limbs) do
  local n = #l.pts
  if n >= 2 and not l.main and l.ws[n] > 1.2 and not l.dead then
    local e, d = l.pts[n], l.pts[n-1]
    tree_grow(ext, e[1], e[2], math.atan(e[2]-d[2], e[1]-d[1]), 10*l.ws[n]+12, l.ws[n]*0.95, l.order, false)
  end
end
for _,l in ipairs(ext.limbs) do OAK2.limbs[#OAK2.limbs+1] = l end
print(tree_stats(OAK2))
local tf = poly({{830,508},{836,500},{838,488},{839,470},{840,450},{857,450},{858,470},{860,488},{864,500},{872,508}}, true)
OAK2thick = (tree_thick_mask(OAK2, 3.5) + tf):roughen(1.2, 7, 6)
work(OAK2thick, {hand="detail", pile=barkD, coverage=3, fill=true, angle=math.pi/2})
print(tree_paint_thin(OAK2, barkD, 3.5, function(l) return l.ws[1] >= 1.6 end))
print(tree_paint_thin(OAK2, twigP, 3.5, function(l) return l.ws[1] < 1.6 end))
OAK2T = tree_twigs(OAK2, 5, 1.2, {7, 22}, 77)
print(tree_paint_thin(OAK2T, twigP, 99, nil, 0.6))
