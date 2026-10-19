ptab2 = pile{{"raw umber",4},{"yellow ochre",2},{"lead white",1.6},{"smalt",0.5}}
work(tablemask, {hand="broad", pile=ptab2, clip=true, coverage=3.2, angle=0.06, fill=true, seed=201})
bowlmask = mask(function(x,y)
  local hw
  local dy = y - 540
  if dy <= 0 then
    local t = -dy / 34
    if t >= 1 then return 0 end
    hw = 128 * math.sqrt(1 - t*t)
  else
    local t = dy / 96
    if t >= 1 then return 0 end
    hw = math.max(38, 128 * math.sqrt(1 - t*t*t*t))
  end
  if math.abs(x - 640) <= hw then return 1 else return 0 end
end)
work(bowlmask, {hand="body", pile=pbowl, clip=true, coverage=3.5, fill=true, angle=0.25, seed=202})
blend(bowlmask, {seed=203, coverage=1.2, pressure={0.3,0.3}})
