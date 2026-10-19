-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 8}, {"raw umber", 1}, {"yellow ochre", 1}}, texture=0.15, um=35}, {apply="roller", pile={{"lead white", 6}, {"yellow ochre", 2}, {"raw umber", 1}, {"burnt sienna", 0.5}}, um=20}}, linen={18, 14}, seed=42, size=500}

--@ chunk 2
-- Test on scratch canvas
local g = {}
for k, v in pairs(_G) do
  table.insert(g, k)
end
table.sort(g)
print("Globals in easel:", table.concat(g, ", "))

--@ chunk 3
local function try(name, fn)
  local ok, err = pcall(fn)
  if not ok then print(name, "error:", err) end
end

try("brush", function()
  local b = brush{width = 20}
  print("brush width 20:", b)
  for k, v in pairs(b) do print(" ", k, v) end
end)

try("knife", function()
  local k = knife{width = 20}
  print("knife width 20:", k)
  for k, v in pairs(k) do print(" ", k, v) end
end)

try("pencil", function()
  local p = pencil{hardness = "2B"}
  print("pencil:", p)
  for k, v in pairs(p) do print(" ", k, v) end
end)

try("rag", function()
  local r = rag{}
  print("rag:", r)
  for k, v in pairs(r) do print(" ", k, v) end
end)

--@ chunk 4
local function inspect_meta(name, obj)
  local mt = getmetatable(obj)
  print("--- Metatable for " .. name .. " ---")
  if mt then
    for k, v in pairs(mt) do
      print(" ", k, type(v))
      if type(v) == "table" then
        for k2, v2 in pairs(v) do
          print("   ", k2, type(v2))
        end
      end
    end
  else
    print(" no metatable")
  end
end

inspect_meta("brush", brush{width = 20})
inspect_meta("knife", knife{width = 20})
inspect_meta("pencil", pencil{grade = "2B"})
inspect_meta("rag", rag{})

--@ chunk 5
local function trigger_opts(name, fn)
  local ok, err = pcall(fn)
  print(name, "options error:", err)
end

trigger_opts("brush", function() brush{foo = 1} end)
trigger_opts("knife", function() knife{foo = 1} end)
trigger_opts("rag", function() rag{foo = 1} end)
trigger_opts("pencil", function() pencil{foo = 1} end)
trigger_opts("pile", function() pile{foo = 1} end)
trigger_opts("work", function() work{foo = 1} end)
trigger_opts("poly", function() poly{foo = 1} end)
trigger_opts("ribbon", function() ribbon{foo = 1} end)
trigger_opts("rect", function() rect{foo = 1} end)
trigger_opts("ellipse", function() ellipse{foo = 1} end)

--@ chunk 6
local function trigger(fn)
  local ok, err = pcall(fn)
  print("err:", err)
end

trigger(function() brush{width=20, foo=1} end)
trigger(function() work({}, {foo=1}) end)
trigger(function() rect(1, 2, 3, 4, 5) end)
trigger(function() ellipse(1, 2, 3, 4, 5) end)
trigger(function() ribbon({1,2}, 3) end)

--@ chunk 7
local ok, err = pcall(function() brush{width=20, invalid_field=1} end)
print("brush invalid_field:", err)

local m = rect(0, 0, 100, 100)
local ok2, err2 = pcall(function() work(m, {invalid_field=1}) end)
print("work invalid_field:", err2)

--@ chunk 8
local b = brush{width=20}
local methods = {"stroke", "touch", "dip", "wipe", "clean", "dab", "load", "wash", "drag"}
for _, m in ipairs(methods) do
  if b[m] then
    print("brush has method:", m)
  end
end

--@ chunk 9
local function test_brush_opt(t)
  local ok, res = pcall(function() return brush(t) end)
  if ok then print("success:", res) else print("fail:", res) end
end

test_brush_opt{width=20}
test_brush_opt{width=20, kind="flat"}
test_brush_opt{width=20, kind="round"}
test_brush_opt{width=20, kind="filbert"}
test_brush_opt{width=20, point=0.5}
test_brush_opt{width=20, hair="bristle"}
test_brush_opt{width=20, hair="sable"}
test_brush_opt{width=20, stiffness=0.8}

--@ chunk 10
local b = brush{width=20}
local p = pile{{"lead white", 1}}
local ok, err = pcall(function() b:load(p, 0.8) end)
print("b:load:", ok, err, b)
local ok2, err2 = pcall(function() b:stroke({{100, 100}, {200, 100}}) end)
print("b:stroke:", ok2, err2)

