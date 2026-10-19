local cz = rect(0,80,1000,230):soften(20) * sky_m
blend(cz, {angle=0.0, coverage=2.2, clip=true})
blend(cz, {angle=0.25, coverage=1.2, clip=true})
blend(cz, {angle=-0.05, coverage=1.2, clip=true})
local lz = rect(400,340,620,80):soften(20) * sky_m
blend(lz, {angle=0.0, coverage=2.0, clip=true})
blend(lz, {angle=0.2, coverage=1.0, clip=true})
print(wait(0), drying(500,150))
