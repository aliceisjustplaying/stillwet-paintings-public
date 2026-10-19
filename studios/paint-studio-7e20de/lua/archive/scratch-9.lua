-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.5, ground={{apply="knife", pile={{"lead white", 8}, {"yellow ochre", 0.3}}, texture=0.25, um=110}, {apply="brush", pile={{"lead white", 3}, {"red earth", 1.2}, {"raw umber", 1.0}, {"yellow ochre", 0.6}}, um=22}}, linen={16, 14}, seed=4417, size=900}

--@ chunk 2
s1 = pile{{"Prussian blue",0.6},{"ultramarine blue",0.7},{"bone black",0.8},{"lead white",0.45}}
s2 = pile{{"Prussian blue",0.6},{"ultramarine blue",0.4},{"bone black",0.35},{"lead white",1.2},{"raw umber",0.15}}
smoke_cool = pile{{"lead white",2},{"bone black",0.25},{"Prussian blue",0.15},{"yellow ochre",0.2}}
smoke_sh = pile{{"lead white",0.9},{"bone black",0.3},{"Prussian blue",0.15},{"ultramarine blue",0.15},{"raw umber",0.15}}
smoke_warm = pile{{"lead white",2.5},{"yellow ochre",0.8},{"orange vermilion",0.15},{"bone black",0.05}}
smoke_hot = pile{{"lead white",3},{"Naples yellow",1},{"cadmium yellow",0.6}}
work(everywhere(), {hand="broad", coverage=2.2, fill=true, clip=true,
  piles={{s1, function(x,y) return smoothstep(400,0,y) end},{s2, function(x,y) return smoothstep(0,400,y) end}}})
wait(20*24*60)
LOB = {{470,222,14},{478,240,20},{500,258,18},{505,230,26},{520,192,18},{535,215,30},{540,250,24},{570,200,28},{575,238,22},{600,190,22},{605,222,16}}
function cloudat(dx, dy)
  local m = nil
  for _,l in ipairs(LOB) do local e = ellipse(l[1]+dx, l[2]+dy, l[3], l[3]*0.9) m = m and (m + e) or e end
  m = m:roughen(4, 20, 5)
  local mx, my = 455+dx, 243+dy
  local function nearest(x,y) local best, bl = 1e9, LOB[1] for _,l in ipairs(LOB) do local d = math.sqrt((x-l[1]-dx)^2+(y-l[2]-dy)^2)/l[3] if d < best then best, bl = d, l end end return bl end
  local function ny(x,y) local l = nearest(x,y) return (y - l[2]-dy)/l[3], (x-l[1]-dx)/l[3] end
  work(m, {hand="body", tool="filbert 7", coverage=2.4, fill=true, clip=true, length={8,22},
    piles={{smoke_hot, function(x,y) return smoothstep(60,10,math.sqrt((x-mx)^2+(y-my)^2)) * 2 end},
           {smoke_warm, function(x,y) return smoothstep(120,40,math.sqrt((x-mx)^2+(y-my)^2)) end},
           {smoke_cool, function(x,y) local a,b = ny(x,y) return clamp(-a*0.8 + b*0.5 + 0.4, 0, 1.2) end},
           {smoke_sh, function(x,y) local a,b = ny(x,y) return clamp(a*0.9 + 0.1, 0, 1) end}}})
  return m
end
CA = cloudat(-300, 0)
CB = cloudat(100, 0)
CCm = cloudat(-300, 250)
CD = cloudat(100, 250)
wait(20*24*60)
print(drying(200,220))

--@ chunk 3
csh_t = pile{{"Prussian blue",0.3},{"ultramarine blue",0.25},{"bone black",0.3},{"lead white",0.7},{"raw umber",0.1}, thinner=0.6}
local function shade(m, mx, my)
  local far = m:times(function(x,y) local d = math.sqrt((x-mx)^2+(y-my)^2) return smoothstep(40, 140, d) end)
  work(far, {hand="scumble", pile=csh_t, coverage=1.3, fill=true, clip=m:shrink(1),
    load_at=function(x,y) return lerp(0.3, 0.9, smoothstep(40,150,math.sqrt((x-mx)^2+(y-my)^2))) end})
