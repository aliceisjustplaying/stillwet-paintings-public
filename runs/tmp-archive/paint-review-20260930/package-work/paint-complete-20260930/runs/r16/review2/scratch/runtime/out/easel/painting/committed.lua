-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.

--@ chunk 1
canvas{size=400, aspect=1.25, linen=15, ground={{pile={{"lead white", 1}}, um=100, apply="knife"}}}

--@ chunk 2
p=pile{{"bone black",1}}; q=pile{{"lead white",1},medium=0.3}; m=rect(100,100,100,100); b=brush("filbert",8); b:load(p,0.8); b:stroke({{100,500},{300,520},{500,510}},{pressure={0.9,0.3},ramps={0.05,0.4},orient="across",shake=1,swell={1,1.3,0.8}})

--@ chunk 3
w=world{eye=1.6,fov=45}; s=w:spot(500,600); w,n=w:place(s,body.block(s:p(0,0.5,0),s:size(1,1,1),s:m(0.05))); v=w:view(); print(n)

--@ chunk 4
for _,n in ipairs({"dry","glaze","drawing_mask","sample","rgb","color","mix","palette","show","probe","io","os","debug","require","loadfile","dofile"}) do print(n,type(_G[n])) end

--@ chunk 5
local names={}; for k,v in pairs(_G) do names[#names+1]=k..":"..type(v) end; table.sort(names); print(table.concat(names,"\n")); print(getmetatable(p)); print(getmetatable(b))

--@ chunk 6
work(m,{hand="body",pile=p,angle=0.3,coverage=3}); blend(m,{angle=0}); stipple(m,{pile=p,width=3,coverage=1.2}); work(m,{hand="glaze",pile=q}); lose(m,{pile=p,where=0.5})

--@ chunk 7
h=pencil("2H"); c=chalk(); pts={{100,100},{200,200}}; h:sketch(pts,{pressure=0.3}); h:line(pts,{pressure={0.5,0.7,0.4}}); h:rule({0,400},{1000,400},{pressure=0.3}); h:hatch(m,{angle=-1.1,pressure=0.35}); print(h:width(),h.worn); h:sharpen(); erase(pts,{strength=0.9,width=9}); fix(); print(drawing_guide())

--@ chunk 8
print(wait(3*24*60)); print(drying(200,510))

--@ chunk 9
s=body.ellipsoid({400,500,0},{120,90,80}):turn({400,500,0},0.3,0.1,0):cut({400,430,0},{-0.3,-1,0.4},1,3):rough(6,120,1); k=body.block({650,520,0},{160,60,90},3); t=terrain{area={0,400,1000,800},height=function(x,y) return 10*math.sin(x/60) end}; f=form{{s,dist=0.3},{k},light={from={-1,-0.7},front=0.5,ambient=0.2}}; print(f:value(400,500)); work(f:lit{parts={1}},{pile=p,angle=f:field("fall")})

--@ chunk 10
o=outline{{300,600,"c"},{320,450},{420,380,"c"},{560,400},{650,480,"c"},{500,620},char="firm",seed=3}; work(o:mask(),{hand="body",pile=p}); o:paint(b,{pressure=0.8,dip={p,0.6},every=3})

--@ chunk 11
print(wait(5259600)); print(drying(200,510)); varnish{coats=0.4,vary=0.12}; relief(0.3,0.02)

--@ chunk 12
print(wait(0))

--@ chunk 13
print("file chunk accepted")

--@ chunk 14
print("stdin chunk accepted")

--@ chunk 15
cracks{}
