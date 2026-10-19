local FB2 = LAND * mask(function(x,y) return (y < rtop(x) - 0.3 or x < 345) and y < 492 and 1 or 0 end) - MILL:grow(0.5) - TOWN:grow(0.5) - FARTREES - RIVER:grow(0.3) - CROWNS_ALL:grow(0.5) - ENV[10]:grow(0.5) - ENV[9]:grow(0.5) - FIGS:grow(0.8) - poly{{86,463},{86,445},{118,445},{118,463}}
local nn = noise{seed=313, period=40, octaves=2}
local joinm = FB2 * mask(function(x,y) local d = math.abs(x - 380 + 25*nn(x,y)); return 1 - smoothstep(20, 70, d) end)
local jp = pile{{"lead white",2.0},{"green earth",1.8},{"yellow ochre",0.65},{"pale smalt",0.8},{"raw umber",0.18}, medium=0.1}
work(joinm, {hand="hatch", pile=jp, tool={kind="round", width=1.1, point=0.7}, angle=0.01, angle_jitter=0.1, length={4,12}, coverage=1.6, clip=true, seed=1001, threshold=0.2, load=0.6})
-- far hedgerows and tree clumps across the flat
local hedgeP = pile{{"lead white",1.8},{"green earth",1.5},{"pale smalt",1.0},{"raw umber",0.35}, medium=0.1}
local hedges = nil
local function add(m) hedges = hedges and (hedges + m) or m end
add(ribbon({{395,476},{450,475.5},{505,475}}, 1.1))
add(ribbon({{830,474},{900,473.5},{990,473}}, 1.0))
for _,c in ipairs({{412,473.5,5,3},{432,474,3,2.2},{520,472.5,6,3.5},{535,473,4,2.6},{848,471.8,5,3},{925,471.5,7,3.6},{940,472,4,2.5},{975,471.5,5,3}}) do
  add(ellipse(c[1], c[2], c[3], c[4]) * above(function(x) return c[2] + 2 end))
end
hedges = hedges:roughen(0.8, 3, 1002) - FIGS:grow(0.8) - TOWN
stipple(hedges, {pile=hedgeP, width=1.2, coverage=3, pressure={0.5,0.8}, cluster=0.3})
-- far cattle, tiny
local cow = pile{{"red earth",0.8},{"raw umber",0.8},{"lead white",1.2},{"pale smalt",0.4}, medium=0.08}
local cowW = pile{{"lead white",3},{"raw umber",0.2},{"pale smalt",0.3}, medium=0.08}
local r = brush{kind="round", width=1.0, point=0.3}
for _,c in ipairs({{870,478.5,cow},{878,479,cowW},{884,478.2,cow},{620,479.5,cowW}}) do
  r:reload(c[3], 0.5)
  r:stroke({{c[1]-1.6,c[2]},{c[1]+1.6,c[2]}}, {pressure={0.7,0.7}})
end
print(wait(0))
