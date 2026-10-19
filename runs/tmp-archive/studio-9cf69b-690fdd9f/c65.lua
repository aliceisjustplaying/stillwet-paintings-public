veilA = pile{{"lead white",6},{"pale smalt",1.4},{"yellow ochre",0.12},{"vermilion",0.03},{"smalt",0.1}, medium=0.3}
veilB = pile{{"lead white",5},{"pale smalt",1.8},{"smalt",0.35},{"raw umber",0.12},{"vermilion",0.02}, medium=0.3}
function buryTufts(cx, cy, pile, strength)
  local sc = (cy - 470) / 3.4
  local m = ellipse(cx, cy - 0.15*sc, 2.4*sc + 4, 0.45*sc + 4) - figM:grow(2) - stepsM:grow(1) - trench:grow(1)
  stipple(m, {pile=pile, width=2.2, coverage=function(x,y) local d = ((x-cx)/(2.4*sc+4))^2 + ((y-cy+0.15*sc)/(0.45*sc+4))^2; return clamp((1-d)*2.2, 0, 1) * strength end, feather=0.8, pressure={0.35,0.6}, cluster=0.2})
end
buryTufts(650, 530, veilA, 2.5)
