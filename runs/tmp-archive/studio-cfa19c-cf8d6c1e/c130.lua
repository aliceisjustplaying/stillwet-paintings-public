local keep = oakSil:grow(1) + oakM:grow(1) + (cloud2M + townM4):grow(1)
local zone = rect(-10,-10,1020,250) - keep
local bands = {
  {-10, 60,  pile{{"lead white",3},{"cobalt blue",2},{"smalt",1.6}, medium=0.12}},
  {40, 120,  pile{{"lead white",4.5},{"cobalt blue",1.6},{"smalt",1.1},{"pale smalt",0.4}, medium=0.12}},
  {100, 180, pile{{"lead white",6},{"cobalt blue",1.1},{"smalt",0.7},{"pale smalt",0.9}, medium=0.12}},
  {160, 240, pile{{"lead white",8},{"pale smalt",1.6},{"cobalt blue",0.45}, medium=0.12}},
}
for i,b in ipairs(bands) do
  local m = zone * rect(-10, b[1], 1020, b[2]-b[1])
  work(m, {hand="body", pile=b[3], tool="filbert 12", length={60,160}, angle=0.0, coverage=2.2, fill=true, clip=true, pressure={0.45,0.7}, seed=1430+i})
end
blend(rect(-10,-10,1020,300) - keep, {tool={kind="badger", width=24}, angle=0.0, coverage=2.0, clip=true, pressure={0.3,0.5}, seed=1441})
