straw = pile{{"yellow ochre",1},{"lead white",0.8},{"raw umber",0.35}, medium=0.1}
strawD = pile{{"raw umber",1.5},{"bone black",0.2},{"yellow ochre",0.5}, medium=0.1}
function tuft(x, y, s, n, seed, lean)
  math.randomseed(seed)
  local b = brush{kind="rigger", width=math.max(1.2, 1.6*s), point=1}
  for i=1,n do
    local p = (math.random() < 0.55) and straw or strawD
    b:reload(p, 0.6)
    local bx = x + randn(0, 3*s)
    local h = rand(8, 22) * s
    local a = -math.pi/2 + randn(lean or 0.15, 0.35)
    local bend = randn(0.25, 0.2)
    local pts = {{bx, y + rand(-1,1)*s}}
    local cx, cy, ca = bx, pts[1][2], a
    for k=1,4 do
      ca = ca + bend*0.25
      cx = cx + math.cos(ca)*h/4; cy = cy + math.sin(ca)*h/4
      pts[#pts+1] = {cx, cy}
    end
    b:stroke(pts, {pressure={b:pressure_for(math.max(0.6, 0.9*s)), 0}, ramps={0.02, 0.5}})
    -- a seed head or a broken bent-over stem now and then
    if math.random() < 0.15 then
      b:stroke({{cx, cy}, {cx + 3*s, cy + 2*s}, {cx + 5*s, cy + 5*s}}, {pressure={0.3, 0}})
    end
  end
end
local list = {
 {40,640,1.1,14},{90,684,1.3,16},{230,702,1.4,12},{62,592,0.9,10},{270,642,1.0,9},{18,700,1.4,12},{140,620,1.0,7},
 {722,602,0.9,10},{762,632,1.0,12},{884,642,1.1,14},{944,692,1.3,16},{982,612,0.9,10},{652,694,1.3,10},{820,690,1.3,8},
 {300,542,0.55,8},{560,522,0.5,7},{782,522,0.5,8},{932,532,0.55,9},{122,547,0.55,9},{200,560,0.6,6},{640,540,0.5,6},
 {372,512,0.45,7},{444,514,0.45,6},{828,508,0.45,7},{878,506,0.45,6},{545,489,0.35,6},{742,487,0.35,6},{470,500,0.4,5}}
for i,t in ipairs(list) do tuft(t[1], t[2], t[3], t[4], 500+i, 0.2) end
