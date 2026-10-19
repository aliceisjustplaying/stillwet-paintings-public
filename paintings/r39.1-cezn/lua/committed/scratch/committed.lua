-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box cezanne
--@ engine 5

--@ chunk 1
canvas{aspect=1.25, ground={{apply="knife", pile={{"lead white", 10}, {"yellow ochre", 0.25}}, texture=0.3, um=120}}, linen={18, 16}, seed=1906, size=730}

--@ chunk 2
trLit = pile{{"red earth",1},{"yellow ochre",1.2},{"lead white",1.2},{"vermilion",0.15}, name="trLit"}
trMid = pile{{"red earth",1},{"yellow ochre",0.5},{"ultramarine blue",0.3},{"lead white",0.6}, name="trMid"}
gMid = pile{{"viridian",1},{"emerald green",1},{"yellow ochre",1},{"lead white",0.8}, name="gMid"}
pOlive = pile{{"yellow ochre",1},{"viridian",0.5},{"emerald green",0.3},{"lead white",1.5},{"red earth",0.1}, name="pOlive"}
skyE = pile{{"lead white",6},{"cobalt blue",1.2},{"viridian",0.3},{"yellow ochre",0.1}, name="skyE"}
skyK = pile{{"lead white",4},{"cobalt blue",1.1},{"ultramarine blue",0.15},{"emerald green",0.1}, name="skyK"}
shG2 = pile{{"viridian",1},{"ultramarine blue",0.6},{"yellow ochre",0.5},{"lead white",0.4},{"rose madder",0.1}, name="shG2"}
gDeepW = pile{{"viridian",1.5},{"ultramarine blue",0.7},{"yellow ochre",0.8},{"red earth",0.2},{"lead white",0.3}, name="gDeepW"}
-- underlayer: an orange trunk band like the painting's
local band = rect(100,100,800,120)
work(band, {hand="hatch", tool={kind="flat", width=5}, length={12,24}, angle=0, angle_jitter=0.15, clip=true, coverage=2.3, piles={{trLit,1},{trMid,0.6}}})
print(wait(30*24*60))
print(drying(300,150))

--@ chunk 3
-- cover trials, crossing the orange band vertically (each block 120 wide, from y 80 to 240)
local T = {
 {x=110, piles={{pOlive,1},{gMid,0.6}}, cov=1.4},
 {x=260, piles={{skyE,1},{skyK,0.6}}, cov=1.4},
 {x=410, piles={{shG2,1},{gDeepW,0.6}}, cov=1.4},
 {x=560, piles={{pOlive,1},{gMid,0.6}}, cov=2.0},
 {x=710, piles={{skyE,1},{skyK,0.6}}, cov=2.0},
}
for _,t in ipairs(T) do
  local m = rect(t.x, 80, 110, 160)
  work(m, {hand="hatch", tool={kind="flat", width=7}, length={14,26}, angle=-1.2, angle_jitter=0.15, piles=t.piles, coverage=t.cov, clump=0.3, edge="soft", load=0.8})
end

--@ chunk 4
local band = rect(100,300,800,120)
work(band, {hand="hatch", tool={kind="flat", width=5}, length={12,24}, angle=0, angle_jitter=0.15, clip=true, coverage=2.3, piles={{trLit,1},{trMid,0.6}}})
print(wait(30*24*60))
work(rect(110,280,110,160), {hand="hatch", tool={kind="flat", width=7}, length={14,26}, angle=-1.2, angle_jitter=0.15, piles={{pOlive,1},{gMid,0.6}}, coverage=1.4, clump=0.3, edge="soft", load=0.8, fill=true})
work(rect(260,280,110,160), {hand="hatch", tool={kind="flat", width=7}, length={14,26}, angle=-1.2, angle_jitter=0.15, piles={{pOlive,1},{gMid,0.6}}, coverage=1.3, clump=0.3, edge="soft", load=0.8})
work(rect(260,280,110,160), {hand="hatch", tool={kind="flat", width=7}, length={14,26}, angle=-0.5, angle_jitter=0.15, piles={{pOlive,1},{gMid,0.4}}, coverage=0.9, clump=0.3, edge="soft", load=0.8})

