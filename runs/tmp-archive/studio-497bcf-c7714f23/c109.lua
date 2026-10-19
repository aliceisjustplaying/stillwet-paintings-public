local umb = nil
local cnt = 0
for i = 1, 200 do
  local x, y = rand(852, 1000), rand(476, 615)
  if elder2:at(x, y) > 0.95 and elder2:at(x, y - 5) > 0.6 and cnt < 34 then
    local s = 1.8 + (y - 470) / 55
    local e = ellipse(x, y, s, s * 0.5)
    local ok = true
    if umb and umb:at(x, y) > 0.1 then ok = false end
    if ok then umb = umb and (umb + e) or e cnt = cnt + 1 end
  end
end
umbels = umb
stipple(umb, {pile=elderFs, width=1.6, coverage=2.5, pressure={0.35,0.6}, clip=umb:grow(0.6), cluster=0.3})
local top = umb * mask(function(x,y) return 1 end) - umb:offset(0.6)
stipple(umb:shrink(0.3), {pile=elderF, width=1.3, coverage=1.6, pressure={0.35,0.55}, clip=umb:grow(0.4), cluster=0.4})
print(cnt, wait(0))
