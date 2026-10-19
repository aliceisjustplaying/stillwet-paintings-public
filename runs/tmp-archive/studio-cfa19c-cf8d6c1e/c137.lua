wait(6*60)
local R = mask(function(x,y) return smoothstep(380, 345, y) end)
local nz = noise{seed=166, octaves=3, period=20}
local sh = crownF:shadow{soft=0.5} * oakSil * R
stipple(sh, {pile=fd2, width=4.5, coverage=function(x,y) return clamp(1.3*sh:at(x,y) + 0.4*nz(x,y), 0, 1.6) end, pressure={0.4,0.75}, cluster={0.5, 5}, feather=0.6, dips={18,0.6,0.2}, seed=1511})
-- undersides of each clump, a little shade
local und = oakF:shadow{soft=0.4} * oakSil * R
stipple(und, {pile=fd2, width=3.5, coverage=function(x,y) return clamp(0.8*und:at(x,y) + 0.3*nz(x,y), 0, 1.0) end, pressure={0.35,0.7}, cluster={0.5, 4}, feather=0.7, dips={18,0.6,0.2}, seed=1512})
-- branches seen through the gaps
local gaps = -oakSil:shrink(0.5)
local br = {
  {{{250,470},{238,400},{215,330},{195,260},{185,200}}, {7,6,4.5,3.2,2}},
  {{{255,470},{275,395},{300,320},{320,250},{330,190}}, {7,6,4.5,3.2,2}},
  {{{238,400},{185,352},{140,300}}, {4.5,3.2,2}},
  {{{275,395},{340,360},{392,318}}, {4.5,3.2,2}},
  {{{215,330},{238,262},{250,180}}, {4,3,1.8}},
  {{{300,320},{282,242},{290,160}}, {4,3,1.8}},
  {{{195,260},{160,225},{130,205}}, {3,2.2,1.4}},
  {{{320,250},{360,225},{385,205}}, {3,2.2,1.4}},
}
local B = nil
for _,b in ipairs(br) do local m = ribbon(b[1], b[2]):roughen(0.6, 8, 3); B = B and (B + m) or m end
branchM = B
work(B * gaps * rect(0,100,480,340), {hand="detail", pile=tb3, tool={kind="round", width=1.6, point=0.4}, angle=function(x,y) return -1.3 end, coverage=3, fill=true, clip=true, edge="found", pressure={0.45,0.75}, seed=1513})
