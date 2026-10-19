woodp = pile{{"raw umber",1.5},{"lead white",0.6},{"pale smalt",0.5},{"bone black",0.12}, medium=0.2}
woodlit = pile{{"lead white",2},{"pale smalt",0.6},{"raw umber",0.5},{"yellow ochre",0.2}, medium=0.2}
local posts = {}
local x = 612
while x < 1010 do posts[#posts+1] = x; x = x + rand(34,42) end
local gx = {488, 526, 566}
FENCE = nil
local function add(m) FENCE = FENCE and (FENCE + m) or m end
local function fbase(x) return FGTOP(x) + 3 end
local function postm(x, h, lean)
  local b = fbase(x)
  return poly({{x-1.2,b},{x+1.2,b},{x+1.1+lean,b-h},{x-1.1+lean,b-h-0.6}})
end
for i,px in ipairs(posts) do add(postm(px, rand(19,22), rand(-1.2,1.2))) end
for i,px in ipairs(gx) do add(postm(px, rand(18,21), rand(-1.5,1.5))) end
-- rails right section
local function rails(xs)
  for r,hh in ipairs({17, 9}) do
    for i=1,#xs-1 do
      local x1, x2 = xs[i], xs[i+1]
      local y1, y2 = fbase(x1)-hh, fbase(x2)-hh
      local mid = {(x1+x2)/2, (y1+y2)/2 + rand(0.3,1.2)}
      add(ribbon({{x1,y1},mid,{x2,y2}}, 1.3))
    end
  end
end
rails(posts)
rails(gx)
-- the gate: open, swung back against the fence on the right
local gp = posts[1]
add(ribbon({{gp, fbase(gp)-17},{gp+30, fbase(gp+30)-16.5}}, 1.2))
add(ribbon({{gp, fbase(gp)-5},{gp+30, fbase(gp+30)-5}}, 1.2))
add(ribbon({{gp, fbase(gp)-17},{gp+30, fbase(gp+30)-5}}, 1.0))
add(ribbon({{gp+30, fbase(gp+30)-17},{gp+30, fbase(gp+30)-4}}, 1.0))
work(FENCE, {hand="detail", pile=woodp, tool={kind="round", width=1.0, point=0.6}, angle=math.pi/2, angle_jitter=0.2, coverage=4, fill=true, length={2,5}, seed=711})
FPOSTS = posts
