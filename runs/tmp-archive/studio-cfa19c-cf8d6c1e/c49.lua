function interp(pts, x)
  if x <= pts[1][1] then return pts[1][2] end
  for i=1,#pts-1 do
    if x >= pts[i][1] and x <= pts[i+1][1] then return lerp(pts[i][2], pts[i+1][2], (x-pts[i][1])/(pts[i+1][1]-pts[i][1])) end
  end
  return pts[#pts][2]
end
farBank = {{330,444.5},{380,446.5},{440,449.5},{520,457},{600,467},{680,481},{780,499},{900,514},{1010,527}}
nearBank = {{330,445.6},{380,448.5},{440,455},{510,465},{590,478},{670,495},{770,515},{890,533},{1010,550}}
wCrD = pile{{"green earth",2},{"raw umber",0.7},{"Prussian blue",0.2},{"lead white",0.4}, medium=0.05}
wCrL = pile{{"lead white",2},{"green earth",1.5},{"pale smalt",0.5},{"yellow ochre",0.4}, medium=0.05}
wTr = pile{{"raw umber",1.5},{"bone black",0.3},{"lead white",0.6}, medium=0.05}
willowSil = nil
function willow(x, s, seed)
  local y = interp(farBank, x) + 0.5
  local lean = rand(-0.08, 0.08)
  local th = 0.42*s
  local tr = poly({{x-0.09*s,y},{x-0.08*s+lean*th, y-th*0.7},{x-0.15*s+lean*th, y-th},{x+0.15*s+lean*th,y-th},{x+0.08*s+lean*th,y-th*0.7},{x+0.09*s,y}}, true)
  local cx, cy = x + lean*th, y - th - 0.28*s
  local crown = ellipse(cx, cy, 0.45*s, 0.33*s):roughen(0.06*s, 0.15*s, seed)
  local tipw = math.max(1.2, 0.05*s)
  work(tr, {hand="detail", pile=wTr, tool={kind="round", width=math.max(1.2, 0.06*s), point=0.5}, angle=math.pi/2, coverage=2.5, fill=true, seed=seed})
  stipple(crown, {pile=wCrD, width=math.max(1.6,0.09*s), coverage=2.2, drag={0.12*s, -math.pi/2}, pressure={0.4,0.8}, cluster={0.3,3}, feather=0.5, seed=seed+1})
  local litc = crown * mask(function(px,py) return smoothstep(0.1*s, -0.35*s, (px-cx) + 0.6*(py-cy)) end)
  stipple(litc, {pile=wCrL, width=math.max(1.3,0.07*s), coverage=1.4, drag={0.1*s, -math.pi/2+0.1}, pressure={0.35,0.7}, cluster={0.4,3}, feather=0.7, seed=seed+2})
  local sil = tr + crown
  willowSil = willowSil and (willowSil + sil) or sil
end
for i,w in ipairs({{452,11},{505,14},{560,18},{626,22},{702,27},{792,33},{884,38},{978,44}}) do
  willow(w[1], w[2], 400 + i*7)
end
