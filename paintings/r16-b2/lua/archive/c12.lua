function spline(pts, n)
  local out = {}
  local function cr(p0,p1,p2,p3,t)
    local t2,t3=t*t,t*t*t
    return 0.5*((2*p1)+(-p0+p2)*t+(2*p0-5*p1+4*p2-p3)*t2+(-p0+3*p1-3*p2+p3)*t3)
  end
  for i=1,#pts-1 do
    local p0=pts[math.max(1,i-1)]; local p1=pts[i]; local p2=pts[i+1]; local p3=pts[math.min(#pts,i+2)]
    for k=0,n-1 do local t=k/n
      out[#out+1]={cr(p0[1],p1[1],p2[1],p3[1],t), cr(p0[2],p1[2],p2[2],p3[2],t)} end
  end
  out[#out+1]=pts[#pts]
  return out
end
function strip(pts, wmax, seed, taper)
  local s = spline(pts, 12)
  local nz = noise{seed=seed, period=40, octaves=3}
  local ws = {}
  for i,p in ipairs(s) do
    local t = (i-1)/(#s-1)
    local tp = math.sin(math.pi*t)^(taper or 0.6)
    ws[i] = math.max(0.3, wmax*tp*(0.75+0.35*nz(p[1],p[2])))
  end
  return ribbon(s, ws)
end
cloudA = pile{{"pale smalt",1.2},{"lead white",4},{"vermilion",0.25},{"raw umber",0.25}, medium=0.35}
cloudB = pile{{"smalt",1},{"lead white",3},{"vermilion",0.15},{"raw umber",0.3}, medium=0.35}
cloudLit = pile{{"lead white",5},{"vermilion",0.35},{"yellow ochre",0.5}, medium=0.3}
-- low long bar
CL1 = strip({{140,372},{300,369},{470,371},{640,368},{780,370},{920,367}}, 5.5, 11)
CL1b = strip({{470,393},{560,391},{660,394},{760,392},{830,393}}, 3.2, 12)
CL1c = strip({{40,354},{130,356},{230,353},{300,355}}, 3, 13)
-- upper wisps around y~150-190
CU1 = strip({{180,156},{260,153},{330,158},{420,156}}, 7, 14)
CU2 = strip({{520,168},{600,166},{680,170},{760,167},{880,163}}, 6, 15)
CU3 = strip({{700,128},{800,125},{930,128},{1010,124}}, 5, 16)
CU4 = strip({{20,190},{110,192},{190,189}}, 4, 17)
CLOW = CL1 + CL1b + CL1c
CUP = CU1 + CU2 + CU3 + CU4
work(CLOW, {hand="detail", pile=cloudA, angle=0, coverage=3, fill=true, length={10,30}, seed=121})
work(CUP, {hand="detail", pile=cloudB, angle=0, coverage=3, fill=true, length={10,30}, seed=122})
