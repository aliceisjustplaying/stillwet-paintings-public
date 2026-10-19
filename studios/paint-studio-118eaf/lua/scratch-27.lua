-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"lead white", 10}, {"bone black", 0.2}}, texture=0.3, um=120}, {apply="brush", pile={{"lead white", 6}, {"red earth", 1.2}, {"raw umber", 1}, {"yellow ochre", 0.6}}, texture=0.5, um=40}}, linen={16, 14}, seed=4471, size=900}

--@ chunk 2
sk_rose = pile{{"lead white", 2}, {"vermilion", 0.35}, {"rose madder", 0.3}, {"raw umber", 0.12}, {"Naples yellow", 0.3}}
sk_apricot = pile{{"lead white", 2}, {"orange chrome", 0.8}, {"vermilion", 0.25}, {"yellow ochre", 0.3}}
fl_halo = pile{{"lead white", 3}, {"Naples yellow", 1}, {"cadmium yellow", 0.6}}
for i, dy in ipairs({0, 120, 240}) do
  local m = rect(300, 280+dy, 200, 100)
  work(m, {hand="body", piles={{sk_rose, function(x,y) return clamp((440-x)/120,0,1) end},
                               {sk_apricot, function(x,y) return clamp((x-330)/110,0,1)*0.8 end},
                               {fl_halo, function(x,y) return clamp((x-445)/30,0,1) end}},
           coverage=2, fill=true, clip=true, angle=0.1})
end
wait(10*24*60)
print(drying(350,320))

--@ chunk 3
cw_coat_dk = pile{{"raw umber",1},{"bone black",0.35},{"ultramarine blue",0.45},{"burnt sienna",0.4},{"lead white",0.05}}
fc_dk2 = pile{{"raw umber",1},{"bone black",0.22},{"burnt sienna",0.3},{"ultramarine blue",0.3},{"rose madder",0.08}}
cw_dark = pile{{"bone black",1},{"raw umber",1},{"ultramarine blue",0.5}}
function sleeve_at(dy)
  return poly({{300,308+dy},{340,318+dy},{380,327+dy},{420,333+dy},{428,334+dy},{428,357+dy},{400,355+dy},{360,351+dy},{320,345+dy},{300,342+dy}})
end
function hand_at(dy)
  return poly({{426,336+dy},{436,333+dy},{448,334+dy},{452,340+dy},{450,352+dy},{444,359+dy},{430,358+dy},{426,352+dy}})
end
for i, dy in ipairs({0,120,240}) do
  work(sleeve_at(dy), {hand="detail", pile=cw_coat_dk, tool={kind="round", width=2.5}, coverage=3.2, clip=true})
  work(hand_at(dy), {hand="detail", pile=fc_dk2, tool={kind="round", width=2.2}, coverage=3.5, clip=true})
  local gb = brush{kind="round", width=3, point=0.3}
  gb:load(cw_dark, 0.8)
  gb:stroke({{446,333+dy},{492,333+dy}}, {pressure=0.8})
end
wait(16*24*60)
print(drying(380,340), drying(440,345))

--@ chunk 4
zb_flash = pile{{"orange chrome",1},{"Naples yellow",0.6},{"burnt sienna",0.3},{"lead white",0.2}}
sl_rimA = mix{{cw_coat_dk,0.55},{zb_flash,0.45}, name="sl_rimA"}
sl_rimB = mix{{cw_coat_dk,0.4},{zb_flash,0.6}, name="sl_rimB"}
rb = brush{kind="round", width=1.8, point=0.9}
function rims(dy, p)
  rb:reload(p, 0.6)
  rb:gesture({{366,350.2+dy,0.0},{385,352.3+dy,0.25},{405,354.2+dy,0.45},{424,355.6+dy,0.6}}, {wobble=0.2})
  rb:reload(p, 0.5)
  rb:gesture({{402,331.6+dy,0.0},{414,333.0+dy,0.3},{425,334.4+dy,0.45}}, {wobble=0.2})
end
rims(0, sl_rimA)
rims(120, sl_rimB)
print(drying(400,354))

--@ chunk 5
rim_warm = pile{{"burnt sienna",1},{"Naples yellow",0.9},{"orange chrome",0.35},{"vermilion",0.12},{"lead white",0.2}}
sl_rimC = mix{{cw_coat_dk,0.35},{rim_warm,0.65}, name="sl_rimC"}
rc = brush{kind="round", width=2.4, point=0.9}
local dy = 240
rc:reload(sl_rimC, 0.65)
rc:gesture({{372,351.6+dy,0.0},{392,353.8+dy,0.3},{410,355.3+dy,0.55},{426,356.3+dy,0.75}}, {wobble=0.2})
rc:reload(sl_rimC, 0.5)
rc:gesture({{404,331.6+dy,0.0},{415,333.0+dy,0.35},{426,334.2+dy,0.5}}, {wobble=0.2})
-- cuff end below the hand
rc:reload(sl_rimC, 0.5)
rc:gesture({{426.5,350+dy,0.2},{427,356.5+dy,0.5}}, {wobble=0.1})
