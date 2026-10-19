-- the bowl: an outer silhouette (far rim over the top, then the body down to the foot),
-- a rim ring, the inside seen through the opening, and the outer wall below the rim
outer = {}
for i, p in ipairs(arc(BOWLX, BOWLY, BOWLRX, BOWLRY, math.pi, 2*math.pi, 30)) do outer[i] = p end
local bodypts = {{758, 500}, {748, 538}, {724, 572}, {688, 595}, {636, 607}, {576, 610},
                 {516, 607}, {466, 594}, {428, 571}, {402, 538}, {392, 500}}
for i, p in ipairs(bodypts) do outer[#outer+1] = p end
BOWL = poly(outer, true)
rim_out = ellipse(BOWLX, BOWLY, BOWLRX, BOWLRY)
rim_in  = ellipse(BOWLX, BOWLY, BOWLRX - 17, BOWLRY - 12)
BOWL_BODY = BOWL - rim_out
BOWL_RIM  = rim_out - rim_in
function innery(x) return BOWLY + (BOWLRY - 12) * math.sqrt(math.max(0, 1 - ((x - BOWLX)/(BOWLRX - 17))^2)) end
BOWL_IN = rim_in - below(innery)
print(string.format("bowl %.0f | body %.0f | rim %.0f | inside %.0f", BOWL:area(), BOWL_BODY:area(), BOWL_RIM:area(), BOWL_IN:area()))
