local L = {{627,441},{612,452},{585,465},{548,482},{522,500},{515,520},{535,548},{560,580},{555,612},{510,645},{440,685},{370,720}}
local R = {{635,720},{700,714},{692,665},{702,625},{682,590},{632,550},{600,522},{592,500},{602,482},{622,466},{633,452},{634,441}}
local pts = {}
for _,p in ipairs(L) do pts[#pts+1]=p end
for _,p in ipairs(R) do pts[#pts+1]=p end
local old = poly(pts, true):roughen(1.5, 25, 21)
local ex = ((old:grow(3) - creek) * land)
local hor = function(x,y) return 0.04*math.sin(x/90+y/40) end
for pass=1,2 do
work(ex * rect(0,436,1000,50), {hand="body", pile=m_far, angle=hor, coverage=2.5, length={15,40}, tool="filbert 6", fill=true, clip=ex, dips={1,0.9,0.5}})
work(ex * rect(0,480,1000,85), {hand="body", pile=m_mid, angle=hor, coverage=2.5, length={15,50}, tool="filbert 8", fill=true, clip=ex, dips={1,0.9,0.5}})
work(ex * rect(0,560,1000,165), {hand="body", pile=m_near, angle=hor, coverage=2.5, length={20,60}, tool="filbert 10", fill=true, clip=ex, dips={1,0.9,0.5}})
end
