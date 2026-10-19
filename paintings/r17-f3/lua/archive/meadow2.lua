local nz = noise{seed=77, period=120, octaves=3}
KEEP = TOWN:grow(0.5) + FARTREES + MILL:grow(1) + RIVER
LANDC = LAND - KEEP
local function zone(a, b, amp)
  return mask(function(x,y)
    local yy = y + amp*nz(x, y*3)
    return smoothstep(a-4, a+4, yy) * (1 - smoothstep(b-4, b+4, yy)) end) * LANDC
end
G = {
 far = pile{{"lead white",3},{"green earth",1.4},{"pale smalt",0.7},{"yellow ochre",0.8},{"raw umber",0.1}, medium=0.1},
 lit = pile{{"lead white",1.5},{"yellow ochre",2},{"chrome yellow",0.6},{"Prussian blue",0.15},{"green earth",0.8}, medium=0.1},
 mid = pile{{"lead white",0.8},{"yellow ochre",1.6},{"Prussian blue",0.3},{"green earth",1.2},{"raw umber",0.3}, medium=0.1},
 sh  = pile{{"lead white",0.5},{"yellow ochre",1},{"Prussian blue",0.4},{"raw umber",0.9},{"green earth",1.2}, medium=0.1},
 dark= pile{{"raw umber",1.2},{"Prussian blue",0.45},{"yellow ochre",0.8},{"green earth",1},{"bone black",0.15}, medium=0.1},
}
local Z = {
 {G.far, -100, 499, 3, "filbert 5", {10,30}},
 {G.lit, 497, 521, 5, "filbert 6", {15,40}},
 {G.sh, 519, 546, 6, "filbert 6", {15,45}},
 {G.lit, 544, 598, 8, "filbert 8", {20,55}},
 {G.mid, 596, 640, 10, "filbert 9", {25,60}},
 {G.dark, 636, 800, 10, "filbert 10", {25,70}},
}
for i,z in ipairs(Z) do
  work(zone(z[2], z[3], z[4]), {hand="body", pile=z[1], tool=z[5], clip=LANDC, angle=function(x,y) return -0.02 + 0.05*math.sin(x/150+y/40) end, angle_jitter=0.06, length=z[6], coverage=1.5, fill=true, load=0.6, threshold=0.5})
end
print(wait(0))
