erase(rect(40,115,530,240) + rect(40,245,530,355), {strength=0.9})
local function R(x0,y0,x1,y1,p) h:rule({x0,y0},{x1,y1},{pressure=p or 0.35}) end
for i=0,4 do
  local c = 60 + i*116
  for _,r in ipairs({{118,222},{252,352}}) do
    R(c-28,r[1],c+28,r[1]) R(c-28,r[2],c+28,r[2]) R(c-28,r[1],c-28,r[2]) R(c+28,r[1],c+28,r[2])
  end
end
-- shadow line of unseen building
R(0,290,380,560,0.25)