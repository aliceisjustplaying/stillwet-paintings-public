local tests = {
 pile{{"lead white",1},{"smalt",4},{"raw umber",0.3}},
 pile{{"lead white",1},{"cobalt blue",1.5},{"raw umber",0.2}},
 pile{{"lead white",3},{"Prussian blue",0.3},{"raw umber",0.3},{"red earth",0.1}},
 pile{{"lead white",1.5},{"smalt",3},{"red earth",0.25},{"raw umber",0.3}},
 pile{{"lead white",2},{"smalt",2},{"raw umber",0.8}},
 pile{{"lead white",3},{"vermilion",0.4},{"yellow ochre",1.2}},
 pile{{"lead white",3},{"chrome yellow",0.6},{"yellow ochre",0.4}},
 pile{{"lead white",3},{"smalt",1.5},{"vermilion",0.3},{"raw umber",0.2}},
}
local b = brush("flat", 14)
for i,p in ipairs(tests) do
  local x = 520 + (i-1)*58
  b:reload(p, 0.9)
  for k=0,3 do b:stroke({{x, 660+k*9},{x+40, 660+k*9}}, {pressure=0.8}) end
end
