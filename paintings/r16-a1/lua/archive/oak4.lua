barkK = pile{{"raw umber",1.5},{"bone black",1},{"smalt",0.7},{"lead white",0.2}, medium=0.1}
local tf = poly({{378,508},{384,500},{387,488},{388,470},{390,440},{421,440},{422,470},{424,488},{428,500},{436,508}}, true)
local mx = tree_thick_mask(OAKX, 3.5)
OAKthick2 = tree_thick_mask(OAK, 3.5) + tf
if mx then OAKthick2 = OAKthick2 + mx end
OAKthick2 = OAKthick2:roughen(1.2, 7, 5)
work(OAKthick2, {hand="detail", pile=barkK, coverage=2.5, fill=true, angle=math.pi/2})
-- mid limbs darker too
local b = brush{kind="round", width=4, point=1}
b:load(barkK, 0.8)
for _,T in ipairs({OAK, OAKX}) do
  for _,l in ipairs(T.limbs) do
    if l.ws[1] < 3.5 and l.ws[1] >= 1.8 and #l.pts>=2 then
      if b:fullness() < 0.35 then b:load(barkK, 0.7) end
      b:stroke(l.pts, {pressure={b:pressure_for(l.ws[1]*0.9), b:pressure_for(math.max(l.ws[#l.ws]*0.9,0.6))*0.6}, ramps={0.02,0.25}, shake=0.3})
    end
  end
end
