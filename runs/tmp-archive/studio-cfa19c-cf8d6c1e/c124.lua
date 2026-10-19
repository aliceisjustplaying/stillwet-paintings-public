wait(60*24*3)
local keep = oakSil:shrink(2.5)
local spots = {{165,152},{120,203},{112,231},{82,282},{74,402},{245,108},{320,120},{378,185},{420,248},{443,300},{433,316},{200,125}}
local function skyAt(y)
  if y < 140 then return pile{{"lead white",4},{"cobalt blue",1.5},{"smalt",1.2},{"pale smalt",0.4},{"raw umber",0.08}, medium=0.3}
  elseif y < 215 then return pile{{"lead white",5},{"cobalt blue",1.3},{"smalt",1.0},{"pale smalt",0.5},{"raw umber",0.08},{"yellow ochre",0.05}, medium=0.3}
  elseif y < 265 then return pile{{"lead white",6},{"pale smalt",1.1},{"cobalt blue",0.8},{"smalt",0.4},{"yellow ochre",0.12}, medium=0.3}
  elseif y < 340 then return pile{{"lead white",8},{"pale smalt",0.5},{"cobalt blue",0.15},{"yellow ochre",0.4},{"vermilion",0.02}, medium=0.3}
  else return pile{{"lead white",9},{"yellow ochre",0.5},{"vermilion",0.05},{"pale smalt",0.2}, medium=0.3} end
end
for i,s in ipairs(spots) do
  local m = ellipse(s[1], s[2], 24, 13):soften(4) - keep
  work(m, {hand="scumble", pile=skyAt(s[2]), tool={kind="filbert", width=5}, angle=0.05, coverage=1.2, load=0.35, edge="lost", pressure={0.3,0.5}, seed=1240+i})
  blend(ellipse(s[1], s[2], 26, 14) - keep, {tool={kind="badger", width=8}, angle=0.05, coverage=1.3, pressure={0.2,0.35}, seed=1260+i})
end