--@ chunk 11
local hands = {"broad", "body", "hatch", "detail", "blend", "glaze", "scumble", "stipple", "wash", "alla_prima"}
local m = rect(100, 100, 200, 200)
local p = pile{{"raw umber", 1}}
for _, h in ipairs(hands) do
  local ok, err = pcall(function() work(m, {hand=h, pile=p, tool=brush{width=20}}) end)
  print("hand", h, ok, err)
end

--@ chunk 12
local m = rect(100, 100, 200, 200)
local p = pile{{"raw umber", 1}}
local ok, err = pcall(function() stipple(m, {pile=p, tool=brush{width=10}}) end)
print("stipple:", ok, err)

--@ chunk 13
local p = pencil{}
print("pencil default:", p)
local c = chalk{}
print("chalk default:", c)
-- Let's see how pencil is used
local ok, err = pcall(function() p:stroke({{100, 100}, {200, 200}}) end)
print("p:stroke:", ok, err)

--@ chunk 14
local p = pencil{}
local methods = {"draw", "line", "stroke", "touch", "mark", "sketch", "apply"}
for _, m in ipairs(methods) do
  if p[m] then print("pencil has:", m) end
end
local ok, err = pcall(function() p({{100, 100}, {200, 200}}) end)
print("p():", ok, err)

--@ chunk 15
local p = pencil{}
local ok, err = pcall(function() p:line({100, 100}, {200, 200}) end)
print("p:line pair:", ok, err)
local ok2, err2 = pcall(function() p:line({{100, 100}, {200, 200}}) end)
print("p:line table:", ok2, err2)
local ok3, err3 = pcall(function() p:sketch({{100, 100}, {200, 200}}) end)
print("p:sketch table:", ok3, err3)

--@ chunk 16
local p1 = poly{{100, 100}, {200, 100}, {150, 200}}
print("poly:", p1)
local r1 = rect(50, 50, 100, 100)
print("rect:", r1)
local e1 = ellipse(200, 200, 50, 30)
print("ellipse:", e1)
local rib = ribbon({{100, 100}, {200, 150}}, 20)
print("ribbon:", rib)

--@ chunk 17
local m = rect(50, 50, 100, 100)
local methods = {"soften", "blur", "feather", "roughen", "band", "edge", "invert", "at"}
for _, name in ipairs(methods) do
  if m[name] then print("mask has:", name) end
end
-- Let's test operators on mask
local ok_not, res_not = pcall(function() return -m end)
print("-m:", ok_not, res_not)
local ok_add, res_add = pcall(function() return m + rect(60, 60, 100, 100) end)
print("m + m2:", ok_add, res_add)
local ok_sub, res_sub = pcall(function() return m - rect(60, 60, 100, 100) end)
print("m - m2:", ok_sub, res_sub)
local ok_mul, res_mul = pcall(function() return m * rect(60, 60, 100, 100) end)
print("m * m2:", ok_mul, res_mul)

--@ chunk 18
local m = rect(50, 50, 100, 100)
local ms = m:soften(10)
print("softened:", ms)
local mb = m:blur(10)
print("blurred:", mb)

--@ chunk 19
-- Material trial: Palette mixing on scratch canvas
p_wall_dark = pile{{"raw umber", 4}, {"bone black", 2}, {"yellow ochre", 1}, {"burnt sienna", 1}}
p_wall_light = pile{{"raw umber", 2}, {"yellow ochre", 3}, {"lead white", 5}, {"green earth", 0.5}}
p_wood = pile{{"raw umber", 5}, {"burnt sienna", 3}, {"bone black", 1}, {"yellow ochre", 1}}
p_linen_body = pile{{"lead white", 8}, {"yellow ochre", 1}, {"raw umber", 0.5}}
p_linen_shadow = pile{{"lead white", 4}, {"raw umber", 2}, {"vine black", 0.5}, {"cobalt blue", 0.3}}
p_terracotta = pile{{"burnt sienna", 4}, {"red earth", 2}, {"yellow ochre", 2}, {"raw umber", 1}}
p_terracotta_light = pile{{"burnt sienna", 2}, {"yellow ochre", 4}, {"lead white", 3}}
p_quince_skin = pile{{"yellow ochre", 4}, {"cadmium yellow", 2}, {"raw sienna", 1}, {"lead-tin yellow", 1}, {"lead white", 1}}
p_quince_flesh = pile{{"lead white", 7}, {"lead-tin yellow", 2}, {"yellow ochre", 0.5}}

