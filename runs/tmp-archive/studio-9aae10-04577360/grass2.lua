strawM = pile{{"yellow ochre",0.8},{"lead white",1.0},{"raw umber",0.6},{"smalt",0.25}, medium=0.1}
strawD2 = pile{{"raw umber",1.5},{"bone black",0.35},{"yellow ochre",0.3},{"smalt",0.2}, medium=0.1}
strawL = pile{{"lead white",2},{"yellow ochre",0.5},{"raw umber",0.3}, medium=0.1}
function tuft2(x, y, s, n, seed, lean, spread)
  math.randomseed(seed)
  local b = brush{kind="rigger", width=math.max(1.2, 1.5*s), point=1}
  for i=1,n do
    local r = math.random()
    local p = (r < 0.45) and strawM or ((r < 0.8) and strawD2 or strawL)
    b:reload(p, 0.6)
    local bx = x + randn(0, (spread or 4)*s)
    local by = y + randn(0, 1.2*s)
    local h = rand(7, 26) * s
    local a = -math.pi/2 + randn(lean or 0.15, 0.3)
    local bend = randn(0.3, 0.25)
    if math.random() < 0.12 then bend = bend + 1.2 end   -- a stem bent over
    local pts = {{bx, by}}
    local cx, cy, ca = bx, by, a
    for k=1,5 do ca = ca + bend*0.2; cx = cx + math.cos(ca)*h/5; cy = cy + math.sin(ca)*h/5; pts[#pts+1] = {cx, cy} end
    b:stroke(pts, {pressure={b:pressure_for(math.max(0.6, 0.8*s)), 0}, ramps={0.02, 0.55}})
    if math.random() < 0.18 then
      -- a seed head
      local hb = brush{kind="round", width=math.max(1.2, 1.8*s), point=0.8}
      hb:load(strawD2, 0.7)
      hb:stroke({{cx, cy}, {cx + math.cos(ca)*2.5*s, cy + math.sin(ca)*2.5*s}}, {pressure={0.6, 0.2}})
    end
  end
end
-- restate the old tufts muted, and many more
local old = {
 {40,640,1.1,14},{90,684,1.3,16},{230,702,1.4,12},{62,592,0.9,10},{270,642,1.0,9},{18,700,1.4,12},{140,620,1.0,7},
 {722,602,0.9,10},{762,632,1.0,12},{884,642,1.1,14},{944,692,1.3,16},{982,612,0.9,10},{652,694,1.3,10},{820,690,1.3,8},
 {300,542,0.55,8},{560,522,0.5,7},{782,522,0.5,8},{932,532,0.55,9},{122,547,0.55,9},{200,560,0.6,6},{640,540,0.5,6},
 {372,512,0.45,7},{444,514,0.45,6},{828,508,0.45,7},{878,506,0.45,6},{545,489,0.35,6},{742,487,0.35,6},{470,500,0.4,5}}
for i,t in ipairs(old) do tuft2(t[1], t[2], t[3], t[4] + 10, 900+i, 0.2) end
local new = {
 {38,664,1.4,40,6},{104,664,1.4,35,5},{70,670,1.5,30,8},{772,688,1.4,30,6},{860,692,1.5,25,7},{955,692,1.5,30,6},{905,690,1.4,20,5},
 {130,706,1.6,25,6},{300,706,1.6,18,5},{380,690,1.5,12,4},{560,700,1.6,14,5},{700,706,1.6,16,5},{990,650,1.2,18,5},
 {180,640,1.1,12,4},{330,620,1.0,10,4},{600,640,1.0,10,4},{680,610,0.9,10,4},{960,600,0.9,12,4},{520,660,1.1,10,4},
 {250,575,0.7,10,3},{420,590,0.8,8,3},{700,570,0.7,9,3},{860,575,0.7,10,3},{60,560,0.6,10,3},{980,560,0.6,9,3},
 {330,528,0.45,8,3},{600,515,0.4,6,3},{700,512,0.4,6,3},{900,522,0.45,8,3},{160,530,0.45,8,3},{250,520,0.4,6,3}}
for i,t in ipairs(new) do tuft2(t[1], t[2], t[3], t[4], 1000+i, 0.22, t[5]) end
