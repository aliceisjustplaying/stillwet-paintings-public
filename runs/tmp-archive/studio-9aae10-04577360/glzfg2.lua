local band = below(function(x) return 578 + 12*math.sin(x/140) end) * above(function(x) return 625 + 12*math.sin(x/140) end)
blend(band, {angle=0, clip=false})
blend(band, {angle=0.1, clip=false})