print("Piles knifed on scratch canvas:")
print("p_wall_dark:", p_wall_dark)
print("p_terracotta:", p_terracotta)
print("p_quince_skin:", p_quince_skin)

--@ chunk 20
-- Material trial: laid strokes on scratch canvas
local b_broad = brush{width = 40, kind = "flat"}
local b_body = brush{width = 25, kind = "filbert"}

-- Lay a patch of dark wood tabletop
local m_test = rect(50, 450, 400, 200)
work(m_test, {
  hand = "broad",
  pile = p_wood,
  tool = b_broad,
  angle = 0,
  coverage = 1.2,
  fill = true
})

-- Lay a patch of wall behind it
local m_wall_test = rect(50, 100, 400, 350)
work(m_wall_test, {
  hand = "broad",
  pile = p_wall_light,
  tool = b_broad,
  angle = math.pi * 0.15,
  coverage = 1.0,
  fill = true
})

-- Paint an underdrawn and blocked pitcher on it
local m_jug = poly{
  {200, 250}, {230, 250}, {250, 320}, {270, 400}, {260, 500},
  {170, 500}, {160, 400}, {180, 320}
}
work(m_jug, {
  hand = "body",
  pile = p_terracotta,
  tool = b_body,
  angle = math.pi * 0.45,
  coverage = 1.3,
  fill = true
})

--@ chunk 21
-- Material trial: wet into wet modeling on scratch canvas
local m_jug_light = poly{
  {200, 250}, {215, 250}, {225, 320}, {230, 400}, {220, 500},
  {170, 500}, {160, 400}, {180, 320}
}
local b_light = brush{width = 18, kind = "filbert"}
work(m_jug_light, {
  hand = "body",
  pile = p_terracotta_light,
  tool = b_light,
  angle = math.pi * 0.45,
  coverage = 0.9,
  fill = false
})

-- Blend the transition wet into wet
local m_blend = poly{
  {180, 260}, {240, 260}, {250, 480}, {170, 480}
}
work(m_blend, {
  hand = "blend",
  tool = brush{width = 25, kind = "flat"},
  angle = math.pi * 0.45,
  pressure = 0.4
})

--@ chunk 22
local p = pencil{grade = "2B"}
p:line({{100, 100}, {300, 100}})
p:sketch({{100, 120}, {150, 140}, {200, 120}, {250, 150}})

--@ chunk 23
-- Material trial: Wall and table lay-in on scratch canvas
local b_broad = brush{width = 45, kind = "flat"}

-- Knifing palette piles for painting
p_wall_lit = pile{{"lead white", 5}, {"yellow ochre", 3}, {"raw umber", 2}, {"green earth", 0.6}}
p_wall_mid = pile{{"lead white", 2.5}, {"yellow ochre", 2.5}, {"raw umber", 3.5}, {"burnt sienna", 0.5}}
p_wall_shade = pile{{"raw umber", 5}, {"bone black", 2}, {"burnt sienna", 1.5}, {"yellow ochre", 1}}

p_table_top = pile{{"raw umber", 5}, {"burnt sienna", 3.5}, {"bone black", 1}, {"yellow ochre", 1.5}}
p_table_dark = pile{{"raw umber", 6}, {"bone black", 3}, {"burnt sienna", 2}}
p_table_front = pile{{"raw umber", 5}, {"bone black", 4}, {"burnt sienna", 1}}

-- Wall masks: lit upper left, falling off to shade lower right
local m_wall = rect(0, 0, 1000, 480)
local m_wall_left = poly{{0, 0}, {550, 0}, {300, 480}, {0, 480}}
local m_wall_right = poly{{450, 0}, {1000, 0}, {1000, 480}, {250, 480}}

work(m_wall_left, {
  hand = "broad",
  pile = p_wall_lit,
  tool = b_broad,
  angle = math.pi * 0.15,
  coverage = 1.1,
  fill = true
})

work(m_wall_right, {
  hand = "broad",
  pile = p_wall_shade,
  tool = b_broad,
  angle = math.pi * 0.15,
  coverage = 1.1,
  fill = true
})

