chp = pile{{"lead white",4},{"smalt",1.3},{"raw umber",0.15},{"red earth",0.08}, medium=0.2}
church = poly({{168,455},{168,418},{171,414},{200,392},{204,390},{230,413},{234,417},{234,455}})
tower = poly({{236,455},{236,380},{239,376},{241,379},{243,373},{246,377},{249,371},{251,376},{252,455}})
-- buttress stubs
church = church + rect(165,425,5,30) + rect(232,422,5,33) + rect(198,386,5,8)
work(church + tower, {hand="detail", pile=chp, coverage=3, fill=true, angle=math.pi/2})
-- window openings showing the lemon sky
winp = pile{{"lead white",4},{"chrome yellow",0.3},{"yellow ochre",0.3}}
local wins = nil
for _,wx in ipairs({184,200,216}) do
  local wm = poly({{wx-3,445},{wx-3,420},{wx,414},{wx+3,420},{wx+3,445}})
  wins = wins and (wins+wm) or wm
end
wins = wins + poly({{241,410},{241,396},{244,392},{247,396},{247,410}})
work(wins, {hand="detail", pile=winp, coverage=3, fill=true, angle=math.pi/2, tool={kind="round", width=1.4, point=0.8}})
-- firs in front of the church, restated
work(firs2 * rect(150,380,110,90), {hand="detail", pile=fw, coverage=2.5, fill=true, angle=math.pi/2})
