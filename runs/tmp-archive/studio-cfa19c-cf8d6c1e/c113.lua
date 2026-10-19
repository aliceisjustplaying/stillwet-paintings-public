local flicks = {{165,152,16,4.5},{120,203,10,4},{112,231,9,4},{82,282,11,4},{74,402,17,5},{245,108,13,4},{320,120,8,4},{378,185,12,6},{420,248,13,8},{443,300,16,5},{433,316,9,5},{200,125,7,3}}
local keep = oakSil:shrink(2.5)
local function skyPile(y)
  if y < 130 then return d2
  elseif y < 210 then return d3
  elseif y < 260 then return pile{{"lead white",7},{"pale smalt",1.6},{"cobalt blue",0.4},{"yellow ochre",0.05}, medium=0.1}
  elseif y < 330 then return s4
  else return s5 end
end
for i,f in ipairs(flicks) do
  local m = ellipse(f[1], f[2], f[3]+2.5, f[4]+2.5) - keep
  work(m, {hand="detail", pile=skyPile(f[2]), tool={kind="round", width=2.2, point=0.2}, angle=0.05, coverage=3, fill=true, edge="soft", pressure={0.5,0.8}, seed=1130+i})
  blend(ellipse(f[1], f[2], f[3]+6, f[4]+5) - keep, {tool={kind="badger", width=6}, angle=0.05, coverage=1.2, pressure={0.2,0.35}, seed=1150+i})
end
