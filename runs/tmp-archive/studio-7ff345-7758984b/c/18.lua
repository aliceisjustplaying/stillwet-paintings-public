-- the oak's skeleton, drawn by hand: trunk and main boughs {points, widths}
oakB = {
 trunk = {pts={{238,432},{236,405},{239,375},{236,345},{238,318},{240,300}}, w={70,56,48,44,42,40}},
 L1 = {pts={{230,310},{205,290},{180,272},{150,258},{122,254},{95,258},{68,252},{44,258}}, w={22,18,15,12,10,8,6,4}},
 L2 = {pts={{230,300},{222,268},{214,238},{202,205},{186,176},{170,152},{158,126}}, w={20,17,15,12,10,8,6}},
 L3 = {pts={{240,296},{244,262},{247,228},{240,196},{242,165},{250,136},{246,104},{240,78}}, w={22,19,17,15,13,11,10,9}, dead=true},
 L4 = {pts={{248,298},{262,272},{280,244},{296,214},{306,186},{316,160},{314,130},{322,104}}, w={18,16,14,12,10,9,8,7}, dead=true},
 L5 = {pts={{250,318},{280,305},{312,296},{346,292},{378,297},{410,302},{442,296},{468,300}}, w={22,17,14,12,10,8,6,4}},
 L6 = {pts={{230,348},{210,340},{190,337},{176,341}}, w={11,9,8,8}, dead=true},
}
bark = pile{{"raw umber",2},{"bone black",1.2},{"smalt",0.5},{"lead white",0.35}, medium=0.1}
deadwood = pile{{"lead white",1.3},{"raw umber",1},{"bone black",0.55},{"smalt",0.2}, medium=0.1}
local function limbmask(b)
  return ribbon(b.pts, b.w):roughen(0.8, 5, 7)
end
oakLive = limbmask(oakB.trunk)
for _, k in ipairs({"L1","L2","L5"}) do oakLive = oakLive + limbmask(oakB[k]) end
oakDead = limbmask(oakB.L3)
for _, k in ipairs({"L4","L6"}) do oakDead = oakDead + limbmask(oakB[k]) end
oakDead = oakDead - oakLive
oakMain = oakLive + oakDead
work(oakLive, {hand="detail", pile=bark, load=1, pressure={0.6, 0.9}, coverage=3.5, fill=true,
   angle=function(x, y) return -math.pi/2 end, angle_jitter=0.3})
work(oakDead, {hand="detail", pile=deadwood, load=1, pressure={0.6, 0.9}, coverage=3.5, fill=true,
   angle=function(x, y) return -math.pi/2 end, angle_jitter=0.3})
