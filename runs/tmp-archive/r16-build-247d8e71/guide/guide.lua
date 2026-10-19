--@ chunk 1
canvas{size=400, aspect=1.25, linen={16, 14}, seed=1,
       ground={{pile={{"lead white", 2}, {"red earth", 1}}, um=100, apply="knife", texture=0.3},
               {pile={{"lead white", 6}, {"yellow ochre", 1}}, um=50, apply="brush"}}}
--@ chunk 2
p = pile{{"lead white", 6}, {"smalt", 1}, {"yellow ochre", 0.5}}
q = pile{{"bone black", 1}, {"raw umber", 2}, medium=0.3}
print(p)
print(table.concat(tubes(), ", "))
m = rect(100, 100, 200, 200)
b = brush("filbert", 8)
b = brush{kind="round", width=3, point=1, stiffness=0.5}
b:load(p, 0.8)
b:reload(q, 0.8)
b:wipe(0.85)
print(b:fullness())
b:load(p, 0.8)
b:stroke({{100, 500}, {300, 520}, {500, 510}},
  {pressure={0.9, 0.3}, ramps={0.05, 0.4}, orient="across", shake=1, swell={1, 1.3, 0.8}, clip=m})
b:touch(400, 300, {pressure=0.6, drag={1, 0}, twist=0.2, angle=0.3, clip=m})
print(b:mark_width(0.4), b:pressure_for(0.5))
--@ chunk 3
work(m, {hand="body", pile=p, angle=0.3, coverage=3})
blend(m, {angle=0})
stipple(m, {pile=p, width=3, coverage=1.2})
print(wait(60 * 24 * 60))
glaze(m, {pile=pile{{"raw umber", 1}, medium=0.9}, coats=0.4})
print(lose(m, {pile=p, where=0.5}))
work(ellipse(600, 400, 100, 80), {hand="broad", pile=q, edge={found=0.3, soft=0.4, lost=0.3, period=40}, ruler=true, fill=false})
--@ chunk 4
local a = everywhere() - rect(10, 10, 100, 100) + ellipse(500, 400, 100, 50)
local c = poly({{100, 100}, {200, 100}, {150, 200}}, true) * below(function(x) return 400 + 30 * math.sin(x / 90) end)
local d = above({{0, 300}, {1000, 350}}) - ribbon({{0, 0}, {100, 100}}, 3) + mask(function(x, y) return x < 500 and 1 or 0 end)
d = -d
d = d:roughen(3, 40, 1, 1):soften(2):blur(1):grow(1):shrink(1):offset(1):rim(3, 1)
d = d:distance():band(0, 3, 1):times(function(x, y) return 1 end):map(function(v) return v * v end)
print(d:at(10, 10), d:area())
local n = noise{seed=3, octaves=4, period=200, persistence=0.5, kind="ridged", warp={80, 25, true}, stretch={0.2, 4}}
print(n(1, 2), n:at01(1, 2))
local cc = worley{seed=2, period=30}
print(cc:at(3, 4))
print(#uneven(9, 120, 860, 0.6, 0.4, 5), lerp(0, 1, 0.5), clamp(2, 0, 1), smoothstep(0, 1, 0.5), rand(1, 2), randn(0, 1))
o = outline{{300, 600, "c"}, {320, 450}, {420, 380, "c"}, {560, 400}, {650, 480, "c"}, {500, 620}, char="firm", seed=3}
work(o:mask(), {hand="body", pile=p})
print(o:paint(b, {pressure=0.8, dip={p, 0.6}, every=3}))
local s = body_of{spine={{100,500},{110,499},{120,500},{126,497},{130,499}}, widths={9,11,10,5,4}, limbs={{{102,502},{102,510}, widths={1.3, 0.9}}}, char="soft"}
print(s:mask():area(), o:length(), #o:corners(), #o:paths(), #o:path(1), #o:strokes(), o:at(0.5))
--@ chunk 5
h = pencil("2H")
c = chalk()
pts = {{100, 100}, {200, 150}, {300, 120}}
h:sketch(pts, {pressure=0.3})
h:line(pts, {pressure={0.5, 0.7, 0.4}})
h:rule({0, 400}, {1000, 400}, {pressure=0.3})
h:hatch(rect(100, 100, 50, 50), {angle=-1.1, pressure=0.35})
print(h:width(), h.worn); h:sharpen()
erase(pts, {strength=0.9, width=9})
fix()
print(drawing_mask():area(), drawing_guide():area())
--@ chunk 6
s = body.ellipsoid({400, 500, 0}, {120, 90, 80}):turn({400, 500, 0}, 0.3, 0.1, 0)
      :cut({400, 430, 0}, {-0.3, -1, 0.4}, 1, 3):rough(6, 120, 1)
k = body.block({650, 520, 0}, {160, 60, 90}, 3)
t = terrain{area={0, 400, 1000, 800}, height=function(x, y) return 10 * math.sin(x / 60) end}
f = form{ {s, dist=0.3}, {k}, light={from={-1, -0.7}, front=0.5, ambient=0.2} }
print(f:value(400, 500), f:lit_at(400, 500, 0.1), f:part(400, 500), f:fall(400, 500), f:across(400, 500))
local _ = f:lit{parts={1}, soft=0.12} + f:shadow{parts={1}} + f:silhouette{parts={1}} + f:edges{turn=0.8} + f:parts_mask{1}
work(f:lit{parts={1}}, {pile=p, angle=f:field("fall")})
--@ chunk 7
w = world{horizon=H * 0.5, eye=1.6, fov=45, sun={azimuth=-120, elevation=30},
          ground=function(X, Z) return 0 end, water={level=-0.5}}
s = w:spot(500, 600)
w, n = w:place(s, body.block(s:p(0, 0.5, 0), s:size(1, 1, 1), s:m(0.05)))
w = w:layer("a", rect(100, 500, 20, 40), {110, 540})
v = w:view()
local _ = v:land() + v:water() + v:sky() + v:shadows() + v:contact(0.25) + v:reflections() + v:bodies_mask{n}
print(v:at(500, 600).what, v:mirror(500, 700), v.form)
print(w:to_ground(500, 600), w:project(0, 0, 10), w:scale_at(10), w:height(500, 600, 2), w:aerial(1000))
print(w:shadow_angle(500, 600), w:sun_canvas(), w:ribbon({{0, 5}, {1, 10}}, 1), #w:recede({0, 5}, {0, 2}, 4))
local _ = v:visible("a") + v:front("a") + v:behind("a") + v:at_depth(20) + v:between(5, 30) + v:cast_shadow{soft=1} + v:contact_shadow{reach=0.3}
print(#v:seen(110, 530), aerial(1000, 20000))
work(rect(0, 0, 1000, 800), {pile=q, coverage=0.5, behind="a"})
--@ chunk 8
print(wait(90 * 24 * 60))
varnish{coats=0.4, vary=0.12}
cracks{}
relief(0.3, 0.02)
print(drying(500, 500))
