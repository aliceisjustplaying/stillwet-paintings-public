jf = form{ {body.ellipsoid({362,425,0},{124,180,110})}, {body.ellipsoid({360,235,0},{64,62,55})}, light={from={-1,-0.6}, front=0.55, ambient=0.2} }
for _, pt in ipairs({{280,380},{360,420},{430,420},{470,450},{360,560},{320,230},{410,240}}) do
  print(pt[1], pt[2], string.format("%.2f", jf:value(pt[1], pt[2])))
end
