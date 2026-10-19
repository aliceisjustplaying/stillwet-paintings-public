-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box hopper
--@ engine 5

--@ chunk 1
canvas{aspect=1.6, ground={{apply="knife", pile={{"lead white", 10}, {"yellow ochre", 0.25}}, texture=0.3, um=90}}, linen={18, 16}, seed=4127, size=900}

--@ chunk 2
P = {}
P.sky = pile{{"ultramarine blue",3},{"viridian",1},{"bone black",1},{"lead white",1.5}, turps=0.5}
P.brick = pile{{"red earth",2},{"bone black",1.5},{"ultramarine blue",1},{"burnt sienna",1}, turps=0.5}
P.shop = pile{{"lead white",10},{"pale cadmium",1},{"viridian",0.15}, turps=0.4}
P.walk = pile{{"lead white",3},{"yellow ochre",1},{"bone black",0.3}, turps=0.5}
P.street = pile{{"bone black",2},{"ultramarine blue",1},{"burnt sienna",1},{"lead white",0.5}, turps=0.5}
P.far = pile{{"bone black",2},{"ultramarine blue",1.5},{"viridian",0.5},{"lead white",0.5}, turps=0.5}
P.warm = pile{{"lead white",4},{"deep cadmium",1},{"yellow ochre",1}, turps=0.4}
local names = {"sky","brick","shop","walk","street","far","warm"}
for i,n in ipairs(names) do
  local x = 30 + (i-1)*135
  work(rect(x, 40, 110, 250), {hand="body", pile=P[n], coverage=1.5})
  work(rect(x, 320, 110, 250), {hand="body", pile=P[n], coverage=3})
end

--@ chunk 3
wait(5*24*60)
Q = {}
Q.sky = pile{{"ultramarine blue",2},{"viridian",1},{"bone black",2},{"lead white",0.8},{"burnt sienna",0.3}, turps=0.3}
Q.brick = pile{{"red earth",1.5},{"bone black",2.5},{"burnt sienna",0.8},{"ultramarine blue",0.5}, turps=0.3}
Q.walk = pile{{"bone black",1.5},{"yellow ochre",1},{"burnt sienna",0.5},{"lead white",1}, turps=0.3}
Q.street = pile{{"bone black",2.5},{"ultramarine blue",1},{"burnt sienna",0.5},{"lead white",0.3}, turps=0.3}
Q.far = pile{{"bone black",2.5},{"ultramarine blue",1},{"viridian",0.6},{"red earth",0.3},{"lead white",0.3}, turps=0.3}
local names = {"sky","brick","walk","street","far"}
for i,n in ipairs(names) do
  local x = 30 + (i-1)*135
  work(rect(x+15, 200, 80, 300), {hand="body", pile=Q[n], coverage=2.5, fill=true, clip=true})
end

--@ chunk 4
FONT = {
 C={{{0.95,0.82},{0.75,1},{0.3,1},{0.05,0.78},{0.05,0.22},{0.3,0},{0.75,0},{0.95,0.18}}},
 L={{{0.12,1},{0.12,0},{0.9,0}}},
 E={{{0.9,1},{0.12,1},{0.12,0},{0.9,0}},{{0.12,0.52},{0.72,0.52}}},
 A={{{0.02,0},{0.5,1},{0.98,0}},{{0.24,0.38},{0.76,0.38}}},
 N={{{0.1,0},{0.1,1},{0.9,0},{0.9,1}}},
 R={{{0.12,0},{0.12,1},{0.65,1},{0.9,0.86},{0.9,0.64},{0.65,0.5},{0.12,0.5}},{{0.52,0.5},{0.92,0}}},
 S={{{0.9,0.84},{0.7,1},{0.3,1},{0.1,0.84},{0.1,0.66},{0.3,0.53},{0.7,0.47},{0.9,0.34},{0.9,0.16},{0.7,0},{0.3,0},{0.08,0.16}}},
}
cream = pile{{"lead white",5},{"yellow ochre",0.5},{"cadmium yellow",0.15}, turps=0.15}
function letters(word, x0, cell, w, ybase, cap, br, pl, place)
  for i = 1, #word do
    local ch = word:sub(i,i)
    local f = FONT[ch]
    if f then
      for _, s in ipairs(f) do
        local pts = {}
        for _, uv in ipairs(s) do
          local x = x0 + (i-1)*cell + uv[1]*w
          pts[#pts+1] = place and {place(x, uv[2])} or {x, ybase - uv[2]*cap}
        end
        br:reload(pl, 0.7)
        br:stroke(pts, {pressure=0.6, ramps={0.05,0.05}})
      end
    end
  end
end
local b = brush{kind="round", width=3.2, point=0.2}
letters("CLEANERS", 600, 45, 30, 260, 22, b, cream)
local b2 = brush{kind="flat", width=3.2}
letters("CLEANERS", 600, 45, 30, 320, 22, b2, cream)

--@ chunk 5
print(varnish, glaze, dry, retouch)
