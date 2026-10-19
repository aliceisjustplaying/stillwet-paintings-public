-- lose the wood floor's hard left end and lower edge in low mist lying on the far shore, and veil the church's foot
local mn = noise{seed=191, period=60, octaves=4, stretch={0, 5}}
local lowmist = mask(function(x, y)
  local c = math.exp(-((y - 462) / 7)^2)
  local endx = math.exp(-((x - 532) / 30)^2) * math.exp(-((y - 455) / 10)^2)
  local church = math.exp(-((x - 445) / 30)^2) * math.exp(-((y - 444) / 5)^2)
  return clamp(0.8 * c * smoothstep(-0.3, 0.4, mn(x, y)) + endx + 0.8 * church, 0, 1)
end)
stipple(lowmist, {width=2, pal=skypal, color=function(x, y) return mix("#d8cfc6", "#cdc8cb", smoothstep(450, 470, y)) end,
  coverage=function(x, y) return 2.4 * lowmist:at(x, y) end, pressure={0.4, 0.8}, dips={16, 0.3, 0.7}, medium=0.65, cluster={0.2, 5}, feather=0.7, aim=false})
