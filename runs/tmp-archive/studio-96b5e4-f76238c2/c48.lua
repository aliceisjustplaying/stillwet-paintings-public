gr_lit2 = pile{{"yellow ochre",1},{"lead white",0.25},{"red earth",0.2},{"raw umber",0.2},{"green earth",0.2}, medium=0.12}
-- seam: small dark tufts along the fore/mid boundary
for i=1,160 do
  local x = rand(0,1000)
  local y = 528 + 10*math.sin(x/71) + rand(-6,8)
  tuft_at(x, y, (i%3==0) and gr_mid or gr_dk, 0.85, math.random(3,6), 0.9)
end
-- lit tips, sparser toward the bottom
for i=1,170 do
  local y = 535 + 170*(rand(0,1)^1.6)
  local x = rand(0,1000)
  tuft_at(x, y, (i%2==0) and gr_lit or gr_lit2, 0.6, math.random(2,4), 0.9)
end
