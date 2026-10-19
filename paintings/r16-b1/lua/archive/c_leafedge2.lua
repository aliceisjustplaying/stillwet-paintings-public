foliMidP = pile{{"green earth", 2}, {"raw umber", 1.6}, {"yellow ochre", 0.9}, {"Prussian blue", 0.25}, {"bone black", 0.25}, {"lead white", 0.3}, medium=0.1}
foliLitP = pile{{"green earth", 2}, {"yellow ochre", 1.2}, {"raw umber", 0.8}, {"lead white", 0.5}, medium=0.1}
function leafFringe(rx, ry, rw, rh, seed)
  local R = rect(rx, ry, rw, rh)
  local ring = (foliM:grow(8) - foliM:grow(1)) * R - oakM2
  stipple(ring, {pile=foliDark, width=1.3, coverage=0.55, cluster={0.6, 5}, pressure={0.3, 0.7}, feather=0.5, seed=seed})
  local inner = (foliM:grow(2) - foliM:shrink(8)) * R - oakM2
  stipple(inner, {pile=foliMidP, width=1.8, coverage=0.9, cluster={0.5, 4}, pressure={0.3, 0.7}, seed=seed+1})
  -- lit upper edges: upper part only (where the mask above is empty)
  local lit = (foliM - foliM:offset(0)) -- placeholder
end
leafFringe(40, 215, 120, 100, 902)
