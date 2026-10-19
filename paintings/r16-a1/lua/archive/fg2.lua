shS = pile{{"lead white",2.2},{"smalt",1.6},{"raw umber",0.3},{"red earth",0.1}, medium=0.1}
local crests = {
 {{-10,603},{120,592},{260,586},{400,590},{500,598}},
 {{540,612},{680,600},{820,596},{1010,606}},
 {{-10,668},{150,656},{320,652},{520,668}},
 {{620,684},{800,668},{1010,662}},
}
local lit, sh
for _,c in ipairs(crests) do
  local ws = {}; local wsd = {}
  for i=1,#c do local t=(i-1)/(#c-1); ws[i] = 3 + 7*math.sin(math.pi*t); wsd[i] = 4 + 10*math.sin(math.pi*t) end
  local shp = {}; for i,p in ipairs(c) do shp[i] = {p[1], p[2] + ws[i]*0.5 + wsd[i]*0.5} end
  local r1 = ribbon(c, ws); local r2 = ribbon(shp, wsd)
  lit = lit and (lit + r1) or r1; sh = sh and (sh + r2) or r2
end
sh = sh - lit
work(sh, {hand="body", pile=shS, angle=0, coverage=2, fill=true, clip=true, length={30,80}})
work(lit, {hand="body", pile=litS, angle=0, coverage=2, fill=true, clip=true, length={30,80}})
blend((lit + sh):grow(6), {angle=0, clip=false})
blend(below(function(x) return 540 end)*above(function(x) return 600 end), {angle=0})