end
shade(CA, 155, 243)
lose(CB, {pile=s2, where=1, reach={4,10}, load=0.25})
shade(CCm, 155, 493)
lose(CCm, {pile=s2, where=1, reach={4,10}, load=0.25})
local band = CD:rim(6, 3)
work(band, {hand="scumble", pile=pile{{"Prussian blue",0.6},{"ultramarine blue",0.4},{"bone black",0.35},{"lead white",1.2},{"raw umber",0.15}, thinner=0.6}, coverage=1.2, fill=true, clip=band})
wait(20*24*60)

--@ chunk 4
CE = cloudat(350, 0)
CF = cloudat(350, 250)
local d = CE:distance()
print(d:at(805,222), d:at(830,222), d:at(860,215), d:at(780,222), d:at(700,222))
wait(20*24*60)

--@ chunk 5
smoke_mid = pile{{"lead white",1.2},{"bone black",0.3},{"Prussian blue",0.18},{"ultramarine blue",0.15},{"raw umber",0.1},{"yellow ochre",0.1}}
sky_edge = mix{{s2, 0.7}, {smoke_mid, 0.3}}
local function nearest(x,y,dx,dy) local best, bl = 1e9, LOB[1] for _,l in ipairs(LOB) do local d = math.sqrt((x-l[1]-dx)^2+(y-l[2]-dy)^2)/l[3] if d < best then best, bl = d, l end end return bl end
function recloud(M, dx, dy)
  local mx, my = 455+dx, 243+dy
  local D = M:distance()
  local function dm(x,y) return math.sqrt((x-mx)^2+(y-my)^2) end
  local R = M:times(function(x,y) return smoothstep(45, 70, dm(x,y)) end)
  work(R, {hand="body", tool="filbert 6", coverage=2.4, fill=true, clip=R, length={8,20},
    angle=function(x,y) local l = nearest(x,y,dx,dy) return math.atan(y-l[2]-dy, x-l[1]-dx) + 1.57 end,
    piles={{smoke_warm, function(x,y) return smoothstep(115,55,dm(x,y)) * 1.2 end},
           {smoke_cool, function(x,y) local l = nearest(x,y,dx,dy) local a,b = (y-l[2]-dy)/l[3], (x-l[1]-dx)/l[3] return clamp(-a*0.7 + b*0.3, 0, 1) * 0.6 end},
           {smoke_mid, function(x,y) return 0.7 end},
           {smoke_sh, function(x,y) local l = nearest(x,y,dx,dy) local a = (y-l[2]-dy)/l[3] return clamp(a*0.9, 0, 1) end},
           {sky_edge, function(x,y) return smoothstep(9, 1, D:at(x,y)) * 2.0 * smoothstep(60,110,dm(x,y)) end}}})
end
recloud(CE, 350, 0)
wait(20*24*60)

--@ chunk 6
local function nearest(x,y,dx,dy) local best, bl = 1e9, LOB[1] for _,l in ipairs(LOB) do local d = math.sqrt((x-l[1]-dx)^2+(y-l[2]-dy)^2)/l[3] if d < best then best, bl = d, l end end return bl end
function recloud2(M, dx, dy, extra)
  local mx, my = 455+dx, 243+dy
  local D = M:distance()
  local function dm(x,y) return math.sqrt((x-mx)^2+(y-my)^2) end
  local R = M:times(function(x,y) return smoothstep(45, 70, dm(x,y)) end)
  local opts = {hand="body", tool="filbert 6", coverage=2.4, fill=true, length={8,22},
    angle=-0.45, angle_jitter=0.6, edge="loose", clip=(M:grow(12)):times(function(x,y) return smoothstep(45,70,dm(x,y)) end),
    piles={{smoke_warm, function(x,y) return smoothstep(115,55,dm(x,y)) * 1.2 end},
           {smoke_cool, function(x,y) local l = nearest(x,y,dx,dy) local a,b = (y-l[2]-dy)/l[3], (x-l[1]-dx)/l[3] return clamp(-a*0.7 + b*0.3, 0, 1) * 0.6 end},
           {smoke_mid, function(x,y) return 0.7 end},
           {smoke_sh, function(x,y) local l = nearest(x,y,dx,dy) local a = (y-l[2]-dy)/l[3] return clamp(a*0.9, 0, 1) end},
           {sky_edge, function(x,y) return smoothstep(9, 1, D:at(x,y)) * 2.0 * smoothstep(60,110,dm(x,y)) end}}}
  work(R, opts)
end
recloud2(CF, 350, 250)
wait(20*24*60)
