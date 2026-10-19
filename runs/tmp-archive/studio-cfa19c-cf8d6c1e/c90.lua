local town = (townM + townM2):grow(3)
local cut = rect(0,0,1000,413)
local shd = cloud2F:shadow{} * cut - town
local csd = pile{{"lead white",5},{"pale smalt",1.5},{"smalt",0.25},{"red earth",0.3},{"raw umber",0.25},{"yellow ochre",0.1}, medium=0.08}
work(shd, {hand="body", tool="filbert 6", pile=csd, angle=cloud2F:field("across"), coverage=2.0, clip=true, pressure={0.45,0.7}, seed=911})
-- the base in shadow: a band along the lower part of the cloud
local base = cloud2M * mask(function(x,y) return smoothstep(365, 400, y) end) - town
work(base, {hand="body", tool="filbert 6", pile=csd, angle=0.05, coverage=1.8, clip=true, pressure={0.4,0.65}, seed=912})
