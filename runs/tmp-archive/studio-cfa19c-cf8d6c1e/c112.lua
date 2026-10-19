local flicks = {{165,152,16,4.5},{120,203,10,4},{112,231,9,4},{82,282,11,4},{74,402,17,5},{245,108,13,4},{320,120,8,4},{378,185,12,6},{420,248,13,8},{443,300,16,5},{433,316,9,5},{200,125,7,3}}
local keep = oakSil:shrink(2.5)
local function skyPile(y)
  if y < 130 then return pile{{"lead white",8},{"pale smalt",1.8},{"cobalt blue",0.45}, medium=0.1}
  elseif y < 210 then return pile{{"lead white",9},{"pale smalt",1.5},{"cobalt blue",0.25},{"yellow ochre",0.04}, medium=0.1}
  elseif y < 290 then return pile{{"lead white",10},{"pale smalt",1.0},{"cobalt blue",0.1},{"yellow ochre",0.12}, medium=0.1}
  elseif y < 360 then return pile{{"lead white",10},{"pale smalt",0.6},{"yellow ochre",0.3},{"vermilion",0.03}, medium=0.1}
  else return pile{{"lead white",10},{"yellow ochre",0.45},{"vermilion",0.06},{"pale smalt",0.15}, medium=0.1} end
end
for i,f in ipairs(flicks) do
  local m = ellipse(f[1], f[2], f[3]+2, f[4]+2) - keep
  work(m, {hand="detail", pile=skyPile(f[2]), tool={kind="round", width=2.2, point=0.2}, angle=0.05, coverage=3, fill=true, edge="soft", pressure={0.5,0.8}, seed=1120+i})
end