-- Blend across the wall
work(rect(200, 0, 400, 480), {
  hand = "blend",
  tool = brush{width = 40, kind = "flat"},
  angle = math.pi * 0.15,
  pressure = 0.5
})

--@ chunk 24
-- Refined material trial: seamless atmospheric wall
local b_broad = brush{width = 50, kind = "flat"}

-- 1. Base midtone wall over whole wall area
work(rect(0, 0, 1000, 480), {
  hand = "broad",
  pile = p_wall_mid,
  tool = b_broad,
  angle = math.pi * 0.12,
  coverage = 1.0,
  fill = true
})

-- 2. Sweep lit warm buff into upper-left while wet
work(poly{{0, 0}, {550, 0}, {250, 480}, {0, 480}}, {
  hand = "broad",
  pile = p_wall_lit,
  tool = b_broad,
  angle = math.pi * 0.12,
  coverage = 0.8,
  fill = false
})

-- 3. Sweep deeper shadow into lower-right while wet
work(poly{{400, 0}, {1000, 0}, {1000, 480}, {200, 480}}, {
  hand = "broad",
  pile = p_wall_shade,
  tool = b_broad,
  angle = math.pi * 0.12,
  coverage = 0.9,
  fill = false
})

-- 4. Unclipped large blender across the entire wall
work(rect(0, 0, 1000, 480), {
  hand = "blend",
  tool = brush{width = 60, kind = "flat"},
  angle = math.pi * 0.12,
  pressure = 0.35,
  clip = false
})

--@ chunk 25
-- Material trial: Fig bowl and fig pulp recipes on scratch canvas
p_fig_skin = pile{{"bone black", 3}, {"ultramarine blue", 2}, {"cobalt violet", 2}, {"raw umber", 1}}
p_fig_flesh = pile{{"rose madder", 4}, {"vermilion", 2}, {"burnt sienna", 1}, {"lead white", 1}}
p_bowl_glaze = pile{{"bone black", 4}, {"raw umber", 3}, {"burnt sienna", 1}, {"Prussian blue", 0.5}}

local b_detail = brush{width = 8, kind = "round", point = 0.6}
local m_fig = ellipse(750, 480, 25, 20)
work(m_fig, {
  hand = "body",
  pile = p_fig_skin,
  tool = b_detail,
  angle = math.pi * 0.25,
  coverage = 1.2
})

local m_pulp = ellipse(752, 482, 12, 10)
work(m_pulp, {
  hand = "detail",
  pile = p_fig_flesh,
  tool = b_detail,
  angle = math.pi * 0.25,
  coverage = 1.3
})

--@ chunk 26
local b = brush{width = 6}
local p = pile{{"lead white", 1}}
b:load(p, 0.8)

local function try_touch(...)
  local ok, err = pcall(b.touch, b, ...)
  print("touch args:", ok, err)
end

try_touch(100, 100)
try_touch({100, 100})
try_touch(100, 100, 0.5)
try_touch({100, 100}, 0.5)
try_touch(100, 100, {pressure = 0.5})

--@ chunk 27
local b = brush{width = 6}
local p = pile{{"lead white", 1}}
b:load(p, 0.8)

local function try_stroke(...)
  local ok, err = pcall(b.stroke, b, ...)
  print("stroke args:", ok, err)
end

try_stroke({{100, 100}, {120, 120}})
try_stroke({{100, 100}, {120, 120}}, {pressure = 0.5})
try_stroke({points = {{100, 100}, {120, 120}}, pressure = 0.5})

--@ chunk 28
local m = rect(100, 100, 50, 50)
local ok, err = pcall(function() stipple(m, {invalid_opt = 1}) end)
print("stipple opts:", err)

--@ chunk 29
-- Material trial for Campaign 5 final accents on scratch canvas
p_specular = pile{{"lead white", 8}, {"lead-tin yellow", 1.5}, {"Naples yellow", 0.5}}
p_sign = pile{{"raw umber", 4}, {"burnt sienna", 2}, {"bone black", 1}, medium = 0.3}

local b_point = brush{width = 2.5, kind = "round", point = 0.95}
b_point:load(p_specular, 0.9)
b_point:touch(650, 595, {pressure = 0.5})

-- Test subtle signature strokes
b_point:load(p_sign, 0.7)
b_point:stroke({{860, 725}, {875, 723}, {890, 726}}, {pressure = 0.4})
