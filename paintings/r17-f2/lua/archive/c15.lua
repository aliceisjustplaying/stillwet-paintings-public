local x, y = 122, 551
local storkK = poly({{x-5.5,y-8.2},{x-3,y-10},{x+1.5,y-10.4},{x+3.2,y-9.6},{x+2.4,y-7.6},{x-1,y-6.8},{x-4.5,y-7}}, true):grow(0.6)
  + ribbon({{x+2.4,y-9.8},{x+3.4,y-12.5},{x+3.2,y-14.6}}, 2.4) + ellipse(x+3.4, y-15, 1.8, 1.6)
  + ribbon({{x-0.8,y-7.2},{x-1.2,y-3.5},{x-1.4,y}}, 1.2) + ribbon({{x+0.2,y-7.2},{x+0.8,y-3.6},{x+0.4,y+0.2}}, 1.2)
  + ribbon({{x+4.3,y-15},{x+7.4,y-13.4}}, 1.2) + ellipse(x+3, y+0.5, 5, 0.9)
local ring = ellipse(122, 543, 10, 11) - storkK
local tl = function(px, py) return -math.pi/2 + 0.08 + 0.1 * math.sin(px / 23 + py / 7) end
work(ring, {hand="hatch", pile=pastC, tool={kind="round", width=1.1, point=0.9}, angle=tl, length={2,4}, coverage=2.0, pressure={0.35,0.55}, ramps={0.1,0.6}, clip=ring, clump=0.2, fill=true})
print(wait(0))
