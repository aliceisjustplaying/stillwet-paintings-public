local L = {{627,441},{612,452},{585,465},{548,482},{522,500},{515,520},{535,548},{560,580},{555,612},{510,645},{440,685},{370,720}}
local R = {{635,720},{700,714},{692,665},{702,625},{682,590},{632,550},{600,522},{592,500},{602,482},{622,466},{633,452},{634,441}}
local pts = {}
for _,p in ipairs(L) do pts[#pts+1]=p end
for _,p in ipairs(R) do pts[#pts+1]=p end
creek = poly(pts, true):roughen(1.5, 25, 21)
land = -sky
marsh = land - creek
m_far  = pile{{"raw umber",1},{"green earth",1},{"smalt",0.5},{"lead white",0.6},{"bone black",0.1}, medium=0.1}
m_mid  = pile{{"yellow ochre",1},{"raw umber",1},{"green earth",1},{"lead white",0.3}, medium=0.1}
m_warm = pile{{"yellow ochre",1.5},{"red earth",0.3},{"raw umber",0.6},{"lead white",0.4}, medium=0.1}
m_near = pile{{"raw umber",1.5},{"green earth",1},{"bone black",0.3},{"yellow ochre",0.5}, medium=0.1}
w_far  = pile{{"lead white",5},{"chrome yellow",0.4},{"vermilion",0.1},{"raw umber",0.12}, medium=0.1}
w_mid  = pile{{"lead white",4},{"yellow ochre",0.2},{"cobalt blue",0.25},{"raw umber",0.2}, medium=0.1}
w_near = pile{{"lead white",3},{"cobalt blue",0.4},{"smalt",0.5},{"raw umber",0.35}, medium=0.1}
local hor = function(x,y) return 0.04*math.sin(x/90+y/40) end
-- marsh
work(marsh * rect(0,436,1000,50), {hand="body", pile=m_far, angle=hor, coverage=2.2, length={30,90}, tool="filbert 8", fill=true, clip=true})
work(marsh * rect(0,480,1000,90), {hand="body", pile=m_mid, angle=hor, coverage=2.2, length={30,90}, tool="filbert 10", fill=true, clip=marsh})
work(marsh * rect(0,560,1000,160), {hand="body", pile=m_near, angle=hor, coverage=2.2, length={40,110}, tool="filbert 12", fill=true, clip=marsh})
-- water
work(creek * rect(0,436,1000,90), {hand="body", pile=w_far, angle=0, coverage=2.5, length={15,50}, tool="filbert 5", fill=true, clip=true})
work(creek * rect(0,520,1000,90), {hand="body", pile=w_mid, angle=0, coverage=2.5, length={30,80}, tool="filbert 8", fill=true, clip=true})
work(creek * rect(0,600,1000,120), {hand="body", pile=w_near, angle=0, coverage=2.5, length={30,100}, tool="filbert 10", fill=true, clip=true})
