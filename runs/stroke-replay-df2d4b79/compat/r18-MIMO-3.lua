-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.

--@ chunk 1

canvas{size=700, aspect=1.25, linen={16, 14}, seed=7,
  ground={{pile={{"lead white", 1}, {"yellow ochre", 0.3}}, um=120, apply="knife", texture=0.35},
          {pile={{"yellow ochre", 1}, {"red earth", 0.2}, {"lead white", 0.5}, {"bone black", 0.08}}, um=45, apply="brush"}}}
print(table.concat(tubes(), ", "))
print("W,H =", W, H)

--@ chunk 2

table_line = function(x) return 506 + 4*math.sin(x/170) + (x-500)*0.012 end

pw  = pile{{"raw umber", 1}, {"bone black", 0.32}, {"red earth", 0.28}, medium=0.22}
pwl = pile{{"yellow ochre", 1}, {"lead white", 0.55}, {"red earth", 0.12}, medium=0.2}
pt  = pile{{"yellow ochre", 1}, {"red earth", 0.32}, {"lead white", 0.5}, {"bone black", 0.1}, medium=0.18}
ptd = pile{{"raw umber", 1}, {"red earth", 0.35}, {"bone black", 0.22}, medium=0.28}

local wall = above(table_line)
work(wall, {hand="broad", pile=pw, angle=function(x, y) return -0.12 + 0.1*math.sin(x/260) end,
            coverage=1.15, edge={found=0.25, soft=0.5, lost=0.25, period=70, seed=3}, seed=11})

local tbl = below(table_line)
work(tbl, {hand="broad", pile=pt, angle=function(x, y) return 0.06 - 0.14*(x-500)/500 end,
           coverage=1.25, edge={found=0.3, soft=0.5, lost=0.2, period=80, seed=5}, seed=12})
print("blocked in")

--@ chunk 3

local wall = above(table_line)
local tbl = below(table_line)
work(wall, {hand="broad", pile=pw, angle=function(x, y) return -0.12 + 0.12*math.sin(x/230) end,
            coverage=2.1, fill=true, edge={found=0.25, soft=0.5, lost=0.25, period=70, seed=8}, seed=21})
work(wall, {hand="body", pile=pw, angle=function(x, y) return 1.35 + 0.25*math.sin(x/180) end,
            coverage=1.1, fill=true, edge={found=0.2, soft=0.55, lost=0.25, period=60, seed=9}, seed=22})
work(tbl, {hand="broad", pile=pt, angle=function(x, y) return 0.06 - 0.16*(x-500)/500 end,
           coverage=2.0, fill=true, edge={found=0.3, soft=0.5, lost=0.2, period=80, seed=15}, seed=23})
work(tbl, {hand="body", pile=pt, angle=function(x, y) return 0.12 - 0.2*(x-500)/500 end,
           coverage=1.0, fill=true, edge={found=0.25, soft=0.55, lost=0.2, period=70, seed=16}, seed=24})
print("filled")

