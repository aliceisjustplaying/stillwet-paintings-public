gr_dk  = pile{{"raw umber",1},{"bone black",0.4},{"green earth",0.7}, medium=0.15}
gr_mid = pile{{"raw umber",1},{"green earth",1},{"yellow ochre",0.6}, medium=0.15}
gr_lit = pile{{"yellow ochre",1},{"lead white",0.4},{"red earth",0.15},{"green earth",0.2}, medium=0.12}
fgg = marsh - creek:grow(3)
function blade(b, x, y, len, ang, bend, pr)
  local c, s = math.cos(ang), math.sin(ang)
  local px, py = -s, c
  b:stroke({{x,y},{x+c*len*0.5+px*bend*0.3, y+s*len*0.5+py*bend*0.3},{x+c*len+px*bend, y+s*len+py*bend}},
    {pressure={pr, 0.0}, ramps={0.05,0.7}})
end
function tufts(n, y0, y1, pl, prmax, nbl, seed)
  local brushes = {}
  for i=1,n do
    local x = rand(0,1000); local y = rand(y0,y1)
    if fgg:at(x,y) > 0.5 then
      local k = (y-525)/190
      local w = 1.0 + 2.4*k
      local b = brush{kind="rigger", width=w, point=1}
      b:load(pl, 0.7)
      local L = 4 + 30*k
      local nb = math.random(nbl[1], nbl[2])
      for j=1,nb do
        local ang = -math.pi/2 + randn(0, 0.35)
        blade(b, x + rand(-L*0.25, L*0.25), y + rand(-1,1), L*rand(0.6,1.2), ang, randn(0, L*0.15), rand(0.5,prmax))
        if b:fullness() < 0.2 then b:load(pl, 0.6) end
      end
    end
  end
end
tufts(420, 530, 720, gr_dk, 0.9, {4,9})
tufts(260, 540, 720, gr_mid, 0.8, {3,7})
