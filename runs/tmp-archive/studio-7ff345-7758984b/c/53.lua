-- glaze the root flares down into the trunk's tone; model them with a dark underside
local roots = footM - driftM
work(roots, {hand="detail", tool={kind="round", width=3, point=0.5}, pile=barkDark, load=0.9, pressure={0.5, 0.8}, coverage=3, fill=true, clip=true, angle=-math.pi/2, angle_jitter=0.4})
local r = brush{kind="round", width=1.6, point=1}
local fur = pile{{"bone black",1.5},{"raw umber",0.8},{"smalt",0.3}, medium=0.2}
for _, pts in ipairs({{{214,424},{206,437},{194,447}}, {{262,424},{270,437},{284,447}}, {{238,430},{237,446}}}) do
  r:load(fur, 0.7); r:stroke(pts, {pressure={0.5, 0.15}, clip=roots})
end
