-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"lead white", 10}, {"bone black", 0.2}}, texture=0.3, um=120}, {apply="brush", pile={{"lead white", 6}, {"red earth", 1.2}, {"raw umber", 1}, {"yellow ochre", 0.6}}, texture=0.5, um=40}}, linen={16, 14}, seed=4471, size=900}

--@ chunk 2
ld_mid2 = pile{{"raw umber", 1}, {"rose madder", 0.25}, {"ultramarine blue", 0.4}, {"lead white", 0.4}, {"burnt sienna", 0.2}, name="ld_mid2"}
ld_near2 = pile{{"raw umber", 1}, {"bone black", 0.4}, {"ultramarine blue", 0.5}, {"burnt sienna", 0.35}, {"rose madder", 0.1}, name="ld_near2"}
cw_dark = pile{{"bone black", 1}, {"raw umber", 1}, {"ultramarine blue", 0.5}, name="cw_dark"}
jeans_dk2 = pile{{"ultramarine blue", 0.5}, {"bone black", 0.5}, {"raw umber", 0.9}, {"burnt sienna", 0.2}, {"rose madder", 0.08}, name="jeans_dk2"}
-- two replicas: A at the painting's coords, B shifted left by 300
function replica(dx)
  local g = rect(700 + dx, 540, 230, 110)
  work(g, {hand="body", tool={kind="flat", width=12, stiffness=0.6},
    piles={{ld_mid2, function(x,y) return 1 - smoothstep(575, 660, y) end},
           {ld_near2, function(x,y) return smoothstep(575, 660, y) end}},
    angle=function(x,y) return 0.05*math.sin(x/60 + y/35) end, length={25, 80},
    coverage=1.7, fill=true, clip=g, mix_jitter=0.06, seed=11})
  local pit = poly({{802+dx,589},{850+dx,587.5},{892+dx,587},{899+dx,601},{850+dx,602.5},{796+dx,603}})
  local legs = poly({{769+dx,540},{782+dx,540},{776+dx,612},{773+dx,617},{767+dx,617},{765+dx,612}})
             + poly({{828+dx,540},{841+dx,540},{855+dx,600},{853+dx,605},{847+dx,605},{845+dx,600}})
  local feet = poly({{760+dx,604},{776+dx,604},{780+dx,616},{778+dx,626},{766+dx,628},{748+dx,630},{744+dx,624},{752+dx,618}}, true)
             + poly({{842+dx,594},{856+dx,594},{862+dx,606},{872+dx,614},{868+dx,622},{850+dx,622},{840+dx,612}}, true)
  work(pit - legs - feet, {hand="detail", tool={kind="round", width=2.5}, pile=cw_dark, coverage=3.5, clip=pit - legs - feet, angle=0, seed=12})
  work(legs - feet, {hand="detail", tool={kind="round", width=2.5}, pile=jeans_dk2, coverage=3.5, clip=legs - feet, angle=1.4, seed=13})
  work(feet, {hand="detail", tool={kind="round", width=2}, pile=cw_dark, coverage=3, clip=feet, angle=0, seed=14})
  local soles = ellipse(762+dx, 629, 22, 3):soften(2) + ellipse(858+dx, 623, 18, 3):soften(2)
  work(soles - feet, {hand="detail", tool={kind="round", width=2.5}, pile=cw_dark, coverage=1.5, clip=soles - feet, angle=0, edge="soft", seed=15})
end
replica(0)
replica(-300)
wait(16*24*60)
print(drying(800,620), drying(760,615), drying(500,620), drying(850,595))

--@ chunk 3
function newfeet(dx)
  local L = poly({{763+dx,603},{776+dx,603},{779+dx,612},{781+dx,623.5},{779.5+dx,629},{766+dx,629.6},{750+dx,630.4},{743.5+dx,629.2},{742.5+dx,625.5},{746+dx,620.5},{755+dx,616.5},{761+dx,611}})
  local R = poly({{843+dx,597},{838+dx,604},{831+dx,611},{825+dx,616.5},{821.5+dx,620.5},{822.5+dx,623.6},{836+dx,624.2},{845+dx,620},{854+dx,613.5},{859.5+dx,608},{858.5+dx,600},{855+dx,596}})
  return L, R
end
local dx = 0
local L, R = newfeet(dx)
local pit = poly({{802+dx,589},{850+dx,587.5},{892+dx,587},{899+dx,601},{850+dx,602.5},{796+dx,603}})
local legs = poly({{769+dx,540},{782+dx,540},{776+dx,612},{773+dx,617},{767+dx,617},{765+dx,612}})
           + poly({{828+dx,540},{841+dx,540},{855+dx,600},{853+dx,605},{847+dx,605},{845+dx,600}})
local oldfeet = poly({{760+dx,604},{776+dx,604},{780+dx,616},{778+dx,626},{766+dx,628},{748+dx,630},{744+dx,624},{752+dx,618}}, true)
             + poly({{842+dx,594},{856+dx,594},{862+dx,606},{872+dx,614},{868+dx,622},{850+dx,622},{840+dx,612}}, true)
