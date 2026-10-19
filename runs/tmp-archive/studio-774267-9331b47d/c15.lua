local function b(x) return far(x) + 1.5 end
local parts = {}
local function add(m) parts[#parts+1] = m end
-- houses: {x0, x1, wall, roof}
local houses = {{556,566,4,4},{565,574,5,5},{574,586,4,3},{586,596,6,5},{607,622,9,7},{622,652,10,9},{652,662,6,4},{674,712,11,10},{712,720,6,5},{729,758,8,8},{758,768,5,4},{768,780,4,4},{780,792,3,3},{792,800,3,2}}
for _,h in ipairs(houses) do
  local x0, x1, wl, rf = h[1], h[2], h[3], h[4]
  local by = math.max(b(x0), b(x1))
  add(poly({{x0, by}, {x0, by - wl}, {(x0+x1)/2, by - wl - rf}, {x1, by - wl}, {x1, by}}))
end
for _,t in ipairs(TW) do
  local tb = t.top + t.sp
  local by = b(t.x)
  add(rect(t.x - t.w/2, tb, t.w, by - tb))
  if t.x == 668 then
    add(poly({{t.x - t.w/2 - 0.8, tb}, {t.x - 3, tb - 6}, {t.x + 3, tb - 6}, {t.x + t.w/2 + 0.8, tb}}))
    add(poly({{t.x - 1.6, tb - 6}, {t.x, t.top - 8}, {t.x + 1.6, tb - 6}}))
  else
    add(poly({{t.x - t.w/2 - 0.8, tb}, {t.x, t.top}, {t.x + t.w/2 + 0.8, tb}}))
  end
end
TOWN = parts[1]
for i=2,#parts do TOWN = TOWN + parts[i] end
TOWNP = pile{{"pale smalt", 2}, {"lead white", 2}, {"red earth", 0.15}, {"raw umber", 0.22}, {"bone black", 0.05}, medium=0.1}
work(TOWN, {hand="detail", pile=TOWNP, coverage=2.5, fill=true, seed=1501})
