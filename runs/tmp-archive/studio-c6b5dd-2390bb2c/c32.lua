local cr = {{60,85,45},{140,160,50},{230,215,55},{300,285,45},{335,345,35},{410,420,26},{60,230,60},{170,300,65},{250,370,55},{100,380,60},{360,405,30}}
litM, shM = nil, nil
for i, c in ipairs(cr) do
  local e = ellipse(c[1], c[2], c[3], c[3]*0.8):roughen(c[3]*0.18, c[3]*0.35, 300+i, 0)
  local l = e - ellipse(c[1]-0.3*c[3], c[2]+0.35*c[3], c[3]*1.05, c[3]*0.85)
  local s = e * ellipse(c[1]-0.1*c[3], c[2]+0.75*c[3], c[3]*1.0, c[3]*0.55)
  litM = litM and (litM + l) or l
  shM = shM and (shM + s) or s
end
litM = litM * trees:shrink(2)
shM = shM * trees:shrink(2)
pShade = pile{{"Prussian blue",0.5},{"raw umber",1.5},{"bone black",0.6},{"yellow ochre",0.5}}
pLit = pile{{"yellow ochre",2},{"green earth",1.2},{"raw umber",0.7},{"Prussian blue",0.12},{"lead white",0.35},{"red earth",0.15}}
stipple(shM, {pile=pShade, width=5, coverage=1.8, pressure={0.5,0.9}, dips={14,0.8,0.2}, drag={3, 0.6}, twist=0.6, cluster={0.5,6}, feather=0.3})
stipple(litM, {pile=pLit, width=4, coverage=1.1, pressure={0.4,0.8}, dips={12,0.7,0.2}, drag={2.5, -0.5}, twist=0.6, cluster={0.6,6}, feather=0.4})
