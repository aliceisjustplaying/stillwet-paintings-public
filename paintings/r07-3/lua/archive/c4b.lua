-- the sky, first layer: six piles mixed by knife, laid in bands top down, wet into wet, a shade dull
skypal = pal:only{"lead white", "pale smalt", "cobalt blue", "yellow ochre", "raw umber", "red earth", "vermilion", "chrome yellow"}
shoreline = function(x) return 433 - 13*G(x, 500, 330) end
skyM = above(function(x) return shoreline(x) + 6 end)
PILES = {{0, "#4e5d7c"}, {110, "#687a97"}, {205, "#909eaa"}, {285, "#bcbca8"}, {350, "#d9cda0"}, {400, "#e6c690"}}
rag = noise{seed=12, period=70, octaves=3}
local dome = function(x) return 26 * G(x, 505, 260) end    -- the glow stands higher over the town
for i, p in ipairs(PILES) do
  local top = (i == 1) and -20 or (PILES[i-1][1] + p[1]) / 2
  local bot = (i == #PILES) and 480 or (p[1] + PILES[i+1][1]) / 2
  local lift = (i >= 4) and 1 or 0.4
  local band = mask(function(x, y)
    local yy = y + lift*dome(x) + 9*rag(x, y)
    return smoothstep(top - 14, top + 6, yy) * (1 - smoothstep(bot - 6, bot + 14, yy))
  end) * skyM
  work(band, {hand="broad", tool="flat 12", color=p[2], angle=function(x, y) return 0.025*rag(x*0.5, y) end,
    length={70, 200}, coverage=3.6, medium=0.3, pal=skypal, hug=false})
end
-- no blend
local t = timesheet(); print(string.format("sitting %.0f min", t.sitting))
