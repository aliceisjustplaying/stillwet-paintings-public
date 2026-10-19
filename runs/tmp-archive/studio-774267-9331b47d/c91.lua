local sil = BOULD
local gz = pile{{"raw umber", 1}, {"smalt", 0.5}, {"bone black", 0.3}, medium=0.6}
local function ld(x, y)
  local v = BF:value(x, y)
  local top = 572 + 0.004*(x - 800)^2
  local down = clamp((y - top)/40, 0, 1)
  return clamp(0.15 + (1 - v)*0.55 + down*0.35, 0.1, 0.85)
end
work(sil, {hand="detail", tool={kind="round", width=3, point=0.3}, pile=gz, angle=BF:field("across"), coverage=1.8, fill=true, load_at=ld, seed=9101})
