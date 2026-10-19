-- raw umber + red earth + white is a pumpkin, not earthenware. Mute it right down.
g_bw = pile{{"raw umber", 4}, {"red earth", 1.1}, {"bone black", 0.7}, {"lead white", 0.5}}
-- a clean crescent for the inside, no wobbly poly edge
BOWL_IN = mask(function(x, y)
  local u = (x - BOWLX) / (BOWLRX - 17)
  local v = (y - BOWLY) / (BOWLRY - 12)
  if u*u + v*v > 1 then return 0 end
  local edge = BOWLY + (BOWLRY - 12) * math.sqrt(math.max(0, 1 - u*u))
  return smoothstep(edge + 2, edge - 2, y)
end)
print(string.format("inside %.0f", BOWL_IN:area()))
-- the outer wall all over again, in the muted earth
work(BOWL_BODY, {hand="body", tool="filbert 13", pile=g_bw, length={35, 90},
                 coverage=3.2, pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=0.4, edge="soft"})
work(BOWL_IN, {hand="body", tool="filbert 12", pile=g_dk, length={30, 80},
               coverage=3, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
