pBird = pile{{"raw umber",1.5},{"bone black",0.6},{"smalt",0.3},{"lead white",0.3}}
local r = brush{kind="rigger", width=1.5, point=1}
local function bird(x, y, s, tilt)
  r:reload(pBird, 0.6)
  r:stroke({{x - 6*s, y - 2.5*s + tilt}, {x - 3*s, y - 3*s + tilt*0.5}, {x, y}}, {pressure={0.1, 0.6}, ramps={0.3, 0.1}})
  r:reload(pBird, 0.6)
  r:stroke({{x, y}, {x + 3*s, y - 3.2*s - tilt*0.5}, {x + 6.5*s, y - 2*s - tilt}}, {pressure={0.6, 0.1}, ramps={0.1, 0.3}})
end
bird(770, 368, 1.0, 0.5)
bird(796, 378, 0.8, -0.6)
