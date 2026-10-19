local bp = pile{{"raw umber",1},{"bone black",0.5},{"lead white",0.7},{"pale smalt",0.4}, medium=0.08}
local r = brush{kind="rigger", width=0.9, point=1}
r:load(bp, 0.5)
local function bird(x, y, s, tilt)
  -- two slightly curved wings meeting at the body
  local a = tilt or 0
  local function R(u,v) return {x + (u*math.cos(a) - v*math.sin(a))*s, y + (u*math.sin(a) + v*math.cos(a))*s} end
  r:stroke({R(-4,-1.2), R(-2,-1.4), R(0,0)}, {pressure={0.1,0.6}})
  r:stroke({R(0,0), R(2,-1.6), R(4.5,-1.0)}, {pressure={0.6,0.1}})
  if r:fullness() < 0.3 then r:reload(bp, 0.5) end
end
bird(612, 300, 1.3, 0.1)
bird(640, 288, 1.1, -0.15)
bird(598, 318, 0.9, 0.2)
bird(830, 180, 1.0, 0.05)
bird(360, 250, 0.8, -0.1)
-- a lark high up, tiny
bird(470, 160, 0.6, 0)
print(wait(0))
