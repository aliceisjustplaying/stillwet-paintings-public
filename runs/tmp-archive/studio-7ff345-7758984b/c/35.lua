-- the knoll, restated: a clear crest against the glow, its face in cool shade, the oak's foot in the snow
local cx = {{-10,420},{0,418},{60,410},{120,403},{180,399},{240,405},{300,414},{360,426},{420,440},{480,455},{540,466},{600,469},{1010,469}}
function knollCrest(x)
  for i = 1, #cx - 1 do
    if x <= cx[i+1][1] then
      local t = (x - cx[i][1]) / (cx[i+1][1] - cx[i][1])
      t = t * t * (3 - 2 * t)
      return lerp(cx[i][2], cx[i+1][2], t) + 1.2 * math.sin(x / 11) + 0.8 * math.sin(x / 4.3)
    end
  end
  return 469
end
-- the drift at the oak's foot: a line across the trunk, banked up a little at its sides
function footLine(x)
  local d = (x - 238) / 40
  return 442 - 7 * math.exp(-d * d * 1.5) * 0 + 6 * d * d * 0 - 4 * math.exp(-((x - 205)/10)^2) - 5 * math.exp(-((x - 272)/10)^2)
end
knollShade = pile{{"lead white",3},{"pale smalt",1},{"smalt",0.6},{"bone black",0.12},{"vermilion",0.05}, medium=0.12}
local face = below(knollCrest) * above(function(x) return 520 end)
local trunkUp = oakLive * above(footLine)
knollFace = (face - trunkUp) * mask(function(x, y) return x < 620 and 1 or 0 end)
work(knollFace * mask(function(x,y) return y < 470 and 1 or 0 end), {hand="body", pile=knollShade,
   angle=function(x, y) return 0.1 * math.cos((x - 180) / 150) end,
   length={30, 80}, coverage=2.8, fill=true, pressure={0.5, 0.8}, seed=351, edge="found"})
-- let it fade into the plain below the knoll
local lowFade = knollFace * mask(function(x, y) return (y >= 462) and 1 or 0 end)
work(lowFade, {hand="body", pile=knollShade, angle=0.05, length={30, 80}, coverage=2.0, pressure={0.4, 0.65},
   load_at=function(x, y) return 0.7 * (1 - smoothstep(462, 510, y)) + 0.05 end, seed=352})
blend(knollFace * mask(function(x,y) return y > 430 and 1 or 0 end), {angle=0.05})
