wait(60*24*4)
local keep = oakSil:shrink(1)
local function skyAt(y)
  if y < 140 then return pile{{"lead white",3.6},{"cobalt blue",1.5},{"smalt",1.2},{"pale smalt",0.5},{"raw umber",0.1},{"yellow ochre",0.05}, medium=0.1}
  elseif y < 215 then return pile{{"lead white",4.3},{"cobalt blue",1.35},{"smalt",1.05},{"pale smalt",0.5},{"raw umber",0.1},{"yellow ochre",0.07}, medium=0.1}
  elseif y < 265 then return pile{{"lead white",5.2},{"cobalt blue",1.0},{"smalt",0.6},{"pale smalt",0.9},{"raw umber",0.08},{"yellow ochre",0.14}, medium=0.1}
  elseif y < 340 then return pile{{"lead white",7},{"pale smalt",0.8},{"cobalt blue",0.3},{"yellow ochre",0.4},{"vermilion",0.03},{"raw umber",0.04}, medium=0.1}
  else return pile{{"lead white",8},{"yellow ochre",0.5},{"vermilion",0.05},{"pale smalt",0.3},{"raw umber",0.04}, medium=0.1} end
end
local spots = {{165,152,26,12},{120,203,22,11},{112,231,20,10},{82,282,20,10},{74,402,22,10},{245,108,28,12},{320,120,22,11},{378,185,22,12},{420,248,22,13},{443,300,22,12},{433,316,16,10},{200,125,18,10},{150,112,20,10}}
for i,s in ipairs(spots) do
  local m = ellipse(s[1], s[2], s[3], s[4]):soften(3) - keep
  work(m, {hand="body", pile=skyAt(s[2]), tool={kind="filbert", width=5}, angle=0.05, coverage=2.2, fill=true, edge="soft", pressure={0.45,0.7}, seed=1280+i})
end
for i,s in ipairs(spots) do
  blend(ellipse(s[1], s[2], s[3]+5, s[4]+4) - keep, {tool={kind="badger", width=8}, angle=0.05, coverage=1.4, pressure={0.2,0.35}, seed=1300+i})
end
