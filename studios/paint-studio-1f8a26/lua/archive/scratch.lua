-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7
--@ limbs-join-nearest

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 2}, {"lead white", 3}}, texture=0.35, um=70}, {apply="roller", pile={{"lead white", 8}, {"yellow ochre", 0.35}, {"raw umber", 0.12}}, um=45}}, linen={16, 14}, seed=1774, size=700}

--@ chunk 2
c_zen = pile{{"smalt", 3}, {"cobalt blue", 2}, {"Prussian blue", 0.3}, {"lead white", 0.8}, {"rose madder", 0.2}, name="zen"}
c_top = pile{{"smalt", 3}, {"cobalt blue", 2}, {"Prussian blue", 0.15}, {"lead white", 1.4}, {"rose madder", 0.15}, name="top"}
c_blue = pile{{"lead white", 4}, {"smalt", 2}, {"cobalt blue", 1.2}, name="blue"}
c_gblue = pile{{"lead white", 6}, {"pale smalt", 1.5}, {"cobalt blue", 0.4}, {"Naples yellow", 0.6}, name="gblue"}
c_lemon = pile{{"lead white", 8}, {"Naples yellow", 1.2}, {"chrome yellow", 0.15}, name="lemon"}
c_glow = pile{{"lead white", 5}, {"Naples yellow", 3}, {"chrome yellow", 0.6}, name="glow"}
c_orange = pile{{"lead white", 3}, {"Naples yellow", 2}, {"chrome yellow", 0.4}, {"vermilion", 0.6}, {"red earth", 0.15}, name="orange"}
c_low = pile{{"lead white", 2.5}, {"Naples yellow", 1.5}, {"vermilion", 0.8}, {"red earth", 0.3}, {"rose madder", 0.2}, name="low"}
function hat(y, a, b, c)
  if y <= a or y >= c then return 0 end
  if y <= b then return (y - a) / (b - a) end
  return (c - y) / (c - b)
end
-- stops: pile, y of peak; neighbours define the hats
sky_stops = {{c_zen, 0}, {c_top, 110}, {c_blue, 210}, {c_gblue, 285}, {c_lemon, 345}, {c_glow, 400}, {c_orange, 445}, {c_low, 468}}
function sky_piles(lift)
  local ps = {}
  for i, s in ipairs(sky_stops) do
    local a = (i > 1) and sky_stops[i-1][2] or -300
    local c = (i < #sky_stops) and sky_stops[i+1][2] or 700
    local b = s[2]
    ps[#ps+1] = {s[1], function(x, y)
      local yy = y + (lift and lift(x) or 0)
      return hat(yy, a, b, c) + 0.0005 end}
  end
  return ps
end
work(rect(100, 0, 200, 470), {hand="broad", piles=sky_piles(), angle=0, coverage=3, clip=true, fill=true})
blend(rect(100, 0, 200, 470), {angle=0})