local oldsoles = ellipse(762+dx, 629, 22, 3):soften(2) + ellipse(858+dx, 623, 18, 3):soften(2)
local excess = (oldfeet:grow(1.5) + oldsoles) - L:grow(0.3) - R:grow(0.3) - legs
local exc_pit = excess * pit
local exc_gnd = excess - pit
local pz = {{ld_mid2, function(x,y) return 1 - smoothstep(575, 660, y) end},
            {ld_near2, function(x,y) return smoothstep(575, 660, y) end}}
work(exc_gnd, {hand="detail", tool={kind="flat", width=4, stiffness=0.6}, piles=pz, angle=0, coverage=3.5, clip=exc_gnd, seed=21})
work(exc_pit, {hand="detail", tool={kind="round", width=2}, pile=cw_dark, coverage=3.5, clip=exc_pit, angle=0, seed=22})
work(L + R, {hand="detail", tool={kind="round", width=2}, pile=cw_dark, coverage=3.5, clip=L + R, angle=0, seed=23})
print(exc_gnd:area(), exc_pit:area())

--@ chunk 4
function newfeet2(dx)
  local L = poly({{763+dx,603},{776+dx,603},{779+dx,612},{781+dx,623.5},{779.5+dx,629},{766+dx,629.6},{750+dx,630.4},{743.5+dx,629.2},{742.5+dx,625.5},{746+dx,620.5},{755+dx,616.5},{761+dx,611}})
  local R = poly({{843+dx,597},{839+dx,603},{833+dx,609},{827+dx,614},{823+dx,617.5},{821+dx,620.5},{821.5+dx,623.5},{825+dx,624.6},{836+dx,624.4},{845+dx,620.5},{854+dx,614},{859.5+dx,608.5},{858.5+dx,600},{855+dx,596}})
  return L, R
end
local dx = -300
local L, R = newfeet2(dx)
local pit = poly({{802+dx,589},{850+dx,587.5},{892+dx,587},{899+dx,601},{850+dx,602.5},{796+dx,603}})
local legs = poly({{769+dx,540},{782+dx,540},{776+dx,612},{773+dx,617},{767+dx,617},{765+dx,612}})
           + poly({{828+dx,540},{841+dx,540},{855+dx,600},{853+dx,605},{847+dx,605},{845+dx,600}})
local oldfeet = poly({{760+dx,604},{776+dx,604},{780+dx,616},{778+dx,626},{766+dx,628},{748+dx,630},{744+dx,624},{752+dx,618}}, true)
             + poly({{842+dx,594},{856+dx,594},{862+dx,606},{872+dx,614},{868+dx,622},{850+dx,622},{840+dx,612}}, true)
local oldsoles = ellipse(762+dx, 629, 22, 3):soften(2) + ellipse(858+dx, 623, 18, 3):soften(2)
local excess = (oldfeet:grow(1.5) + oldsoles) - L:grow(0.3) - R:grow(0.3) - legs
local exc_pit = excess * pit
local exc_gnd = excess - pit
local pz = {{ld_mid2, function(x,y) return 1 - smoothstep(575, 660, y) end},
            {ld_near2, function(x,y) return smoothstep(575, 660, y) end}}
work(exc_gnd, {hand="detail", tool={kind="flat", width=4, stiffness=0.6}, piles=pz, angle=0, coverage=3.5, clip=exc_gnd, seed=31})
work(exc_pit, {hand="detail", tool={kind="round", width=2}, pile=cw_dark, coverage=3.5, clip=exc_pit, angle=0, seed=32})
work(L + R, {hand="detail", tool={kind="round", width=2}, pile=cw_dark, coverage=3.5, clip=L + R, angle=0, seed=33})
wait(14*24*60)
print(drying(830,620), drying(530,620), drying(760,625))

--@ chunk 5
rim_warm = pile{{"burnt sienna", 1}, {"Naples yellow", 0.9}, {"orange chrome", 0.35}, {"vermilion", 0.12}, {"lead white", 0.2}, name="rim_warm"}
zb_flash = pile{{"orange chrome", 1}, {"Naples yellow", 0.6}, {"burnt sienna", 0.3}, {"lead white", 0.2}, name="zb_flash"}
contact_dk = pile{{"raw umber", 1}, {"bone black", 0.5}, {"ultramarine blue", 0.4}, name="contact_dk"}
zshoe_sheen = mix{{cw_dark, 0.6}, {zb_flash, 0.4}, name="zshoe_sheen"}
local dx = -300
local L, R = newfeet2(dx)
local sb = brush{kind="round", width=1.6, point=0.85, stiffness=0.55}
-- toe-cap sheen along the top of each toe, facing the flash (upper left)
sb:reload(zshoe_sheen, 0.6) sb:gesture({{758+dx,617,0.1},{752+dx,618.6,0.45},{747+dx,621,0.5},{744.5+dx,624.5,0.15}}, {wobble=0.03, clip=L})
sb:reload(zshoe_sheen, 0.6) sb:gesture({{836+dx,607,0.1},{830+dx,611.5,0.45},{825+dx,615.5,0.5},{822.5+dx,619.5,0.15}}, {wobble=0.03, clip=R})
-- contact darks under what touches the ground
local cd = (ellipse(761+dx, 630.8, 19, 2.0):soften(1.5) + ellipse(830+dx, 625.2, 9, 1.6):soften(1.5)) - L - R
work(cd, {hand="detail", tool={kind="round", width=2}, pile=contact_dk, coverage=2, clip=cd, angle=0, seed=41})
