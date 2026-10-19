local wx = 470
W_SHAWL = poly({{wx-7,482.5},{wx-8.5,486},{wx-7.5,492},{wx-2,503},{wx,506},{wx+2,503},{wx+7.5,492},{wx+8.5,486},{wx+7,482.5},{wx,480.5}}, true)
local band = rect(400, 482.5, 120, 8)
local mc = (MAN_COAT + MAN_COLLAR) * band
work(mc, {hand="detail", pile=coatP, tool={kind="round", width=1.0, point=0.5}, angle=math.pi/2, length={2,6}, coverage=3.5, clip=true, fill=true, load=0.9})
local mcl = mc * mask(function(x,y) return smoothstep(446-6, 446-10, x) end)
work(mcl, {hand="detail", pile=coatL, tool={kind="round", width=0.9, point=0.5}, angle=math.pi/2, length={2,6}, coverage=1.2, clip=true})
local cream = pile{{"lead white",4},{"yellow ochre",0.45},{"raw umber",0.1},{"pale smalt",0.05}, medium=0.06}
local creamS = pile{{"lead white",2.2},{"yellow ochre",0.4},{"raw umber",0.3},{"pale smalt",0.35}, medium=0.06}
work(W_SHAWL, {hand="detail", pile=cream, tool={kind="round", width=1.0, point=0.5}, angle=0.4, length={2,6}, coverage=3.5, clip=true, fill=true, edge="found", load=0.9})
local ssh = W_SHAWL * mask(function(x,y) return smoothstep(wx+0.5, wx+6, x) end)
work(ssh, {hand="detail", pile=creamS, tool={kind="round", width=0.8, point=0.5}, angle=math.pi/2, length={2,6}, coverage=1.6, clip=true})
-- neck band of hair/head repaired
local hd = ellipse(wx, 475.5, 4.6, 5.6) * rect(460, 479, 20, 4)
work(hd, {hand="detail", pile=hairP, tool={kind="round", width=0.8, point=0.5}, angle=0, length={2,5}, coverage=3, clip=true, fill=true})
print(wait(0))
