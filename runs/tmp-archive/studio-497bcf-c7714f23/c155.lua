storkW = pile{{"lead white", 6}, {"yellow ochre", 0.15}, {"pale smalt", 0.2}, medium=0.08}
storkRed = pile{{"vermilion", 1.5}, {"red earth", 0.5}, medium=0.08}
local x, y = 122, 551
local body = poly({{x-5.5,y-8.2},{x-3,y-10},{x+1.5,y-10.4},{x+3.2,y-9.6},{x+2.4,y-7.6},{x-1,y-6.8},{x-4.5,y-7}}, true)
local neck = ribbon({{x+2.4,y-9.8},{x+3.4,y-12.5},{x+3.2,y-14.6}}, {1.8, 1.2, 1.3})
local head = ellipse(x+3.4, y-15, 1.2, 1.0)
local wing = poly({{x-5.8,y-8.1},{x-3,y-9.3},{x+0.8,y-8.8},{x+0.2,y-7.2},{x-4.5,y-7.1}}, true)
work(body + neck + head, {hand="detail", pile=storkW, coverage=3, length={1,3}, fill=true, clip=true, edge="found"})
work(wing, {hand="detail", pile=blackp, angle=0, coverage=3, length={1,3}, fill=true, clip=true, edge="found"})
local r = brush{kind="round", width=0.7, point=1}
r:load(storkRed, 0.5)
r:stroke({{x-0.8,y-7.2},{x-1.2,y-3.5},{x-1.4,y}}, {pressure={0.5,0.45}})
r:stroke({{x+0.2,y-7.2},{x+0.8,y-3.6},{x+0.4,y+0.2}}, {pressure={0.5,0.45}})
r:stroke({{x+4.3,y-15},{x+7.4,y-13.4}}, {pressure={0.55,0.1}})
-- its shadow
local sh = ellipse(x+3, y+0.5, 5, 0.8)
work(sh, {hand="detail", pile=grassSh, coverage=2, length={1,3}, fill=true, clip=true, edge="soft", load=0.5})
print(wait(0))
