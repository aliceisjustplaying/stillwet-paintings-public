local function b(x) return far(x) + 1.5 end
TW = {{x=602, top=310, w=12, sp=30, body=348}, {x=668, top=322, w=15, sp=0, body=338}, {x=726, top=324, w=11, sp=26, body=352}}
local parts = {}
local function add(m) parts[#parts+1] = m end
local houses = {{554,563,4,4},{563,572,5,5},{572,584,4,3},{584,594,6,5},
  {606,652,13,12},{652,660,6,4},{675,716,14,13},{716,722,6,5},{731,764,10,9},{764,772,5,4},{772,784,4,4},{784,795,3,3},{795,803,3,2}}
for _,h in ipairs(houses) do
  local x0, x1, wl, rf = h[1], h[2], h[3], h[4]
  local by = math.max(b(x0), b(x1))
  add(poly({{x0, by}, {x0, by - wl}, {x0 + 1.5, by - wl - rf}, {x1 - 1.5, by - wl - rf}, {x1, by - wl}, {x1, by}}))
end
for _,t in ipairs(TW) do
  local by = b(t.x)
  add(rect(t.x - t.w/2, t.body, t.w, by - t.body))
  if t.sp == 0 then
    -- the great tower: a low hipped cap with a slim lantern and needle
    add(poly({{t.x - t.w/2 - 0.8, t.body}, {t.x - 3.5, t.body - 7}, {t.x + 3.5, t.body - 7}, {t.x + t.w/2 + 0.8, t.body}}))
    add(rect(t.x - 1.8, t.body - 12, 3.6, 5.5))
    add(poly({{t.x - 2.3, t.body - 12}, {t.x, t.top}, {t.x + 2.3, t.body - 12}}))
  else
    add(poly({{t.x - t.w/2 - 0.8, t.body}, {t.x, t.top}, {t.x + t.w/2 + 0.8, t.body}}))
  end
end
TOWN = parts[1]
for i=2,#parts do TOWN = TOWN + parts[i] end
TOWNP = pile{{"pale smalt", 2}, {"smalt", 0.6}, {"lead white", 1.1}, {"raw umber", 0.4}, {"red earth", 0.18}, {"bone black", 0.1}, medium=0.08}
work(TOWN, {hand="detail", pile=TOWNP, coverage=3, fill=true, seed=1601})