--@ chunk 5
trDk = pile{{"ultramarine blue",1},{"red earth",0.8},{"rose madder",0.4},{"bone black",0.1},{"lead white",0.2}, name="trDk"}
trGreen = pile{{"viridian",0.6},{"yellow ochre",0.8},{"red earth",0.3},{"lead white",0.6}, name="trGreen"}
orangeE = pile{{"yellow ochre",1.5},{"vermilion",0.5},{"red earth",0.3},{"lead white",0.8}, name="orangeE"}
hViol = pile{{"lead white",3},{"cobalt blue",0.8},{"rose madder",0.4},{"ultramarine blue",0.2}, name="hViol"}
earthW = pile{{"yellow ochre",1.5},{"red earth",0.7},{"vermilion",0.15},{"lead white",1}, name="earthW"}
-- underlayer green
work(rect(100,480,500,300), {hand="hatch", tool={kind="flat", width=10}, length={20,36}, angle=-1.0, piles={{gMid,1},{shG2,0.7},{pOlive,0.5}}, coverage=1.4, fill=true})
print(wait(20*24*60))
-- two trial trunks: vertical bands x 200-226 and 400-426, slight lean
T1 = {{190,780,28},{200,630,25},{210,500,22}}
local function tm(x0, lean) return poly({{x0-14,780},{x0+14,780},{x0+11+lean,480},{x0-11+lean,480}}) end
local function cx(x0,lean,y) local t=(780-y)/300; return x0+lean*t, lerp(28,22,t) end
for i,spec in ipairs({{200,20},{420,20}}) do
  local x0, lean = spec[1], spec[2]
  local m = tm(x0, lean)
  local function u(x,y) local c,w = cx(x0,lean,y); return (x-c)/w end
  work(m, {hand="hatch", tool={kind="flat", width=5}, length={12,24}, angle=-1.5, angle_jitter=0.12, clip=true, coverage=2.2, fill=true,
    piles={{trLit,function(x,y) return clamp(0.7-u(x,y)*2.2,0,1) end},
           {trMid,function(x,y) return clamp(0.6-math.abs(u(x,y))*1.4,0,1) end},
           {trDk,function(x,y) return clamp(0.05+u(x,y)*2.4,0,1) end}}})
  if i == 2 then
    local c = worley{seed=901, period=10}
    local function cid(x,y) local _,_,_,id = c:at(x*1.4,y*0.7); return id end
    local g = mask(function(x,y) return ((cid(x,y)*3.1)%1) < 0.55 and 1 or 0 end)
    work(m:shrink(1)*g, {hand="hatch", tool={kind="flat", width=4}, length={6,11}, angle=function(x,y) return -0.25 + 0.5*(((cid(x,y)*2.7)%1)-0.5) end, angle_jitter=0.1, clip=m, coverage=1.0, load=0.7,
      piles={{orangeE,function(x,y) return clamp(0.5-u(x,y)*2,0,1)*(((cid(x,y)*5.3)%1)<0.5 and 1 or 0.1) end},
             {earthW,function(x,y) return clamp(0.6-math.abs(u(x,y))*1.5,0,1)*(((cid(x,y)*5.3)%1)>=0.5 and 1 or 0.1) end},
             {hViol,function(x,y) return clamp(u(x,y)*2.5,0,1)*(((cid(x,y)*5.3)%1)<0.6 and 1 or 0.1) end},
             {trGreen,function(x,y) return clamp(u(x,y)*2,0,1)*(((cid(x,y)*5.3)%1)>=0.6 and 1 or 0.1)*clamp((y-600)/150,0,1) end}}})
  end
end

--@ chunk 6
trShd = pile{{"ultramarine blue",1},{"red earth",1},{"rose madder",0.4},{"lead white",0.3}, name="trShd"}
pRose = pile{{"lead white",3},{"red earth",0.4},{"yellow ochre",0.8},{"rose madder",0.15}, name="pRose"}
barkV = pile{{"lead white",1.2},{"ultramarine blue",0.7},{"rose madder",0.4},{"red earth",0.3},{"cobalt blue",0.3}, name="barkV"}
barkL = pile{{"lead white",2},{"yellow ochre",1.2},{"red earth",0.6},{"vermilion",0.1}, name="barkL"}
work(rect(560,480,300,300), {hand="hatch", tool={kind="flat", width=10}, length={20,36}, angle=-1.0, piles={{gMid,1},{shG2,0.7},{pOlive,0.5}}, coverage=1.4, fill=true})
print(wait(20*24*60))
local x0, lean = 700, 20
local function cx(y) local t=(780-y)/300; return x0+lean*t, lerp(28,22,t) end
local function u(x,y) local c,w = cx(y); return (x-c)/w end
local m = poly({{x0-14,780},{x0+14,780},{x0+11+lean,480},{x0-11+lean,480}}):roughen(1.5, 18, 5)
work(m, {hand="hatch", tool={kind="flat", width=5}, length={12,24}, angle=-1.5, angle_jitter=0.12, clip=m:grow(1), edge="firm", coverage=2.2, fill=true,
  piles={{barkL,function(x,y) return clamp(0.7-u(x,y)*2.4,0,1) end},
         {trMid,function(x,y) return clamp(0.7-math.abs(u(x,y)-0.05)*2.2,0,1) end},
         {trShd,function(x,y) return clamp(-0.1+u(x,y)*2.6,0,1) end}}})
