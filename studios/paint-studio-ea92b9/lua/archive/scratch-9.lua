-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 6}, {"yellow ochre", 0.35}, {"raw umber", 0.12}}, um=35}}, linen={16, 14}, seed=1774, size=650}

--@ chunk 2
s_glow = pile{{"lead white",5},{"Naples yellow",1.5},{"yellow ochre",0.25},{"vermilion",0.05}, name="s_glow"}
f_land = pile{{"lead white",1.2},{"smalt",1.1},{"raw umber",0.75},{"rose madder",0.1},{"Naples yellow",0.2},{"cobalt blue",0.2}, name="f_land"}
far_top = {{0,462},{40,461},{70,457},{85,455},{100,457},{130,460},{180,461},{230,459},{250,455},{262,454},{275,457},{300,460},{360,461},{420,462},{470,460},{500,456},{515,455},{530,458},{560,460},{600,460},{625,457},{640,455},{690,455},{705,457},{740,458},{780,456},{820,452},{860,450},{900,451},{940,454},{970,457},{1000,458}}
work(above(far_top):grow(2), {hand="broad", pile=s_glow, angle=0, ruler=true, coverage=2.2, fill=true, clip=above(far_top):grow(2), seed=1})
local fb = below(far_top) * above(function(x) return 478 end)
work(fb, {hand="body", pile=f_land, angle=0, coverage=2.4, fill=true, clip=fb, seed=2})
local m_far  = pile{{"lead white",1.2},{"smalt",1.2},{"raw umber",0.8},{"rose madder",0.1},{"Naples yellow",0.2}}
local m_mid  = pile{{"raw umber",1.2},{"green earth",0.8},{"yellow ochre",0.25},{"smalt",0.3},{"lead white",0.35}}
local mm = below(function(x) return 476 end)
work(mm, {hand="body", piles={{m_far, function(x,y) return clamp(1-(y-474)/40,0,1) end},{m_mid, function(x,y) return clamp((y-474)/40,0.05,1) end}}, angle=0, coverage=2.4, fill=true, clip=mm, seed=3})
print(wait(5*24*60))

--@ chunk 3
function lens(x0, x1, y, th, seed, skew)
  skew = skew or 0
  local nz = noise{seed=seed, period=14, octaves=2}
  local top, bot = {}, {}
  local n = math.max(8, math.floor((x1-x0)/4))
  for i=0,n do
    local t = i/n
    local x = lerp(x0, x1, t)
    local env = math.sin(math.pi*t)^0.4
    local yy = y + skew*(t-0.5)
    top[#top+1] = {x, yy - th*0.4*env*(0.75+0.5*nz:at01(x, y))}
    bot[#bot+1] = {x, yy + th*0.6*env*(0.5+1.0*nz:at01(x+50, y))}
  end
  local pts = {}
  for i=1,#top do pts[#pts+1] = top[i] end
  for i=#bot,1,-1 do pts[#pts+1] = bot[i] end
  return poly(pts, true)
end
wv_far  = pile{{"lead white",5},{"Naples yellow",1.3},{"yellow ochre",0.3},{"raw umber",0.25},{"vermilion",0.04}, name="wv_far"}
wv_dim  = pile{{"lead white",3},{"Naples yellow",0.8},{"smalt",0.4},{"raw umber",0.45},{"rose madder",0.05}, name="wv_dim"}
local bay = lens(560, 1010, 481, 8, 7, 1) + lens(700, 860, 486.5, 4, 8)
work(bay, {hand="detail", tool={kind="flat", width=3}, piles={{wv_far, function(x,y) return clamp((y-477)/5,0.1,1) end},{wv_dim, function(x,y) return clamp(1-(y-477)/5,0,1) end}}, coverage=3, fill=true, angle=0, seed=41})

--@ chunk 4
-- scratch canvas 8 has sky glow & land; paint a quick tree patch, dry it, then test glaze over it
t_dark = pile{{"raw umber",1.3},{"bone black",0.8},{"Prussian blue",0.1},{"red earth",0.1}, name="t_dark"}
t_warm = pile{{"raw umber",1.6},{"bone black",0.5},{"red earth",0.2},{"yellow ochre",0.1}, name="t_warm"}
local tr = ribbon({{100,470},{105,400},{98,330},{110,260}}, {40,34,30,26}) + ribbon({{250,470},{255,400},{248,330},{260,260}}, {40,34,30,26})
work(tr, {hand="detail", piles={{t_dark,0.6},{t_warm,0.4}}, coverage=2.6, fill=true, angle=-math.pi/2, seed=1})
wait(5*24*60)
g_tree = pile{{"bone black",1},{"raw umber",0.7},{"Prussian blue",0.12}, medium=0.7, name="g_tree"}
local m2 = ribbon({{250,470},{255,400},{248,330},{260,260}}, {40,34,30,26})
work(m2, {hand="detail", tool={kind="filbert", width=6}, pile=g_tree, coverage=2, fill=true, angle=-math.pi/2, seed=2})
