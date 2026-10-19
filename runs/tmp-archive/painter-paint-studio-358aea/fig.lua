local det = function(m, p, w, cov, ang)
  work(m, {hand="detail", pile=p, tool={kind="round", width=w or 1.0, point=0.5}, angle=ang or math.pi/2, length={2,6}, coverage=cov or 3, clip=true, fill=true, edge="found"})
end
coatP = pile{{"bone black",1},{"Prussian blue",0.25},{"raw umber",0.6},{"green earth",0.4},{"lead white",0.35}, medium=0.08}
coatL = pile{{"bone black",0.6},{"Prussian blue",0.2},{"raw umber",0.5},{"green earth",0.6},{"lead white",1.1}, medium=0.08}
hairP = pile{{"raw umber",1},{"bone black",0.4},{"red earth",0.2},{"lead white",0.15}, medium=0.08}
dressP = pile{{"red earth",1},{"raw umber",0.7},{"bone black",0.2},{"vermilion",0.15},{"lead white",0.2}, medium=0.08}
dressL = pile{{"red earth",1},{"raw umber",0.4},{"vermilion",0.25},{"lead white",0.6},{"yellow ochre",0.2}, medium=0.08}
shawlP = pile{{"lead white",4},{"yellow ochre",0.5},{"raw umber",0.12}, medium=0.08}
shawlS = pile{{"lead white",2},{"yellow ochre",0.4},{"raw umber",0.3},{"pale smalt",0.3}, medium=0.08}
bootP = pile{{"bone black",1},{"raw umber",0.5},{"lead white",0.1}, medium=0.08}
-- MAN, x~446, feet 562
local mx = 446
MAN_COAT = poly({{mx-6,475},{mx-9.5,478},{mx-10.5,486},{mx-11,500},{mx-12.5,520},{mx-13.5,533},{mx-4,535},{mx+3,535},{mx+13,532},{mx+12,518},{mx+11,500},{mx+10.5,486},{mx+9.5,478},{mx+6,475}}, true)
MAN_LEGS = poly({{mx-7,533},{mx-7.2,556},{mx-3.4,557},{mx-2,534}}) + poly({{mx+1.5,534},{mx+2.2,557},{mx+6,557},{mx+6.5,533}})
MAN_BOOTS = poly({{mx-7.6,553},{mx-8,561},{mx-2.8,561.5},{mx-3,553}}) + poly({{mx+1.8,553},{mx+1.8,561.5},{mx+7.4,561},{mx+6.4,553}})
MAN_HEAD = ellipse(mx+0.5, 468.5, 5.0, 6.2)
MAN_CAP = poly({{mx-6.5,465},{mx-4,460.5},{mx+2,459.3},{mx+6.5,461.5},{mx+7,465},{mx+1,466}}, true)
MAN_COLLAR = poly({{mx-6,476},{mx-5,471},{mx+6,471},{mx+6.8,476},{mx,478}}, true)
MAN = MAN_COAT + MAN_LEGS + MAN_BOOTS + MAN_HEAD + MAN_CAP + MAN_COLLAR
det(MAN_LEGS, coatP, 1.0)
det(MAN_BOOTS, bootP, 1.0)
det(MAN_COAT + MAN_COLLAR, coatP, 1.2)
det(MAN_HEAD, hairP, 1.0)
det(MAN_CAP, bootP, 1.0, 3, 0)
local mlit = (MAN_COAT + MAN_COLLAR) * mask(function(x,y) return smoothstep(mx-6, mx-10, x) end)
work(mlit, {hand="detail", pile=coatL, tool={kind="round", width=0.9, point=0.5}, angle=math.pi/2, length={3,10}, coverage=1.5, clip=true})
-- WOMAN x~470, feet 561
local wx = 470
local W_DRESS = poly({{wx-6.5,484},{wx-7.5,500},{wx-9.5,520},{wx-12,545},{wx-13.5,561},{wx-2,562.5},{wx+8,562},{wx+13.5,560},{wx+11.5,544},{wx+9,520},{wx+7.5,500},{wx+6.5,484}}, true)
local W_HEAD = ellipse(wx, 475.5, 4.6, 5.6)
local W_BUN = ellipse(wx+0.3, 471.2, 2.8, 2.4)
local W_SHAWL = poly({{wx-7,482.5},{wx-8.5,486},{wx-7.5,492},{wx-2,503},{wx,506},{wx+2,503},{wx+7.5,492},{wx+8.5,486},{wx+7,482.5},{wx,480.5}}, true)
WOMAN = W_DRESS + W_HEAD + W_BUN + W_SHAWL
det(W_DRESS, dressP, 1.2)
local wlit = W_DRESS * mask(function(x,y) return smoothstep(wx-4, wx-9, x) end)
work(wlit, {hand="detail", pile=dressL, tool={kind="round", width=0.9, point=0.5}, angle=math.pi/2, length={4,12}, coverage=1.5, clip=true})
det(W_HEAD, hairP, 1.0)
det(W_BUN, hairP, 0.8)
det(W_SHAWL, shawlP, 1.0, 3, 0.4)
local ssh = W_SHAWL * mask(function(x,y) return smoothstep(wx+1, wx+6, x) end)
work(ssh, {hand="detail", pile=shawlS, tool={kind="round", width=0.8, point=0.5}, angle=math.pi/2, length={2,6}, coverage=1.4, clip=true})
FIGS = MAN + WOMAN
print(wait(0))
