bowlmask = mask(function(x,y)
  local hw
  local dy = y - 540
  if dy <= 0 then
    local t = -dy / 34
    if t >= 1 then return 0 end
    hw = 128 * math.sqrt(1 - t*t)
  else
    local t = dy / 96
    if t >= 1 then return 0 end
    hw = 30 + 98 * (1 - t*t)^0.7
  end
  if math.abs(x - 640) <= hw then return 1 else return 0 end
end)
oldring = ellipse(640,548,215,105) - bowlmask
print("ring", oldring:area())
work(oldring, {hand="body", pile=ptab, clip=true, coverage=3.5, fill=true, seed=191})
work(bowlmask, {hand="body", pile=pbowl, clip=true, coverage=3.5, fill=true, angle=0.25, seed=192})
blend(bowlmask, {seed=193, coverage=1.2, pressure={0.3,0.3}})
