-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.5, ground={{apply="knife", pile={{"lead white", 8}, {"yellow ochre", 0.3}}, texture=0.25, um=110}, {apply="brush", pile={{"lead white", 3}, {"red earth", 1.2}, {"raw umber", 1.0}, {"yellow ochre", 0.6}}, um=22}}, linen={16, 14}, seed=4417, size=900}

--@ chunk 2
s2 = pile{{"Prussian blue",0.6},{"ultramarine blue",0.4},{"bone black",0.35},{"lead white",1.2},{"raw umber",0.15}}
s3 = pile{{"Prussian blue",0.45},{"viridian",0.2},{"yellow ochre",0.35},{"lead white",2},{"bone black",0.2}}
coat_dk = pile{{"raw umber",1},{"bone black",1},{"red earth",0.15},{"ultramarine blue",0.15},{"lead white",0.08}}
coat_m = pile{{"raw umber",1},{"bone black",0.45},{"red earth",0.2},{"yellow ochre",0.15},{"lead white",0.1}}
coat_dk2 = pile{{"bone black",1},{"raw umber",0.6},{"ultramarine blue",0.3}}
coat_warm = pile{{"raw umber",0.75},{"yellow ochre",0.4},{"red earth",0.25},{"orange vermilion",0.05},{"bone black",0.2},{"lead white",0.2}}
work(everywhere(), {hand="broad", coverage=2.2, fill=true, clip=true,
  piles={{s2, function(x,y) return smoothstep(500,0,y) end},{s3, function(x,y) return smoothstep(100,600,y) end}}})
wait(10*24*60)
-- coat replica (two copies: left at painting coords, right shifted +450)
COATPTS = {{180,268},{198,268},{252,300},{256,330},{260,370},{264,410},{270,450},{278,490},{288,510},{294,530},{298,552},{240,556},{180,558},{120,556},{62,552},{80,510},{104,470},{128,430},{150,390},{168,350},{174,310}}
function shifted(pts, dx) local o = {} for i,p in ipairs(pts) do o[i] = {p[1]+dx, p[2]} end return o end
CA = poly(COATPTS, true)
CB = poly(shifted(COATPTS, 450), true)
for _,m in ipairs({CA, CB}) do
  work(m, {hand="body", coverage=2.5, fill=true, clip=true, angle=1.7, piles={{coat_dk, 1},{coat_m, 0.8}}})
end
wait(20*24*60)
print(drying(200,450))

--@ chunk 3
-- fold lines (drawn), each {pts, w0 (top half-width), w1 (bottom), strength}
FOLDS = {
  {{{205,320},{196,400},{182,470},{165,550}}, 3, 9, 1.0},
  {{{230,350},{230,430},{224,490},{214,552}}, 3, 10, 1.0},
  {{{250,400},{256,470},{262,552}}, 2, 7, 0.8},
  {{{178,400},{150,460},{122,500},{98,548}}, 3, 9, 0.7},
}
-- distance and along-param to a polyline
local function segd(px,py, ax,ay,bx,by)
  local vx,vy = bx-ax, by-ay local L2 = vx*vx+vy*vy
  local t = clamp(((px-ax)*vx+(py-ay)*vy)/L2, 0, 1)
  local qx,qy = ax+t*vx, ay+t*vy
  local cross = vx*(py-ay) - vy*(px-ax)
  return math.sqrt((px-qx)^2+(py-qy)^2), t, cross
end
function foldw(x, y, dx)
  local light, dark = 0, 0
  for _,f in ipairs(FOLDS) do
    local pts, w0, w1, st = f[1], f[2], f[3], f[4]
    local best, bt, bs, acc, total = 1e9, 0, 1, 0, 0
    local lens = {}
    for i=1,#pts-1 do local l = math.sqrt((pts[i+1][1]-pts[i][1])^2+(pts[i+1][2]-pts[i][2])^2) lens[i]=l total=total+l end
    for i=1,#pts-1 do
      local d,t,c = segd(x-dx,y, pts[i][1],pts[i][2],pts[i+1][1],pts[i+1][2])
      if d < best then best = d bt = (acc + t*lens[i])/total bs = (c < 0) and 1 or -1 end
      acc = acc + lens[i]
    end
    -- along the fold: fades in from top, strongest at bottom
    local w = lerp(w0, w1, bt)
    local fade = smoothstep(0, 0.35, bt) * st
    -- signed lateral: bs>0 means point is on the right side of the fold line (moving downward, right = -x... compute directly)
    local sd = best * bs
    light = light + fade * math.exp(-((sd - 0.6*w)/w)^2)
    dark = dark + fade * math.exp(-((sd + 1.1*w)/(1.1*w))^2)
  end
  return light, dark
