-- tone the white-topped willows: green-silver cluster stipple over the tops, smaller & cooler
local wS3 = pile{{"lead white",1.6},{"green earth",1.8},{"pale smalt",0.5},{"yellow ochre",0.7},{"raw umber",0.12}, medium=0.08}
local wS4 = pile{{"lead white",1.0},{"green earth",1.8},{"yellow ochre",0.8},{"Prussian blue",0.08},{"raw umber",0.3}, medium=0.08}
for i,w in ipairs(WL) do
  local x, y, s = w[1], w[2], w[3]
  local hy = y - 32*s
  local m = CROWN2[i]:shrink(0.5*s)
  local wid = math.max(1.0, 2.3*s)
  local up = m * mask(function(xx,yy) local d = (yy - (hy - 45*s))/(40*s) - (xx - x)/(90*s); return 1 - smoothstep(0.0, 1.0, d) end)
  stipple(up, {pile=wS3, width=wid, coverage=function(xx,yy) return 1.8*up:at(xx,yy) end, pressure={0.5,0.85}, cluster={0.6, 4*s+2}, dips={8,0.7,0.4}})
  -- dark hollows in the crown, lower right
  local low = m * mask(function(xx,yy) local d = (yy - (hy - 30*s))/(30*s) + (xx - x)/(60*s); return smoothstep(0.1, 0.9, d) end)
  stipple(low, {pile=wD2, width=wid, coverage=function(xx,yy) return 1.2*low:at(xx,yy) end, pressure={0.5,0.85}, cluster={0.7, 5*s+2}, feather=0.5, dips={8,0.7,0.4}})
end
print(wait(0))
