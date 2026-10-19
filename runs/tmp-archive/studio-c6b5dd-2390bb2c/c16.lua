local cr = {{70,100,50},{165,200,60},{250,265,55},{55,260,70},{305,335,42},{200,345,60},{345,400,32},{420,425,24},{110,390,60},{230,420,50}}
lit = nil
for i, c in ipairs(cr) do
  local m = ellipse(c[1]+0.35*c[3], c[2]-0.35*c[3], 0.55*c[3], 0.45*c[3]):roughen(0.18*c[3], 0.4*c[3], 40+i, 0)
  lit = lit and (lit + m) or m
end
lit = lit * trees:shrink(4)
pLeaf = pile{{"yellow ochre",2},{"green earth",1},{"raw umber",0.8},{"Prussian blue",0.1},{"lead white",0.25}}
stipple(lit, {pile=pLeaf, width=5, coverage=1.3, cluster={0.6, 8}, pressure={0.4,0.7}, dips={12,0.7,0.3}, feather=0.3})
