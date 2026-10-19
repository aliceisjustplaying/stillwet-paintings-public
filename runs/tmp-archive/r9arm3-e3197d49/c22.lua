-- a faint dark veil growing toward the edges and corners (as he advised Carus), the glow left clear
local edges = mask(function(x, y)
  local dx = math.abs(x - 470) / 530
  local dy = math.abs(y - 400) / 330
  local r = math.sqrt(dx * dx * 0.8 + dy * dy)
  return smoothstep(0.75, 1.35, r)
end)
glaze(edges, {color="#3a3640", coats=0.14, pigment="semi"})
wait(24*60)
varnish{color="#e6d3a4", coats=0.35, vary=0.12}
cracks{dirt=0.4, vary=1, veil=0.5}
relief()
