function edgeX(list, y)
  if y <= list[1][2] then return list[1][1] end
  for i = 1, #list - 1 do
    local a, b = list[i], list[i+1]
    if y >= a[2] and y <= b[2] then
      local u = (y - a[2]) / (b[2] - a[2])
      return lerp(a[1], b[1], u)
    end
  end
  return list[#list][1]
end
jp = {
  pile{{"lead white",8},{"yellow ochre",0.2}},
  pile{{"lead white",6},{"yellow ochre",0.4},{"raw umber",0.1}},
  pile{{"lead white",5},{"yellow ochre",0.5},{"raw umber",0.3},{"green earth",0.2}},
  pile{{"lead white",4},{"yellow ochre",0.5},{"raw umber",0.6},{"green earth",0.4},{"bone black",0.05}},
  pile{{"lead white",3},{"raw umber",0.9},{"yellow ochre",0.4},{"green earth",0.5},{"bone black",0.15}},
  pile{{"lead white",2},{"raw umber",1},{"green earth",0.6},{"bone black",0.3},{"yellow ochre",0.3}},
  pile{{"lead white",3},{"yellow ochre",0.8},{"raw umber",0.7},{"red earth",0.1}},
}
function jIdx(t, y)
  local i
  if t < 0.06 then i = 3
  elseif t < 0.14 then i = 2
  elseif t < 0.34 then i = (y > 290 and y < 470) and 1 or 2
  elseif t < 0.44 then i = 2
  elseif t < 0.52 then i = 3
  elseif t < 0.60 then i = 4
  elseif t < 0.68 then i = 5
  elseif t < 0.86 then i = 6
  else i = (y > 360) and 7 or 5 end
  if y > 530 and i < 6 then i = i + 1 end
  if y > 570 and i < 6 then i = i + 1 end
  return i
end
