local sil = BOULD
local gz = pile{{"raw umber", 0.6}, {"smalt", 0.6}, {"bone black", 0.25}, medium=0.7}
local function ld(x, y)
  local v = BF:value(x, y)
  local top = 572 + 0.004*(x - 800)^2
  local down = clamp((y - top)/45, 0, 1)
  return clamp((0.75 - v)*0.9 + down*0.3, 0.0, 0.8)
end
local shadowish = sil * mask(function(x, y) return (ld(x, y) > 0.08) and 1 or 0 end)
work(shadowish, {hand="detail", tool={kind="round", width=2.4, point=0.3}, pile=gz, angle=BF:field("across"), coverage=1.8, fill=true, load_at=ld, seed=10001})
