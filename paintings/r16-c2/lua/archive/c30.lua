local function lensP(cx, cy, rx, ry, seed)
  local nn = noise{seed=seed, period=25, octaves=2}
  return mask(function(x,y) local t = (x-cx)/rx; if math.abs(t) >= 1 then return 0 end; local w = ry*(1-t*t)^0.7*(0.7+0.5*nn(x,0)); return (math.abs(y-cy-2*nn(x,9)) < w) and 1 or 0 end)
end
pools = lensP(110,606,60,4,1) + lensP(250,598,38,3,2) + lensP(60,652,80,6,3) + lensP(320,632,55,4.5,4) + lensP(215,688,75,7,5) + lensP(400,662,40,4,6) + lensP(940,612,45,3.5,7) + lensP(920,668,60,6,8) + lensP(180,630,30,2.5,9)
pools = pools * (mudL2:shrink(6) + mudR2:shrink(6))
poolP = pile{{"lead white",2.2},{"cobalt blue",0.8},{"smalt",0.2},{"red earth",0.2},{"raw umber",0.25}}
work(pools, {hand="detail", tool="round 3", pile=poolP, angle=0, coverage=3, length={10,40}, fill=true, clip=true})
