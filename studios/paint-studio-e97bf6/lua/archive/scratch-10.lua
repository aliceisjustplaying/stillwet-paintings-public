-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 8
--@ knife-skim
--@ limbs-join-nearest
--@ blend-feather
--@ brush-skim
--@ blend-at-masks
--@ glaze-film
--@ liquid-film-levels
--@ rag-lift
--@ full-palette-refuses
--@ drain

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"lead white", 2}, {"red earth", 1}, {"yellow ochre", 1}}, texture=0.35, um=90}, {apply="brush", pile={{"lead white", 8}, {"yellow ochre", 0.25}, {"raw umber", 0.08}}, texture=0.4, um=45}}, linen={15, 13}, seed=6, size=1050}

--@ chunk 2
hull = {{300,272},{360,296},{440,334},{520,378},{532,442},{470,412},{390,372},{318,330},{300,316},{293,295}}
hD = pile{{"raw umber",2},{"bone black",1},{"lead white",0.25},{"Prussian blue",0.04}}
hL = pile{{"raw umber",2},{"bone black",0.4},{"lead white",0.6},{"yellow ochre",0.3}}
local hm = poly(hull, true)
work(hm, {hand="body", piles={{hL, function(x,y) return clamp(1-(x-290)/200,0,1)*0.8+0.1 end},{hD, function(x,y) return clamp((x-290)/200,0,1)+0.3 end}}, clip=true, coverage=2, fill=true, angle=0.45, tool="filbert 4"})
wait(3*24*60)
print(drying(400,350))
plankD = pile{{"bone black",1},{"raw umber",1}, medium=0.2}
plankL = pile{{"raw umber",1},{"lead white",0.8},{"yellow ochre",0.4}, medium=0.1}
local function lerp2(a,b,t) return {a[1]+(b[1]-a[1])*t, a[2]+(b[2]-a[2])*t} end
local stem = {{300,272},{294,290},{298,310},{310,324},{318,330}}
local top = {{300,272},{360,296},{440,334},{520,378}}
local bot = {{318,330},{390,372},{470,412},{532,442}}
local function stemAt(s) local n=#stem-1; local f=s*n; local i=math.min(n, math.floor(f)+1); local t=f-(i-1); return lerp2(stem[i], stem[i+1], t) end
rb = brush{kind="round", width=1.6, point=1}
for k=1,7 do
  local s = k/8
  local pts = {stemAt(s)}
  for j=2,4 do pts[#pts+1] = lerp2(top[j], bot[j], s) end
  rb:reload(plankD, 0.6)
  rb:stroke(pts, {pressure={0.5,0.6}})
  local lp = {}
  for _,p in ipairs(pts) do lp[#lp+1] = {p[1], p[2]-2.2} end
  rb:reload(plankL, 0.4)
  rb:stroke(lp, {pressure={0.35,0.25}})
end

--@ chunk 3
local off = 230
local function sh(pts) local q={} for _,p in ipairs(pts) do q[#q+1]={p[1]+off,p[2]} end return q end
hD2 = pile{{"raw umber",2},{"bone black",1.4},{"red earth",0.15},{"Prussian blue",0.05}}
hL2 = pile{{"raw umber",2},{"bone black",0.6},{"lead white",0.35},{"red earth",0.2},{"yellow ochre",0.2}}
local hm = poly(sh(hull), true)
work(hm, {hand="body", piles={{hL2, function(x,y) return clamp(1-(x-290-off)/180,0,1)*0.9+0.05 end},{hD2, function(x,y) return clamp((x-290-off)/180,0,1)+0.25 end}}, clip=true, coverage=2, fill=true, angle=0.45, tool="filbert 4"})
wait(3*24*60)
local function lerp2(a,b,t) return {a[1]+(b[1]-a[1])*t, a[2]+(b[2]-a[2])*t} end
local stem = sh({{300,272},{293,292},{297,312},{318,330}})
local top = sh({{300,272},{360,296},{440,334},{520,378}})
local bot = sh({{318,330},{390,372},{470,412},{532,442}})
local function stemAt(s) local n=#stem-1; local f=s*n; local i=math.min(n, math.floor(f)+1); local t=f-(i-1); return lerp2(stem[i], stem[i+1], t) end
plankD2 = pile{{"bone black",1.5},{"raw umber",1}, medium=0.15}
plankL2 = pile{{"raw umber",1},{"lead white",0.6},{"yellow ochre",0.3},{"red earth",0.1}}
rb = brush{kind="round", width=1.4, point=1}
lb = brush{kind="round", width=1.2, point=1}
local ss = {0.06, 0.16, 0.24, 0.30, 0.42, 0.54, 0.66, 0.78}
for k,s in ipairs(ss) do
  local pts = {stemAt(s)}
  for j=2,4 do pts[#pts+1] = lerp2(top[j], bot[j], s) end
  rb:reload(plankD2, 0.7)
  rb:stroke(pts, {pressure={0.5,0.6}, shake=0.4})
  if s < 0.5 then
    local lp = {}
    for i=1,3 do lp[#lp+1] = {pts[i][1], pts[i][2]-1.8} end
    lb:reload(plankL2, 0.25)
    lb:stroke(lp, {pressure={0.4,0.05}, shake=0.6})
  end
end
-- wale band
local wl = {stemAt(0.24)}; local wl2 = {stemAt(0.30)}
for j=2,4 do wl[#wl+1] = lerp2(top[j], bot[j], 0.24); wl2[#wl2+1] = lerp2(top[j], bot[j], 0.30) end
local ww = {} for i=1,#wl do ww[i] = lerp2(wl[i], wl2[i], 0.5) end
wb = brush{kind="round", width=4, point=0.5}
wb:reload(plankD2, 0.8)
wb:stroke(ww, {pressure={0.7,0.8}})
-- rail
local rl = {} for i=1,4 do rl[i] = {top[i][1], top[i][2]+1} end
railp = pile{{"lead white",3},{"cobalt blue",0.2},{"raw umber",0.3}}
lb:reload(railp, 0.7)
lb:stroke(rl, {pressure={0.8,0.4}, shake=0.5})

--@ chunk 4
sf1 = pile{{"lead white",3.4},{"cobalt blue",1},{"Prussian blue",0.032}}
sf2 = pile{{"lead white",3.8},{"cobalt blue",1},{"Prussian blue",0.03},{"Naples yellow",0.08}}
work(rect(50,500,100,80), {hand="body", pile=sf1, clip=true, coverage=2, fill=true})
work(rect(200,500,100,80), {hand="body", pile=sf2, clip=true, coverage=2, fill=true})

--@ chunk 5
pl1 = pile{{"lead white",6},{"cobalt blue",0.45},{"rose madder",0.06},{"Naples yellow",0.08},{"raw umber",0.03}}
pl2 = pile{{"lead white",6},{"cobalt blue",0.35},{"Naples yellow",0.2},{"rose madder",0.04},{"raw umber",0.04}}
pl3 = pile{{"lead white",6},{"cobalt blue",0.28},{"Naples yellow",0.25},{"raw umber",0.03}}
pM = pile{{"lead white",6},{"Naples yellow",0.18},{"cobalt blue",0.03}}
work(rect(50,620,200,80), {hand="body", pile=pM, clip=true, coverage=2, fill=true})
wait(3*24*60)
work(rect(400,600,150,100), {hand="broad", pile=pl1, clip=true, coverage=1.6, fill=true, angle=0})
work(rect(560,600,150,100), {hand="broad", pile=pl2, clip=true, coverage=1.6, fill=true, angle=0})
work(rect(720,600,150,100), {hand="broad", pile=pl3, clip=true, coverage=1.6, fill=true, angle=0})
