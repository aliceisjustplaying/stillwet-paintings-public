work(trees * rect(700,360,310,48), {hand="detail", tool="round 4", pile=treeP, angle=-1.5, coverage=2, length={6,14}, fill=true})
reflM = mask(function(x,y) if y < 404 or y > 490 then return 0 end; local v = trees:at(x, 808 - y); return v * (1 - smoothstep(440, 488, y)) end)
reflP = pile{{"raw umber",1},{"bone black",0.3},{"cobalt blue",0.3},{"lead white",1.3},{"yellow ochre",0.3}}
work(reflM, {hand="body", tool="filbert 5", pile=reflP, angle=math.pi/2, coverage=2, length={10,30}, fill=true, threshold=0.4})
