local C = {{668,442},{610,445},{565,450},{572,457},{612,465},{602,478},{566,493},{548,511},{556,536},{586,566},{612,602},{606,642},{572,682},{540,725}}
-- catmull-rom
local pts, ws = {}, {}
for i=1,#C-1 do
  local p0 = C[math.max(1,i-1)]; local p1=C[i]; local p2=C[i+1]; local p3=C[math.min(#C,i+2)]
  for s=0,9 do
    local t=s/10; local t2=t*t; local t3=t2*t
    local function cr(a,b,c,d) return 0.5*((2*b)+(-a+c)*t+(2*a-5*b+4*c-d)*t2+(-a+3*b-3*c+d)*t3) end
    local x=cr(p0[1],p1[1],p2[1],p3[1]); local y=cr(p0[2],p1[2],p2[2],p3[2])
    pts[#pts+1]={x,y}; ws[#ws+1]= 1.5 + 0.85*math.max(0,y-441)
  end
end
creek_line = pts
creek2 = ribbon(pts, ws):roughen(1.2, 20, 22) * land
local extra_marsh = (creek - creek2) * land
local extra_water = creek2 - creek
local hor = function(x,y) return 0.04*math.sin(x/90+y/40) end
work(extra_marsh * rect(0,436,1000,50), {hand="body", pile=m_far, angle=hor, coverage=2.5, length={15,50}, tool="filbert 6", fill=true, clip=extra_marsh})
work(extra_marsh * rect(0,480,1000,85), {hand="body", pile=m_mid, angle=hor, coverage=2.5, length={20,60}, tool="filbert 8", fill=true, clip=extra_marsh})
work(extra_marsh * rect(0,560,1000,165), {hand="body", pile=m_near, angle=hor, coverage=2.5, length={30,80}, tool="filbert 10", fill=true, clip=extra_marsh})
work(extra_water * rect(0,436,1000,90), {hand="body", pile=w_far, angle=0, coverage=2.5, length={10,30}, tool="filbert 4", fill=true, clip=extra_water})
work(extra_water * rect(0,520,1000,200), {hand="body", pile=w_mid, angle=0, coverage=2.5, length={10,40}, tool="filbert 5", fill=true, clip=extra_water})
creek = creek2
marsh = land - creek
