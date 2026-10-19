-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.

--@ chunk 1
canvas{size=700, aspect=1.4, linen={17,14}, seed=1807,
 ground={{pile={{"red earth",2},{"yellow ochre",2},{"lead white",1}}, um=90, apply="knife", texture=0.3},
         {pile={{"lead white",8},{"yellow ochre",0.25},{"raw umber",0.08}}, um=45, apply="brush"}}}
print(W,H)

--@ chunk 2
-- geometry, kept as globals
function knoll(x)
  local k = 468 - 52 * math.exp(-((x - 190) / 190)^2) + 3*math.sin(x/37)
  return k
end
function horizon(x) return 468 + 1.5*math.sin(x/53) end
function woodtop(x) return 452 + 5*math.sin(x/23) + 4*math.sin(x/61+1) + 3*math.sin(x/9.7) end
h = pencil("2H")
-- horizon line
local pts = {}
for x = 380, 1000, 20 do pts[#pts+1] = {x, horizon(x)} end
h:sketch(pts, {pressure=0.25})
-- knoll
pts = {}
for x = 0, 480, 20 do pts[#pts+1] = {x, math.min(knoll(x), horizon(x))} end
h:sketch(pts, {pressure=0.3})
-- distant woods top
pts = {}
for x = 380, 1000, 10 do pts[#pts+1] = {x, woodtop(x)} end
h:sketch(pts, {pressure=0.18})
-- church at x 640
h:line({{634, 466}, {634, 418}}, {pressure=0.25})
h:line({{646, 466}, {646, 418}}, {pressure=0.25})
h:line({{633, 418}, {640, 392}, {647, 418}}, {pressure=0.25, smooth=false})
h:line({{646, 440}, {690, 440}, {690, 466}}, {pressure=0.2, smooth=false})
-- mere
pts = {}
for i = 0, 36 do
  local a = i / 36 * 2 * math.pi
  pts[#pts+1] = {640 + 255*math.cos(a) + 12*math.sin(3*a), 574 + 36*math.sin(a) + 4*math.sin(5*a)}
end
h:sketch(pts, {pressure=0.25})
-- oak trunk
h:sketch({{215, 440}, {220, 380}, {224, 320}, {222, 270}}, {pressure=0.35})
h:sketch({{262, 440}, {254, 380}, {252, 320}, {256, 270}}, {pressure=0.35})
-- main boughs
h:sketch({{224, 280}, {180, 240}, {130, 225}, {80, 238}}, {pressure=0.3})
h:sketch({{236, 270}, {220, 200}, {205, 130}, {210, 70}}, {pressure=0.3})
h:sketch({{248, 272}, {280, 210}, {300, 150}, {290, 95}}, {pressure=0.3})
h:sketch({{254, 285}, {320, 255}, {380, 250}, {420, 270}}, {pressure=0.3})
-- spruces
for _, s in ipairs({{850, 506, 95}, {884, 510, 135}, {922, 508, 72}}) do
  h:sketch({{s[1] - s[3]*0.28, s[2]}, {s[1], s[2] - s[3]}, {s[1] + s[3]*0.28, s[2]}}, {pressure=0.25, smooth=false})
end
-- figure
h:line({{520, 530}, {520, 504}}, {pressure=0.3})
h:line({{528, 532}, {531, 502}}, {pressure=0.25})
-- path
h:sketch({{300, 714}, {390, 640}, {470, 575}, {515, 532}}, {pressure=0.18})

--@ chunk 3
sky1 = pile{{"smalt",3},{"lead white",3},{"bone black",0.25},{"red earth",0.1}, medium=0.15}
sky2 = pile{{"pale smalt",2},{"lead white",5},{"smalt",0.5},{"bone black",0.08}, medium=0.15}
sky3 = pile{{"lead white",7},{"pale smalt",1},{"yellow ochre",0.35}, medium=0.15}
sky4 = pile{{"lead white",8},{"yellow ochre",0.8},{"vermilion",0.07}, medium=0.15}
sky5 = pile{{"lead white",6},{"yellow ochre",1},{"vermilion",0.3},{"red earth",0.15}, medium=0.15}
local bands = {{sky1, -10, 125}, {sky2, 105, 235}, {sky3, 215, 335}, {sky4, 315, 405}, {sky5, 390, 485}}
for i, b in ipairs(bands) do
  work(rect(-10, b[2], 1020, b[3] - b[2]), {hand="body", pile=b[1], angle=0, angle_jitter=0.06,
     length={70, 170}, coverage=2.6, fill=true, pressure={0.5, 0.75}, seed=30+i})
end

