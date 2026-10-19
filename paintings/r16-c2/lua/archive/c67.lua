hgz = pile{{"bone black",0.6},{"Prussian blue",0.1},{"raw umber",0.6}, medium=0.6}
igz = pile{{"raw umber",1},{"cobalt blue",0.35},{"bone black",0.15}, medium=0.65}
work(hull, {hand="detail", tool="round 3", pile=hgz, angle=-0.05, coverage=2.5, length={8,20}, fill=true, clip=hull})
work(inner, {hand="detail", tool="round 2", pile=igz, angle=-0.05, coverage=1.5, length={8,20}, fill=true, clip=inner})
local g = brush{kind="round", width=1.3, point=0.6}
g:load(gl, 0.6)
g:stroke({{184,598.5},{205,601},{232,602.5},{260,600.5},{283,596.5},{296,590.5}}, {pressure={0.45,0.3}})
local bird = brush{kind="rigger", width=1.0, point=1}
bird:load(pile{{"raw umber",1},{"bone black",0.4},{"lead white",0.8}}, 0.5)
for _,p in ipairs({{318,296,5},{334,289,4},{345,301,3.5}}) do
  local x,y,s = p[1],p[2],p[3]
  bird:stroke({{x-s, y-s*0.35},{x-s*0.45,y-s*0.45},{x,y}}, {pressure={0.1,0.45}})
  bird:stroke({{x,y},{x+s*0.45,y-s*0.5},{x+s,y-s*0.3}}, {pressure={0.45,0.1}})
end
