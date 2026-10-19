wait(24*60)
local function curve(pts)
  return function(x)
    if x <= pts[1][1] then return pts[1][2] end
    for i = 2, #pts do
      if x <= pts[i][1] then
        local a, b = pts[i-1], pts[i]
        local t = (x - a[1]) / (b[1] - a[1]); t = t*t*(3-2*t)
        return a[2] + (b[2] - a[2]) * t
      end
    end
    return pts[#pts][2]
  end
end
bankY = curve(BANK)
land = below(function(x) return HZ - 1 end)
bank = below(bankY):roughen(2.5, 30, 5, 1.5)
local pp = {}
for _, p in ipairs(POND_FAR) do pp[#pp+1] = p end
for i = #POND_NEAR, 1, -1 do pp[#pp+1] = POND_NEAR[i] end
pond = poly(pp, true):roughen(2, 26, 7, 0.8)
snowpal = pal:only{"lead white", "smalt", "pale smalt", "red earth", "yellow ochre", "raw umber", "bone black"}
local lie = noise{seed=17, period=140, octaves=4, stretch={0.05, 5}}
flatcol = function(x, y)
  local t = smoothstep(HZ, bankY(x), y)
  local c = mix("#d4cdc9", "#b4b3bf", t)
  return shift(c, 0.02 * lie(x, y), 0, 0.004 * lie(y, x))
end
work(land - bank - pond, {hand="body", color=flatcol, pal=snowpal, angle=function(x, y) return 0.02 * lie(x, y) end,
  length={30, 90}, coverage=3.4, medium=0.2, edge="soft"})