end
-- check sign: point right of fold 2 (x=240,y=450)
print(foldw(240,450,0))
print(foldw(214,450,0))

--@ chunk 4
coat_rim = pile{{"raw umber",0.5},{"lead white",0.5},{"Prussian blue",0.1},{"bone black",0.15},{"yellow ochre",0.12}}
local function along(x,y,dx) return 1.72 + (x-dx-200)*0.0015 end
-- A: moderate contrast, mid-dark coat_m ridges
local clipA = CA:shrink(4):blur(2)
work(clipA, {hand="body", tool="filbert 6", coverage=2.5, fill=true, clip=clipA, length={12,35},
  angle=function(x,y) return along(x,y,0) end,
  piles={{coat_dk, 1},
         {coat_m, function(x,y) local l,d = foldw(x,y,0) return l*1.8 end},
         {coat_dk2, function(x,y) local l,d = foldw(x,y,0) return d*1.6 end}}})
-- B: stronger, warm ridge near front + cool ridge accents
local clipB = CB:shrink(4):blur(2)
work(clipB, {hand="body", tool="filbert 6", coverage=2.5, fill=true, clip=clipB, length={12,35},
  angle=function(x,y) return along(x,y,450) end,
  piles={{coat_dk, 0.8},
         {coat_m, function(x,y) local l,d = foldw(x,y,450) return l*2.2 end},
         {coat_warm, function(x,y) local l,d = foldw(x,y,450) return l*smoothstep(200,260,x-450)*1.5 end},
         {coat_dk2, function(x,y) local l,d = foldw(x,y,450) return d*2.2 end}}})
wait(20*24*60)

--@ chunk 5
cglaze = pile{{"bone black",0.6},{"raw umber",0.8},{"ultramarine blue",0.3}, medium=0.78}
local function along(x,y,dx) return 1.72 + (x-dx-200)*0.0015 end
local clipB = CB:shrink(4):blur(2)
work(clipB, {hand="body", tool="filbert 6", coverage=2.5, fill=true, clip=clipB, length={12,35},
  angle=function(x,y) return along(x,y,450) end,
  piles={{coat_dk2, 0.6},{coat_dk, 0.6},
         {coat_m, function(x,y) local l,d = foldw(x,y,450) return l*1.6 end},
         {coat_dk2, function(x,y) local l,d = foldw(x,y,450) return d*1.5 end}}})
wait(20*24*60)
-- cglaze over the whole copy B (the painting coat had been glazed after its fold pass)
work(CB, {hand="glaze", pile=cglaze, coverage=1.5, fill=true, clip=true, angle=1.65})
wait(20*24*60)

--@ chunk 6
local function along(x,y,dx) return 1.72 + (x-dx-200)*0.0015 end
local clipB = CB:shrink(4):blur(2)
work(clipB, {hand="body", tool="filbert 6", coverage=2.5, fill=true, clip=clipB, length={12,35},
  angle=function(x,y) return along(x,y,450) end,
  piles={{coat_dk2, 0.7},{coat_dk, 0.5},
         {coat_m, function(x,y) local l,d = foldw(x,y,450) return l*2.4 end},
         {coat_dk2, function(x,y) local l,d = foldw(x,y,450) return d*1.2 end}}})
wait(20*24*60)

--@ chunk 7
-- graded glaze on copy A: heavier toward back (left) and top, light at front folds
local function xb(y) return lerp(176, 62, clamp((y-290)/260,0,1)) end
local function xf(y) return lerp(252, 298, clamp((y-300)/250,0,1)) end
work(CA, {hand="glaze", pile=cglaze, coverage=1.5, fill=true, clip=true, angle=1.65,
  load_at=function(x,y)
    local t = clamp((x - xb(y)) / math.max(20, xf(y) - xb(y)), 0, 1)  -- 0 back .. 1 front
    local top = smoothstep(420, 300, y)
    return clamp(lerp(0.95, 0.25, t) + 0.4*top, 0.15, 1)
  end})
wait(20*24*60)
