-- the near bank in dark earth colors, laid into the wet edge of the water so the two meet soft
bankpal = pal:only{"raw umber", "bone black", "yellow ochre", "red earth", "lead white", "pale smalt"}
local bn = noise{seed=91, period=70, octaves=4}
bank2 = below(function(x) return bankcurve(x) + 1.5 end):roughen(1.6, 11, 92, 1)
work(bank2, {hand="body", tool="filbert 6", angle=function(x, y) return 0.04 + 0.12 * bn(x, y) end, length={12, 40}, coverage=3.4,
  medium=0.22, pal=bankpal, edge={soft=0.6, found=0.2, lost=0.2, period=60, seed=93},
  color=function(x, y)
    local d = y - bankcurve(x)
    return mix(mix("#3b3a30", "#2c2a24", smoothstep(4, 50, d)), "#463f31", 0.35 * bn:at01(x * 1.7, y))
  end})
local t = timesheet(); print(string.format("sitting %.0f min", t.sitting))
