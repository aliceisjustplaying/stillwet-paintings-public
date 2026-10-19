cockp = pile{{"raw umber",1.4},{"yellow ochre",1.2},{"green earth",0.5},{"lead white",0.5},{"pale smalt",0.3}, medium=0.2}
cocklit = pile{{"yellow ochre",1.2},{"lead white",1.8},{"raw umber",0.4},{"vermilion",0.05}, medium=0.2}
cockdk = pile{{"raw umber",2},{"green earth",0.8},{"bone black",0.15},{"smalt",0.3}, medium=0.2}
local function cockshape(x, y, h)
  local w = h*0.46
  return poly({{x-w,y},{x-w*0.98,y-h*0.3},{x-w*0.8,y-h*0.62},{x-w*0.45,y-h*0.88},{x,y-h},{x+w*0.45,y-h*0.88},{x+w*0.8,y-h*0.62},{x+w*0.98,y-h*0.3},{x+w,y}}, true)
end
COCKS = {}
local list = {{452,520,12},{508,520,12.5},{577,519.5,12},{693,519,12},{742,519,12},{803,519,11.5},{877,518.5,11.5},{943,518.5,11},
              {474,534.5,15},{563,534,15},{722,533.5,15},{832,533,14.5},{915,533,14.5}}
local all = nil
for i,c in ipairs(list) do
  local m = cockshape(c[1]+rand(-2,2), c[2], c[3]*rand(0.92,1.08)):roughen(0.5, 3, 620+i)
  COCKS[i] = {m=m, x=c[1], y=c[2], h=c[3]}
  all = all and (all + m) or m
end
ALLCOCKS = all
-- contact shadow under each
for i,c in ipairs(COCKS) do
  local sh = ellipse(c.x, c.y+0.5, c.h*0.62, c.h*0.09)
  work(sh, {hand="detail", pile=cockdk, tool={kind="round", width=1.2}, angle=0, coverage=3, fill=true, length={3,8}, seed=640+i})
end
work(ALLCOCKS, {hand="detail", pile=cockp, tool={kind="round", width=1.3, point=0.6}, angle=function(x,y) return -math.pi/2 end, angle_jitter=0.4, coverage=4, fill=true, length={2,6}, seed=660})
