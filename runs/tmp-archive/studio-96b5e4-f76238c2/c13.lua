local C = {{668,442},{610,445},{565,450},{572,457},{612,465},{602,478},{566,493},{548,511},{556,536},{586,566},{612,602},{606,642},{572,682},{540,725}}
local pts, ws = {}, {}
for i=1,#C-1 do
  local p0 = C[math.max(1,i-1)]; local p1=C[i]; local p2=C[i+1]; local p3=C[math.min(#C,i+2)]
  for s=0,9 do
    local t=s/10; local t2=t*t; local t3=t2*t
    local function cr(a,b,c,d) return 0.5*((2*b)+(-a+c)*t+(2*a-5*b+4*c-d)*t2+(-a+3*b-3*c+d)*t3) end
    local x=cr(p0[1],p1[1],p2[1],p3[1]); local y=cr(p0[2],p1[2],p2[2],p3[2])
    pts[#pts+1]={x,y}; ws[#ws+1]= 1.0 + 0.5*math.max(0,y-441)
  end
end
creek_line = pts
creek = ribbon(pts, ws):roughen(1.0, 18, 23) * land
marsh = land - creek
for _,y in ipairs({470,500,550,600,650,700}) do local l,rr=nil,nil; for x=380,760 do if creek:at(x,y)>0.5 then l=l or x; rr=x end end; print(y,l,rr) end
g_far  = pile{{"green earth",1},{"raw umber",0.8},{"smalt",0.4},{"lead white",0.8},{"yellow ochre",0.3}, medium=0.1}
g_mid  = pile{{"yellow ochre",1.2},{"raw umber",0.8},{"green earth",0.8},{"lead white",0.35},{"red earth",0.12}, medium=0.1}
g_lmid = pile{{"raw umber",1},{"green earth",1},{"yellow ochre",0.7},{"bone black",0.1}, medium=0.1}
g_near = pile{{"raw umber",1.5},{"green earth",0.8},{"bone black",0.3},{"red earth",0.2}, medium=0.1}
local function band(a, b, s1, s2)
  return below(function(x) return a + 4*math.sin(x/70+s1) + 3*math.sin(x/23+s2) end) * above(function(x) return b + 5*math.sin(x/60+s2) + 3*math.sin(x/19+s1) end)
end
local hor = function(x,y) return 0.03*math.sin(x/90+y/40) end
local bands = {{g_far,430,472,"filbert 5",{15,45}},{g_mid,465,535,"filbert 8",{25,70}},{g_lmid,525,600,"filbert 10",{30,90}},{g_near,590,730,"filbert 14",{40,120}}}
for i,b in ipairs(bands) do
  local m = band(b[2], b[3], i, i*2) * marsh
  work(m, {hand="body", pile=b[1], angle=hor, coverage=2.6, length=b[5], tool=b[4], fill=true, clip=marsh, dips={2,0.85,0.3}})
end
blend(marsh, {angle=0})