print(wait(3*24*60))
local c = worley{seed=902, period=13}
local function cid(x,y) local _,_,_,id = c:at(x*1.6,y*0.55); return id end
local g = mask(function(x,y) return ((cid(x,y)*3.1)%1) < 0.5 and 1 or 0 end)
local function S(lo,hi) return function(x,y) local f=(cid(x,y)*5.3)%1; return (f>=lo and f<hi) and 1 or 0.05 end end
work(m:shrink(1)*g, {hand="hatch", tool={kind="flat", width=5}, length={10,18}, angle=-1.5, angle_jitter=0.12, clip=m, coverage=1.0, load=0.7,
  piles={{pRose,function(x,y) return S(0,0.3)(x,y)*clamp(0.6-u(x,y)*2,0,1) end},
         {earthW,function(x,y) return S(0.3,0.55)(x,y)*clamp(0.8-math.abs(u(x,y))*2,0,1) end},
         {trGreen,function(x,y) return S(0.55,0.75)(x,y)*clamp(0.6-math.abs(u(x,y)-0.15)*2,0,1) end},
         {barkV,function(x,y) return S(0.75,1)(x,y)*clamp(u(x,y)*2.5+0.2,0,1) end}}})

--@ chunk 7
trLit = trLit
local x0, lean = 470+330, 20
local function cx(y) local t=(780-y)/300; return x0+lean*t, lerp(28,22,t) end
local function u(x,y) local c,w = cx(y); return (x-c)/w end
local m = poly({{x0-14,780},{x0+14,780},{x0+11+lean,480},{x0-11+lean,480}}):roughen(1.5, 18, 6)
work(m, {hand="hatch", tool={kind="flat", width=5}, length={12,24}, angle=-1.5, angle_jitter=0.12, clip=m:grow(1), edge="firm", coverage=2.2, fill=true,
  piles={{barkL,function(x,y) return clamp(1-(u(x,y)+0.35)/0.25,0,1) end},
         {trLit,function(x,y) return clamp(1-math.abs(u(x,y)+0.15)/0.25,0,1) end},
         {trMid,function(x,y) return clamp(1-math.abs(u(x,y)-0.1)/0.22,0,1) end},
         {trShd,function(x,y) return clamp((u(x,y)-0.05)/0.2,0,1) end}}})
print(wait(3*24*60))
local c = worley{seed=903, period=13}
local function cid(x,y) local _,_,_,id = c:at(x*1.6,y*0.55); return id end
local g = mask(function(x,y) return ((cid(x,y)*3.1)%1) < 0.5 and 1 or 0 end)
local function S(lo,hi) return function(x,y) local f=(cid(x,y)*5.3)%1; return (f>=lo and f<hi) and 1 or 0.05 end end
work(m:shrink(1)*g, {hand="hatch", tool={kind="flat", width=5}, length={10,18}, angle=-1.5, angle_jitter=0.12, clip=m, coverage=1.0, load=0.7,
  piles={{pRose,function(x,y) return S(0,0.3)(x,y)*clamp(0.5-u(x,y)*2,0,1) end},
         {earthW,function(x,y) return S(0.3,0.55)(x,y)*clamp(0.8-math.abs(u(x,y)+0.05)*2.5,0,1) end},
         {trGreen,function(x,y) return S(0.55,0.75)(x,y)*clamp(0.6-math.abs(u(x,y)-0.1)*2,0,1) end},
         {barkV,function(x,y) return S(0.75,1)(x,y)*clamp(u(x,y)*2.5,0,1) end}}})

--@ chunk 8
print(wait(20*24*60))
local x0, lean = 800, 20
local function cx(y) local t=(780-y)/300; return x0+lean*t, lerp(28,22,t) end
local function u(x,y) local c,w = cx(y); return (x-c)/w end
local m = poly({{x0-14,780},{x0+14,780},{x0+11+lean,480},{x0-11+lean,480}}):roughen(1.5, 18, 6) * rect(0,480,1000,150)
work(m:shrink(1), {hand="hatch", tool={kind="flat", width=5}, length={10,20}, angle=-1.5, angle_jitter=0.12, clip=m, coverage=1.3, load=0.75,
  piles={{earthW,function(x,y) return clamp(1-(u(x,y)+0.3)/0.3,0,1) end},
         {trMid,function(x,y) return clamp(1-math.abs(u(x,y)-0.05)/0.25,0,1) end},
         {trDk,function(x,y) return clamp((u(x,y)-0.1)/0.2,0,1) end}}})
