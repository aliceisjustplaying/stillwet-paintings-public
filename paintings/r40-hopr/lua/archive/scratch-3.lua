-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box hopper
--@ engine 5

--@ chunk 1
canvas{aspect=1.6, ground={{apply="knife", pile={{"lead white", 10}, {"yellow ochre", 0.25}}, texture=0.3, um=90}}, linen={18, 16}, seed=4127, size=900}

--@ chunk 2
st = pile{{"bone black",3},{"ultramarine blue",1},{"burnt sienna",0.7},{"viridian",0.2},{"lead white",0.25}, medium=0.05}
work(rect(850,560,150,65), {hand="body", pile=st, coverage=2.5, fill=true, clip=true, angle=-0.06})
wait(6*24*60)
sig = pile{{"red earth",1},{"bone black",0.5},{"lead white",0.45},{"burnt sienna",0.2}, medium=0.05}
G = {
 C={{{0.95,0.82},{0.75,1},{0.3,1},{0.05,0.78},{0.05,0.22},{0.3,0},{0.75,0},{0.95,0.18}}},
 L={{{0.12,1},{0.12,0},{0.9,0}}},
 A={{{0.02,0},{0.5,1},{0.98,0}},{{0.24,0.38},{0.76,0.38}}},
 U={{{0.1,1},{0.1,0.25},{0.3,0},{0.7,0},{0.9,0.25},{0.9,1}}},
 D={{{0.12,0},{0.12,1},{0.55,1},{0.88,0.75},{0.88,0.25},{0.55,0},{0.12,0}}},
 E={{{0.9,1},{0.12,1},{0.12,0},{0.9,0}},{{0.12,0.52},{0.72,0.52}}},
}
b = brush{kind="round", width=1.3, point=0.5}
local x, base = 900, 608
for ch in ("CLAUDE"):gmatch(".") do
  for _, s in ipairs(G[ch]) do
    local pts = {}
    for _, uv in ipairs(s) do pts[#pts+1] = {x + uv[1]*6, base - uv[2]*8.5 - (x-900)*0.03} end
    b:reload(sig, 0.5); b:stroke(pts, {pressure=0.6, ramps={0.05,0.1}})
  end
  x = x + 9
end
