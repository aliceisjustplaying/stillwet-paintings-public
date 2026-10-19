-- banks of the mere. far shore: the bank's shaded face as a thin dark lip over the ice
local far = {}
for x = 425, 912, 6 do
  -- the far edge of the ice, found from the outline points
  far[#far+1] = x
end
local function farEdge(x)
  -- interpolate the far (upper) edge of merePts
  local up = {{410,570},{420,560},{470,551},{540,548},{620,547},{700,549},{780,548},{850,551},{905,557},{918,566}}
  for i = 1, #up - 1 do
    if x <= up[i+1][1] then local t = (x - up[i][1]) / (up[i+1][1] - up[i][1]); return lerp(up[i][2], up[i+1][2], t) end
  end
  return 566
end
function nearEdge(x)
  local lo = {{410,570},{428,580},{470,590},{530,597},{600,601},{680,601},{760,596},{840,588},{895,578},{918,566}}
  for i = 1, #lo - 1 do
    if x <= lo[i+1][1] then local t = (x - lo[i][1]) / (lo[i+1][1] - lo[i][1]); return lerp(lo[i][2], lo[i+1][2], t) end
  end
  return 566
end
mereFar = farEdge
bankLip = pile{{"smalt",1.5},{"bone black",0.4},{"lead white",1},{"raw umber",0.3}, medium=0.2}
local lipPts, lipW = {}, {}
for x = 440, 900, 5 do lipPts[#lipPts+1] = {x, farEdge(x) + 1.2 + 0.6 * math.sin(x / 7)}; lipW[#lipW+1] = rand(1.4, 3.0) end
local lip = ribbon(lipPts, lipW):roughen(0.6, 4, 17)
work(lip, {hand="detail", pile=bankLip, load=0.8, pressure={0.5, 0.8}, coverage=3, fill=true, angle=0, clip=true})
-- near shore: snow lobes pushed out over the edge of the ice
nearSnow = pile{{"lead white",5},{"pale smalt",1.2},{"smalt",0.25},{"vermilion",0.05},{"yellow ochre",0.05}, medium=0.12}
local m = nil
for x = 415, 912, 7 do
  local e = nearEdge(x)
  local r = rand(4, 11)
  local l = ellipse(x + rand(-3, 3), e + rand(0, 3), r, r * rand(0.25, 0.45))
  m = m and (m + l) or l
end
nearBankM = (m:roughen(0.8, 5, 19) * below(function(x) return 540 end))
work(nearBankM, {hand="detail", pile=nearSnow, load=0.9, pressure={0.5, 0.8}, coverage=3, fill=true, angle=0, clip=true})
