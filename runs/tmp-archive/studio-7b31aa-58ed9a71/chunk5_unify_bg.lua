p_unify = pile{{"raw umber", 6}, {"bone black", 3}, {"yellow ochre", 2}, {"red earth", 1}, medium=0.35}

local m_trans = mask(function(x, y)
  local y_shelf = 533 - 8 * (x / 1000)
  if y < y_shelf and x >= 200 and x <= 750 then
    local t = (x - 200) / 550
    return math.sin(t * math.pi)
  end
  return 0
end)

work(m_trans, {hand="broad", pile=p_unify, angle=0.05, coverage=1.3, fill=true})

local m_wall_all = mask(function(x, y)
  local y_shelf = 533 - 8 * (x / 1000)
  return y < y_shelf and 1 or 0
end)

blend(m_wall_all, {angle=0.02, coverage=1.8})
