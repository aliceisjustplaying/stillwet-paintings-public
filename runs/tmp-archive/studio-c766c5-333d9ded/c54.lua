pwsh = pile{{"raw umber",2},{"smalt",1},{"bone black",0.55}, medium=0.2}
wsh = mask(function(x,y)
  local cx = 402 + 0.14*(y-300)
  local d = math.abs(x - cx) / 98
  local v = clamp(1 - d*d, 0, 1)
  local h = clamp(1 - ((y-352)/155)^2, 0, 1)
  return v * h
end):soften(45)
work(wsh * (wallmask - objall), {hand="glaze", pile=pwsh, clip=true, coverage=1.8, seed=561})
wsh2 = mask(function(x,y)
  local cx = 500 + 0.10*(y-300)
  local d = math.abs(x - cx) / 70
  local v = clamp(1 - d*d, 0, 1)
  local h = clamp(1 - ((y-380)/120)^2, 0, 1)
  return v * h
end):soften(50)
work(wsh2 * (wallmask - objall), {hand="glaze", pile=pwsh, clip=true, coverage=1.2, seed=562})
blend((wsh + wsh2):soften(60) * (wallmask - objall), {seed=563, coverage=1.2, pressure={0.3,0.3}})
