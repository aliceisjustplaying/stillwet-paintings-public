local dark = pile{{"pale smalt", 1.5}, {"smalt", 0.8}, {"lead white", 0.9}, {"raw umber", 0.5}, {"red earth", 0.2}, {"bone black", 0.1}, medium=0.1}
work(TOWN, {hand="detail", pile=dark, coverage=2.5, fill=true, seed=2901})
-- lit west faces of the towers and gable ends
local litp = pile{{"lead white", 2.2}, {"pale smalt", 0.9}, {"red earth", 0.25}, {"yellow ochre", 0.3}, {"raw umber", 0.1}, medium=0.1}
local litm = nil
for _,t in ipairs(TW) do
  local by = far(t.x) + 1.5
  local r = rect(t.x - t.w/2, t.body, t.w*0.38, by - t.body - 4)
  litm = litm and (litm + r) or r
  if t.sp > 0 then
    local s = poly({{t.x - t.w/2 - 0.8, t.body}, {t.x, t.top}, {t.x - 0.2, t.body}})
    litm = litm + s
  end
end
litm = litm * TOWN
work(litm, {hand="detail", pile=litp, coverage=2, fill=true, seed=2902})
