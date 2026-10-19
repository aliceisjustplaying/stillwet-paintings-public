print(drying(850,410), drying(800,425), drying(900,400))
local birdp = pile{{"raw umber",1},{"bone black",0.4},{"smalt",0.3},{"lead white",0.5}, medium=0.15}
local rg = brush{kind="rigger", width=1.1, point=1}
local function bird(x, y, s, tilt)
  rg:reload(birdp, 0.5)
  local lw = {x - s, y - s*0.35 + tilt}
  local rw = {x + s, y - s*0.4 - tilt}
  rg:stroke({lw, {x - s*0.45, y - s*0.45 + tilt*0.5}, {x, y}}, {pressure={0.1,0.55}, ramps={0.4,0.05}})
  rg:stroke({{x, y}, {x + s*0.45, y - s*0.5 - tilt*0.5}, rw}, {pressure={0.55,0.05}, ramps={0.05,0.5}})
end
bird(548, 262, 5.5, 0.5)
bird(566, 251, 4.5, -0.6)
bird(589, 270, 3.8, 0.3)
bird(530, 281, 3.2, -0.3)
bird(612, 258, 2.8, 0.4)
