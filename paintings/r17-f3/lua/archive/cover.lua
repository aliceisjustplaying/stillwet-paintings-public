local REG = LAND * mask(function(x,y) return (x < 440 and y > 452 and y < 600) and 1 or 0 end) - MILL:grow(1) - FIGS:grow(1) - poly{{84,464},{84,443},{120,443},{120,464}} - PATH:shrink(1)
COVREG = REG
local nz = noise{seed=77, period=120, octaves=3}
local function z(a,b) return REG * mask(function(x,y) local yy = y + 5*nz(x,y*3); return smoothstep(a-5,a+5,yy)*(1-smoothstep(b-5,b+5,yy)) end) end
local riseC = pile{{"lead white",1.8},{"green earth",1.9},{"yellow ochre",0.7},{"pale smalt",0.75},{"raw umber",0.2}, medium=0.1}
local farC  = pile{{"lead white",1.6},{"green earth",1.7},{"yellow ochre",1.0},{"pale smalt",0.4},{"Prussian blue",0.05},{"raw umber",0.15}, medium=0.1}
local litC  = pile{{"lead white",1.2},{"yellow ochre",1.7},{"chrome yellow",0.5},{"green earth",0.9},{"Prussian blue",0.12}, medium=0.1}
local shC   = pile{{"lead white",0.9},{"green earth",1.5},{"yellow ochre",1.0},{"Prussian blue",0.3},{"raw umber",0.4},{"pale smalt",0.3}, medium=0.1}
local Z = {{riseC,440,488,"filbert 5",{8,20}},{farC,484,506,"filbert 5",{10,25}},{litC,503,532,"filbert 6",{12,30}},{shC,529,578,"filbert 7",{15,35}},{litC,575,610,"filbert 8",{15,40}}}
for i,zz in ipairs(Z) do
  work(z(zz[2],zz[3]), {hand="body", pile=zz[1], tool=zz[4], clip=REG, angle=0, angle_jitter=0.05, length=zz[5], coverage=2.2, fill=true, load=0.8, threshold=0.4})
end
print(wait(0))
