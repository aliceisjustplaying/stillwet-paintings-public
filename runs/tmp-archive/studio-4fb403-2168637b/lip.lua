-- sink the keel into the mud: a ragged lip of mud over the hull's lower edge
local n = noise{seed=611, period=14, octaves=2}
local function yb(x)
  -- hull's lower edge, roughly
  if x < 206 then return lerp(590, 596, (x-192)/14) end
  if x < 240 then return lerp(596, 600, (x-206)/34) end
  if x < 300 then return lerp(600, 601, (x-240)/60) end
  if x < 352 then return lerp(601, 595, (x-300)/52) end
  return lerp(595, 583, (x-352)/18)
end
lipM = hull2:grow(1.5) * mask(function(x,y)
  if x < 188 or x > 368 then return 0 end
  local t = yb(x) - 4.5 - 2.2*n(x, 0)
  return y > t and 1 or 0 end)
local lipP = pile{{"raw umber",2.6},{"red earth",0.55},{"bone black",0.3},{"lead white",0.5},{"smalt",0.35}}
work(lipM, {hand="detail", tool={kind="flat", width=2.5}, pile=lipP, angle=0.02, coverage=3, length={6,18}, fill=true, clip=true, load=0.8})
-- a dark crease where hull meets mud
local cr = brush{kind="round", width=1.4, point=0.5}
local pts = {}
for x = 196, 364, 6 do pts[#pts+1] = {x, yb(x) - 4.5 - 2.2*n(x,0) - 0.3} end
cr:reload(pile{{"bone black",1},{"raw umber",1.5}}, 0.6)
cr:stroke(pts, {pressure={0.5,0.35}, shake=0.4})
