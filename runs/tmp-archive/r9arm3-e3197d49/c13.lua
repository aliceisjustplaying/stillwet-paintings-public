-- the cross's wood darkened with a thin warm-dark glaze, only where the wood is (the snow on it stays)
local woodm = mask(function(x, y)
  if x < 574 or x > 638 or y < 498 or y > 614 then return 0 end
  local s = sample(x, y)
  return 1 - smoothstep(0.5, 0.7, s.L)
end)
glaze(woodm, {color="#2e2621", coats=0.45, pigment="semi"})
