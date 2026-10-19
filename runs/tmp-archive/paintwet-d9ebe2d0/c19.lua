-- the far crest still showed a double contour at 3200 (a dark line over a pale band). Now that it's dry, bring
-- the range up over both, about 5 units, loaded and laid lightly along the ridge, clipped softly at the new ridge.
print(drying(790, crest(790) - 3), drying(470, crest(470)))
crest2 = function(x) return crest(x) - 5.5 end
crestBand = mask(function(x, y) local c = crest2(x)
  return smoothstep(c - 1, c + 0.5, y) * (1 - smoothstep(c + 10, c + 16, y)) end) - landM:grow(3)
work(crestBand, {hand="body", tool="filbert 4", color=function(x, y) return rangecol(x, y + 5.5) end,
  angle=function(x, y) return math.atan(crest(x + 4) - crest(x - 4), 8) end,
  length={20, 60}, coverage=2.8, medium=0.2, load=1.0, pressure={0.35, 0.5}, ramps={0.3, 0.3}, pal=skypal,
  clip=mask(function(x, y) return smoothstep(crest2(x) - 0.7, crest2(x) + 0.7, y) end)})
