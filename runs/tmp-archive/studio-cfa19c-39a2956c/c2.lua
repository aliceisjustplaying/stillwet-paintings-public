print(wait(60*6))
local redL = pile{{"red earth",0.8},{"yellow ochre",1.1},{"lead white",1.4}, medium=0.05}
local redD = pile{{"raw umber",1.5},{"red earth",0.7},{"bone black",0.35}, medium=0.05}
local wh = pile{{"lead white",3},{"yellow ochre",0.2},{"raw umber",0.12}, medium=0.05}
local blkL = pile{{"bone black",0.6},{"raw umber",0.6},{"lead white",1.2},{"pale smalt",0.3}, medium=0.05}
local function band(c, lo, hi, x, y, L) return (c[1]+c[2]) * mask(function(px,py) return smoothstep(y+lo*L-1, y+lo*L, py) * smoothstep(y+hi*L+1, y+hi*L, py) end) end
local specs = {{cowA, 650, 612, 20, redL, redD}, {cowB, 700, 612, 21, blkL, nil}, {cowC, 860, 640, 23, redL, redD}}
for i,s in ipairs(specs) do
  local c, x, y, L = s[1], s[2], s[3], s[4]
  local all = c[1] + c[2]
  local top = all * mask(function(px,py) return smoothstep(y-0.5*L, y-0.57*L, py) end)
  work(top, {hand="detail", pile=s[5], tool={kind="round", width=1.0, point=0.3}, angle=0.05, coverage=2, clip=true, seed=3200+i})
  if s[6] then
    local bel = all * mask(function(px,py) return smoothstep(y-0.34*L, y-0.27*L, py) end)
    work(bel, {hand="detail", pile=s[6], tool={kind="round", width=1.0, point=0.3}, angle=0.05, coverage=2, clip=true, seed=3210+i})
  end
end
-- the black cow: white patches on flank and a white face
local x, y, L = 700, 612, 21
local p1 = poly({{700-0.15*L, y-0.52*L},{700+0.1*L, y-0.55*L},{700+0.15*L, y-0.36*L},{700-0.05*L, y-0.27*L},{700-0.22*L, y-0.33*L}}, true) * cowB[1]
local p2 = poly({{700-0.5*L, y-0.45*L},{700-0.38*L, y-0.5*L},{700-0.35*L, y-0.3*L},{700-0.5*L, y-0.3*L}}, true) * cowB[1]
local face = poly({{700+0.6*L, y-0.62*L},{700+0.7*L, y-0.6*L},{700+0.72*L, y-0.47*L},{700+0.65*L, y-0.45*L}}, true) * cowB[2]
work(p1 + p2 + face, {hand="detail", pile=wh, tool={kind="round", width=1.0, point=0.3}, angle=0.3, coverage=3, fill=true, clip=true, seed=3221})
-- small horns and ears
local hb = brush{kind="rigger", width=0.6, point=1}
local horn = pile{{"lead white",2},{"yellow ochre",0.5},{"raw umber",0.3}, medium=0.05}
hb:reload(horn, 0.4)
hb:stroke({{700+0.6*L, y-0.63*L},{700+0.58*L, y-0.7*L}}, {pressure={0.5,0.1}})
hb:stroke({{860-0.6*23, 640-0.63*23},{860-0.58*23, 640-0.7*23}}, {pressure={0.5,0.1}})
